//
//  CardDetailsRepository.swift
//  Cat-Demo
//
//  Created by Rahul Adepu on 4/29/26.
//

import Foundation

protocol CatDetailsRepository{
    func getCatDetaiils() -> CatBreed?
    func getCatImageForDetailsDetaiils(breedId: String, completion:@escaping (Result<Data, Error>) -> Void)
}
