//
//  ShoppingListViewModel.swift
//  SwiftUIAdapted
//
//  Created by Brett Clifton on 10/29/24.
//

import SwiftUI
import Combine
import adadapted_swift_sdk

class ShoppingListViewModel: ObservableObject, ZoneViewListener, AdContentListener {
    func onZoneHasAds(hasAds: Bool) {}
    func onAdLoaded() {}
    func onAdLoadFailed() {}
    
    func onContentAvailable(zoneId: String, content: AddToListContent) {
        let items = content.getItems()
        
        for item in items {
            content.itemAcknowledge(item: item)
            addItemFromAd(itemName: item.title)
        }
        content.acknowledge()
    }
    
    @Published var shoppingItems: [String] = ["Eggs", "Bread", "Oranges"]
    @Published var newItem: String = ""
    
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
