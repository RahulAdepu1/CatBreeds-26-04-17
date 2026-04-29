//
//  CatDetailsViewModel.swift
//  Cat-Demo
//
//  Created by Rahul Adepu on 4/29/26.
//

import Foundation
import UIKit

class CatDetailsViewModelNew: ObservableObject{
    @Published var breed: CatBreed?
    @Published var image: UIImage?
    
    let useCase: CatDetailsUseCase
    
    init(breed: CatBreed? = nil,useCase: CatDetailsUseCase) {
        self.breed = breed
        self.useCase = useCase
        
    }
    
    @MainActor
    func getCatImage(){
        useCase.getCatImage(breedId: breed?.id ?? "1") { result in
            switch result
            {
            case .success(let image):
                self.image = image
            case .failure(let error):
                print(error)
                
            }
        }
    }
    
   
}
