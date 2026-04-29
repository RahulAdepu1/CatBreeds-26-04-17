//
//  CardDetailsRepository.swift
//  Cat-Demo
//
//  Created by Rahul Adepu on 4/29/26.
//

import Foundation
import UIKit

protocol CatDetailsRepository{
    func getCatDetaiils() -> CatBreed?
    func getCatImageForDetailsDetaiils(breedId: String, completion:@escaping (Result<UIImage, Error>) -> Void)
}
