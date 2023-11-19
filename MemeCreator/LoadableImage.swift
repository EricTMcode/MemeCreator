//
//  LoadableImage.swift
//  MemeCreator
//
//  Created by Eric on 19/11/2023.
//

import SwiftUI

struct LoadableImage: View {
    var imageMetaData: Panda
    
    var body: some View {
        AsyncImage(url: imageMetaData.imageUrl) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .accessibilityHidden(false)
                    .accessibilityLabel(Text(imageMetaData.description))
            } else if phase.error != nil {
                VStack {
                    Image(.pandaplaceholder)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 300)
                    Text("The pandas were all busy.")
                        .font(.title2)
                    Text("Please try again.")
                        .font(.title3)
                }
            } else {
                ProgressView()
            }
        }
    }
}

#Preview {
    LoadableImage(imageMetaData: Panda.defaultPanda)
}
