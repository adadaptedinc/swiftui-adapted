//
//  ShoppingListView.swift
//  SwiftUIAdapted
//
//  Created by Brett Clifton on 1/16/24.
//

import SwiftUI
import adadapted_swift_sdk

struct ShoppingListView: View, ZoneViewListener, AdContentListener {
    func onContentAvailable(zoneId: String, content: AddToListContent) {
        let items = content.getItems()
        
        for item in items {
            content.itemAcknowledge(item: item)
            shoppingItems.append(item.title)
        }
        content.acknowledge()
    }
    
    func onZoneHasAds(hasAds: Bool) {
        
    }
    
    func onAdLoaded() {
        
    }
    
    func onAdLoadFailed() {
        
    }
    
    @State private var newItem = ""
    @State private var shoppingItems: [String] = ["Eggs", "Bread", "Oranges"]
    @State private var wrapperUUID = UUID()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(shoppingItems, id: \.self) { item in
                        Text(item)
                    }
                    .onDelete(perform: removeItems)
                }
                .refreshable {
                    await refreshItems()
                }
                          
                AaZoneViewSwiftUI(zoneId: "102110", zoneListener: self, contentListener: self)
                    .id(wrapperUUID)
                    .frame(width: CGFloat(UIScreen.main.bounds.width), height: 80)
                
                HStack {
                    TextField("New Item", text: $newItem)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: addItem) {
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
    }
    
    func addItem() {
        if !newItem.isEmpty {
            shoppingItems.append(newItem)
            newItem = ""
        }
    }
    
    func addItemFromAd(itemName: String) {
        shoppingItems.append(itemName)
    }
    
    func removeItems(at offsets: IndexSet) {
        shoppingItems.remove(atOffsets: offsets)
    }
}

struct ShoppingListView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingListView()
    }
}
