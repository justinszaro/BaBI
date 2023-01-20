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
    
    func readCSV(inputFile: String) {
            if let filepath = Bundle.main.path(forResource: inputFile, ofType: nil) {
                do {
                    let fileContent = try String(contentsOfFile: filepath)
                    let lines = fileContent.components(separatedBy: "\n")
                    lines.dropFirst().forEach { line in
                        let data = line.components(separatedBy: ",")
                        if data.count != 1 {
                            scent_notes = [data[3], data[4], data[5], data[6], data[7]]
                            coreDataManager.saveProduct(name: data[1], type: data[2], scent_notes: scent_notes, year: data[8], season: data[9], is_travel_size: Bool(data[11].lowercased()) ?? false, is_aromatherapy: Bool(data[10].lowercased()) ?? false, viewContext: viewContext)
                        }
                    }
                } catch {
                    print("error: \(error)") // to do deal with errors
                }
            } else {
                print("\(inputFile) could not be found")
            }
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
                    Button("Import") {
                        readCSV(inputFile: "Backup.csv")
                        dismiss()
                    }
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
