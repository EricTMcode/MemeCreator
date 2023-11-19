//
//  MemeCreatorApp.swift
//  MemeCreator
//
//  Created by Eric on 19/11/2023.
//

import SwiftUI

@main
struct MemeCreatorApp: App {
    @StateObject private var fetcher = PandaCollectionFetcher()
    
    var body: some Scene {
        WindowGroup {
            MemeCreator()
                .environmentObject(fetcher)
        }
    }
}
