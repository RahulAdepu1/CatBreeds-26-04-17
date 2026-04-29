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
                if let imageData = viewModel.image,
                let uiImage = UIImage(data: imageData){
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }
                
            }
            .background(.blue)
            .onAppear{
                viewModel.getCatImage()
            }
            
        }
}

//#Preview {
//    CatDetailsViewB()
//}
