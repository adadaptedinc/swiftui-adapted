//
//  ShoppingListView.swift
//  SwiftUIAdapted
//
//  Created by Brett Clifton on 1/16/24.
//

import SwiftUI
import adadapted_swift_sdk

struct ShoppingListView: View {
    @StateObject private var viewModel = ShoppingListViewModel()
    @State private var wrapperUUID = UUID()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.shoppingItems, id: \.self) { item in
                        Text(item)
                    }
                    .onDelete(perform: viewModel.removeItems)
                }
                .refreshable {
                    await refreshItems()
                }
                
                AaZoneViewSwiftUI(zoneId: "102110", zoneListener: viewModel, contentListener: viewModel)
                    .id(wrapperUUID)
                    .frame(width: CGFloat(UIScreen.main.bounds.width), height: 80)
                
                HStack {
                    TextField("New Item", text: $viewModel.newItem)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: viewModel.addItem) {
                        Text("Add")
                    }
                }
                .padding()
            }
            .navigationTitle("Shopping List")
        }
    }
    
    func refreshItems() async {
        wrapperUUID = UUID()
        //viewModel.refreshItems()
    }
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}
