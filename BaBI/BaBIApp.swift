//
//  BaBIApp.swift
//  BaBI
//
//  Created by Justin Szaro on 12/14/22.
//

import SwiftUI

@main
struct BaBIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, CoreDataManager.shared.persistentContainer.viewContext)
        }
    }
}
