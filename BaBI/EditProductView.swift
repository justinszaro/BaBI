//
//  EditProductView.swift
//  BaBI
//
//  Created by Justin Szaro on 12/14/22.
//

import SwiftUI

struct EditProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss)  private var dismiss
    
    @State private var coreDataManager = CoreDataManager()
    @State private var name: String = ""
    @State private var type: String = ""
    @State private var scent_notes: [String] = ["", "", "", "", ""]
    @State private var year: String = ""
    @State private var season: String = ""
    @State private var is_travel_size: Bool = false
    @State private var is_aromatherapy: Bool = false
    
    var product: FetchedResults<Product>.Element
    
    
    var isFormValid: Bool {
        !name.isEmpty && !type.isEmpty
    }
    
    var body: some View {
        Form {
            Section(header: Text("Name and Type: ")) {
                TextField("\(product.name!)", text: $name)
                    .onAppear {
                        name = product.name ?? "Product"
                        type = product.type ?? "Type"
                        scent_notes = product.scent_notes ?? ["", "", "", "", ""]
                        year = product.year ?? ""
                        season = product.season ?? ""
                        is_travel_size = product.is_travel_size
                        is_aromatherapy = product.is_aromatherapy
                    }
                TextField("\(product.type!)", text: $type)
            }
            Section(header: Text("Scent Notes:")) {
                
                TextField("\(product.scent_notes?[0] ?? "")", text: $scent_notes[0])
                TextField("\(product.scent_notes?[1] ?? "")", text: $scent_notes[1])
                TextField("\(product.scent_notes?[2] ?? "")", text: $scent_notes[2])
                TextField("\(product.scent_notes?[3] ?? "")", text: $scent_notes[3])
                TextField("\(product.scent_notes?[4] ?? "")", text: $scent_notes[4])
            }
            Section(header: Text("Year:")) {
                TextField("\(product.year ?? "")", text: $year)
            }
            Section(header: Text("Season")) {
                TextField("\(product.season ?? "")", text: $season)
            }
            Section(header: Text("Additional Info: ")) {
                Toggle(isOn: $is_travel_size) {
                    Text("Travel Size: ")
                }
                Toggle(isOn: $is_aromatherapy) {
                    Text("Aromatherapy: ")
                }
            }
            Section {
                HStack {
                    Spacer()
                    Button("Submit") {
                        coreDataManager.editProduct(product: product, name: name, type: type, scent_notes: scent_notes, year: year, season: season, is_travel_size: is_travel_size, is_aromatherapy: is_aromatherapy, viewContext: viewContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
}
