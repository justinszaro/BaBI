//
//  AddProductView.swift
//  BaBI
//
//  Created by Justin Szaro on 12/14/22.
//

import SwiftUI

struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var type: String = ""
    @State private var scent_notes: [String] = ["", "", "", "", ""]
    @State private var year: String = ""
    @State private var season: String = ""
    @State private var is_travel_size: Bool = false
    @State private var is_aromatherapy: Bool = false
    
    @State private var coreDataManager = CoreDataManager()
    
    var isFormValid: Bool {
        !name.isEmpty && !type.isEmpty
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Name and Type: ")) {
                    TextField("Name", text: $name)
                    TextField("Type", text: $type)
                }
                Section(header: Text("Scent Notes: ")) {
                    TextField("", text: $scent_notes[0])
                    TextField("", text: $scent_notes[1])
                    TextField("", text: $scent_notes[2])
                    TextField("", text: $scent_notes[3])
                    TextField("", text: $scent_notes[4])
                }
                Section(header: Text("Year: ")) {
                    TextField("Year", text: $year)
                }
                Section(header: Text("Season: ")) {
                    TextField("Season", text: $season)
                }
                Section(header: Text("Additional Info: ")) {
                    Toggle(isOn: $is_travel_size) {
                        Text("Travel Size: ")
                    }
                    Toggle(isOn: $is_aromatherapy) {
                        Text("Aromatherapy: ")
                    }
                }
                HStack {
                    Spacer()
                    Button("Save") {
                        if isFormValid {
                            coreDataManager.saveProduct(name: name, type: type, scent_notes: scent_notes, year: year, season: season, is_travel_size: is_travel_size, is_aromatherapy: is_aromatherapy, viewContext: viewContext)
                            dismiss()
                        }
                    }.disabled(!isFormValid)
                    Spacer()
                }
            }
        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddProductView()
        }
    }
}
