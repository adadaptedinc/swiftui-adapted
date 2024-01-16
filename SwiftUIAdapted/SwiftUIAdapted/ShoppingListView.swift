//
//  ShoppingListView.swift
//  SwiftUIAdapted
//
//  Created by Brett Clifton on 1/16/24.
//

import SwiftUI

struct ShoppingListView: View {
    @State private var newItem = ""
    @State private var shoppingItems: [String] = ["Eggs", "Bread", "Oranges"]
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(shoppingItems, id: \.self) { item in
                        Text(item)
                    }
                    .onDelete(perform: removeItems)
                }
                
                WebViewWrapper(urlString: "https://ad.img.qa.adadapted.dev/platform/ads/2800/6318/1212/102110.html?session_id=98ABF46426052F6692482BE92A8D6F0X65A6F388&udid=00000000-0000-0000-0000-000000000000")
                    .frame(maxWidth: .infinity, maxHeight: 80)
                    .background(Color.gray.opacity(0.5))
                    //.padding()
                
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
    
    func addItem() {
        if !newItem.isEmpty {
            shoppingItems.append(newItem)
            newItem = ""
        }
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
