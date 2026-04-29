//
//  CatDetailsRepositoryImplementation.swift
//  Cat-Demo
//
//  Created by Rahul Adepu on 4/29/26.
//

import Foundation
import UIKit


class CatDetailsRepositoryImplementation {
    let networkService: Networkable
    init(networkService: Networkable) {
        self.networkService = networkService
    }
    
}
extension CatDetailsRepositoryImplementation:CatDetailsRepository{
    func getCatDetaiils() -> CatBreed? {
        return nil
    }
    
    func getCatImageForDetailsDetaiils(breedId: String, completion:@escaping (Result<UIImage, Error>) -> Void) {
        self.networkService.fetchCatImage(breedId: breedId)  { (result) in
                    switch result
                    {
                    case .success(let image):
                        completion(.success(image))
                        
                    case .failure(let error):
                        print(error)
                        completion(.failure(error))
                    }
                }
    }
    
    
}
