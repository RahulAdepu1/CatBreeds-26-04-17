//
//  CatDetailsUseCase.swift
//  Cat-Demo
//
//  Created by Rahul Adepu on 4/29/26.
//

import Foundation
import UIKit

protocol CatDetailsUseCase{
    func execute() -> CatBreed?

    func getCatImage(breedId: String, completion:@escaping (Result<UIImage, Error>) -> Void)
}
