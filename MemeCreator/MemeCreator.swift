//
//  MemeCreator.swift
//  MemeCreator
//
//  Created by Eric on 19/11/2023.
//

import SwiftUI

struct MemeCreator: View {
    @EnvironmentObject var fetcher: PandaCollectionFetcher
    
    @State private var memeText = ""
    @State private var textSize = 60.0
    @State private var textColor = Color.white
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Spacer()
                LoadableImage(imageMetaData: fetcher.currentPanda)
                    .overlay(alignment: .bottom) {
                        TextField("Meme Text", text: $memeText, prompt: Text(""))
                            .focused($isFocused)
                            .font(.system(size: textSize, weight: .heavy))
                            .shadow(radius: 10)
                            .foregroundStyle(textColor)
                            .padding()
                            .multilineTextAlignment(.center)
                    }
                    .frame(minHeight: 150)
                
                Spacer()
                
                if !memeText.isEmpty {
                    VStack {
                        HStack {
                            Text("Font Size")
                                .fontWeight(.semibold)
                            Slider(value: $textSize, in: 20...140)
                        }
                        
                        HStack {
                            Text("Font Color")
                                .fontWeight(.semibold)
                            ColorPicker("Font Color", selection: $textColor)
                                .labelsHidden()
                                .frame(width: 124, height: 23, alignment: .leading)
                            
                            Spacer()
                        }
                    }
                    .padding(.vertical)
                    .frame(maxWidth: 325)
                }
                
                HStack {
                    Button {
                        if let randomImage = fetcher.imageData.sample.randomElement() {
                            fetcher.currentPanda = randomImage
                        }
                    } label: {
                        VStack {
                            Image(systemName: "photo.on.rectangle.angled")
                                .font(.largeTitle)
                                .padding(.bottom, 4)
                            Text("Shuffle Photo")
                        }
                        .frame(maxWidth: 180, maxHeight: .infinity)
                    }
                    
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    
                    Button {
                        isFocused = true
                    } label: {
                        VStack {
                            Image(systemName: "textformat")
                                .font(.largeTitle)
                                .padding(.bottom, 4)
                            Text("Add Text")
                        }
                        .frame(maxWidth: 180, maxHeight: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                }
                .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                .frame(maxHeight: 180, alignment: .center)
            }
            
            .padding()
            .navigationTitle("Meme Creator")
            .task {
                try? await fetcher.fecthData()
            }
        }
    }
}

#Preview {
    MemeCreator()
        .environmentObject(PandaCollectionFetcher())
}
