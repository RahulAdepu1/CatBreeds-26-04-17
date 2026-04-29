// Copyright © 2021 Intuit, Inc. All rights reserved.
import Foundation
import UIKit

/// Basic Delegate interface to send messages
protocol CatDataDelegate {
    func breedsChangedNotification()
}

/// View model
@MainActor
final class ViewModel {
    var catDataDelegate: CatDataDelegate?
    var filteredBreeds: [CatBreed] = []
    
    /// Private properties
    private var currentPage: Int = 0
    private let pageLimit: Int = 20
    private var isLoading: Bool = false
    private var hasMoreData: Bool = true
    private let networkService: Networkable
    
    /// Array of cat breeds
    var catBreeds: [CatBreed]? {
        didSet {
            self.catDataDelegate?.breedsChangedNotification()
        }
    }
    
    init(networkService: Networkable = Network()) {
        self.networkService = networkService
    }
    
    func getCatBreedList(_ isFiltering: Bool = false) -> [CatBreed]? {
        if isFiltering {
            return self.filteredBreeds
        }
        return self.catBreeds
    }
    
    func getBreeds() {
        currentPage = 0
        hasMoreData = true
        isLoading = false
        DispatchQueue.main.async {
            self.catBreeds = []
        }
        fetchNextPage()
    }
    
    /// Get the breeds
    func fetchNextPage() {
        
        guard !isLoading, hasMoreData else { return }
        self.isLoading = true
        
        self.networkService.fetchCatBreeds(limit: pageLimit, page: currentPage) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result
                {
                case .success(let breeds):
                    if breeds.isEmpty {
                        self.hasMoreData = false
                        return
                    }
                    if self.catBreeds == nil { self.catBreeds = [] }
                    self.catBreeds?.append(contentsOf: breeds)
                    self.currentPage += 1
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func searchCatBreeds(for searchText: String) {
        guard let catBreeds else { return }
        
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            self.filteredBreeds = catBreeds
        } else {
            self.filteredBreeds = catBreeds.filter { breed in
                let name = breed.name ?? ""
                return name.range(of: searchText, options: .caseInsensitive) != nil
            }
        }
        self.catDataDelegate?.breedsChangedNotification()
    }
}
