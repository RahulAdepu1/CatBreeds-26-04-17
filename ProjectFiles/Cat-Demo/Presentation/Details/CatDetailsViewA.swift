//
//  CatDetailsViewA.swift
//  Cat-Demo
//
//  Created by Rahul Adepu on 4/29/26.
//

import SwiftUI

struct CatDetailsViewA: View {
    @ObservedObject var viewModel: CatDetailsViewModelNew
    
    var body: some View {
        VStack{
            Text(viewModel.breed?.name ?? "No Name")
            Text(viewModel.breed?.description ?? "no description")
            if let image = viewModel.image{
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            
        }.background(.red)
            .onAppear{
                viewModel.getCatImage()
            }
        
    }
}

//#Preview {
//    CatDetailsViewA()
//}
