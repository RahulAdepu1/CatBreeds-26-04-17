//
//  CatDetailsUseCaseImplemention.swift
//  Cat-Demo
//
//  Created by Rahul Adepu on 4/29/26.
//

import Foundation

// any anctions given by viewmodel and that we can get donee byt repository
class CatDetailsUseCaseImplemention{
    
    let repository: CatDetailsRepository
    init(repository: CatDetailsRepository) {
        self.repository = repository
    }
}

extension CatDetailsUseCaseImplemention: CatDetailsUseCase{
    func execute() -> CatBreed? {
        return nil
    }
    func getCatImage(breedId: String, completion:@escaping (Result<Data, Error>) -> Void) {
        self.repository.getCatImageForDetailsDetaiils(breedId: breedId) { result in
            switch result
                   {
                   case .success(let image):
                       completion(.success(image))
                       
                   case .failure(let error):
                       print(error)
                       completion( .failure(error))
                   }
        }
       
    }
    
}
