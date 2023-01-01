//
//  ContentView.swift
//  BaBI
//
//  Created by Justin Szaro on 12/14/22.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) private var productResults : FetchedResults<Product>
    @State private var isPresented: Bool = false
    @State private var searchText: String = ""
    
    
    private func deleteProduct(offsets: IndexSet) {
        withAnimation {
            offsets.map { productResults[$0] }
            .forEach(viewContext.delete)
            
            // Saves to our database
            CoreDataManager().save(viewContext: viewContext)
        }
    }
    
    private func getTotalProducts() -> Int {
        return productResults.count
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Total Number of Products: \(getTotalProducts())")
                    .foregroundColor(.gray)
                    .padding([.horizontal])
                List {
                    ForEach(productResults) { product in
                        NavigationLink(destination: EditProductView(product: product)) {
                            HStack {
                                if product.is_travel_size {
                                    Text(product.name ?? "")
                                        .bold()
                                        .foregroundColor(.green)
                                } else {
                                    Text(product.name ?? "")
                                        .bold()
                                }
                                Spacer()
                                Text(product.type ?? "")
                            }
                        }
                    }
                    .onDelete(perform: deleteProduct)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Products:")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Label("Add product", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                }
            }
            .sheet(isPresented: $isPresented) {
                AddProductView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView().environment(\.managedObjectContext, CoreDataManager.shared.persistentContainer.viewContext)
        }
        
    }
}
