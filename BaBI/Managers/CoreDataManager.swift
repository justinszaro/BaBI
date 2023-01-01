//
//  CoreDataManager.swift
//  BaBI
//
//  Created by Justin Szaro on 12/14/22.
//

import Foundation
import CoreData

class CoreDataManager {
        
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "ProductModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Unable to load Core Data Model (\(error))")
            }
        }
    }
    
    func save(viewContext: NSManagedObjectContext) {
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    func saveProduct(name: String, type: String, scent_notes: [String], year: String, season: String, is_travel_size: Bool, is_aromatherapy: Bool, viewContext: NSManagedObjectContext) {
        let product = Product(context: viewContext)
        product.name = name
        product.type = type
        product.scent_notes = scent_notes
        product.year = year
        product.season = season
        product.is_travel_size = is_travel_size
        product.is_aromatherapy = is_aromatherapy
        
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    func editProduct(product: Product, name: String, type: String, scent_notes: [String], year: String, season: String, is_travel_size: Bool, is_aromatherapy: Bool, viewContext: NSManagedObjectContext) {
        product.name = name
        product.type = type
        product.scent_notes = scent_notes
        product.year = year
        product.season = season
        product.is_travel_size = is_travel_size
        product.is_aromatherapy = is_aromatherapy
        
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    
}
