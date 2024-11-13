//
//  ShoppingListView.swift
//  SwiftUIAdapted
//
//  Created by Brett Clifton on 1/16/24.
//

import SwiftUI
import adadapted_swift_sdk

struct ShoppingListTabView: View {
    var body: some View {
        TabView {
            ShoppingListView(listName: "Groceries", zoneId: "102110")
                .tabItem {
                    Label("Groceries", systemImage: "cart")
                }
            
            ShoppingListView(listName: "Household Items", zoneId: "110002")
                .tabItem {
                    Label("Household", systemImage: "house")
                }
            
            ShoppingListView(listName: "Electronics", zoneId: "110003")
                .tabItem {
                    Label("Electronics", systemImage: "tv")
                }
        }
    }
}

struct ShoppingListView: View {
    let listName: String
    let zoneId: String
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
                
                AaZoneViewSwiftUI(zoneId: zoneId, zoneListener: viewModel, contentListener: viewModel, viewGroupId: "shopping_list_group")
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
            .navigationTitle(listName)
        }
    }
    
    func refreshItems() async {
        wrapperUUID = UUID()
    }
}

struct ShoppingListTabView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListTabView()
    }
}
