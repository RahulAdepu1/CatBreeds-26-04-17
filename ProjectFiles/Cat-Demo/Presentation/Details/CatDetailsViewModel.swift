//
//  CatDetailsViewModel.swift
//  Cat-Demo
//
//  Created by Rahul Adepu on 4/17/26.
//

import Foundation
import UIKit

protocol CatImageDelegate {
    func imageChangedNotification()
}

final class CatDetailsViewModel:ObservableObject {
    
    var catImageDelegate: CatImageDelegate?
    let networkService: Networkable
    @Published  var breed: CatBreed?
    /// Image of the cat
    var catImage: Data? {
        didSet {
            self.catImageDelegate?.imageChangedNotification()
        }
    }
    
    init(networkService: Networkable = Network()) {
        self.networkService = networkService
    }
    
    func getCatImage(breedId: String) {
        self.networkService.fetchCatImage(breedId: breedId) { (result) in
            switch result
            {
            case .success(let image):
                self.catImage = image
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
