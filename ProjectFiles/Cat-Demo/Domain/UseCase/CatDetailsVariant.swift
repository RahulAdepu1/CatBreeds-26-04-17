//
//  CatDetailsVariant.swift
//  Cat-Demo
//
//  Created by Rahul Adepu on 4/29/26.
//

import Foundation

enum CatDetailsVariantType: String, CaseIterable {
    case caseA
    case caseB
    case caseC
}

func getRandomVariant() -> CatDetailsVariantType {

    let count = CatDetailsVariantType.allCases.count
    let randomIndex = Int.random(in: 0..<count)
    
    switch randomIndex {
    case 0:
        return .caseA
    case 1:
        return .caseB
    case 2:
        return .caseC
    default:
        return .caseA
    }
    

}


