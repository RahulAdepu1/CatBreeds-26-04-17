//
//  CatDetailsFactory.swift
//  Cat-Demo
//
//  Created by Rahul Adepu on 4/29/26.
//

import Foundation
import SwiftUI

struct CatDetailsFactory{
    static func makeView(
        variant: CatDetailsVariantType,
        viewModel: CatDetailsViewModelNew,
        catbreed: CatBreed? = nil
    ) -> UIViewController{
        
        let anyView: AnyView
        
        switch variant {
        case .caseA:
            anyView = AnyView(CatDetailsViewA(viewModel: viewModel))
            return UIHostingController(rootView: anyView)
        case .caseB:
            anyView = AnyView(CatDetailsViewB(viewModel: viewModel))
            return UIHostingController(rootView: anyView)
        case .caseC:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let catDetailsVC = storyboard.instantiateViewController(withIdentifier: "CatDetailsViewController") as! CatDetailsViewController
            catDetailsVC.breed = catbreed
            return catDetailsVC
        }
        
        
    }
}
