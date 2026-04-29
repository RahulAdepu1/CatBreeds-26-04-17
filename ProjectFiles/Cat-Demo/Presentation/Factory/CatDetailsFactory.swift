//
//  CatDetailsFactory.swift
//  Cat-Demo
//
//  Created by Rahul Adepu on 4/29/26.
//

import Foundation

import SwiftUI

struct CatDetailsFactory{
    
    static func makeView(isVariant: Bool, viewModel:CatDetailsViewModelNew) -> UIViewController{
        
        let anyView: AnyView
        
        if isVariant{
            anyView = AnyView(CatDetailsViewA(viewModel: viewModel))
        }else{
            anyView = AnyView(CatDetailsViewB(viewModel: viewModel))
        }
        
        return UIHostingController(rootView: anyView)
    }
}
