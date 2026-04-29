//
//  CatDetailsViewB.swift
//  Cat-Demo
//
//  Created by Rahul Adepu on 4/29/26.
//

import SwiftUI

struct CatDetailsViewB: View {
    @ObservedObject var viewModel: CatDetailsViewModelNew
        
        var body: some View {
            VStack{
                Text(viewModel.breed?.name ?? "No Name")
                Text(viewModel.breed?.description ?? "no description")
            }.background(.blue)
            
        }
}

//#Preview {
//    CatDetailsViewB()
//}
