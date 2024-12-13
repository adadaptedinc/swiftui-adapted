//
//  HomeView.swift
//  SwiftUIAdapted
//
//  Created by Brett Clifton on 1/17/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Test app for Swift UI implementation")
                    .font(.headline)
                    .padding()

                NavigationLink(destination: ShoppingListTabView()) {
                    Text("Go to List View")
                        .foregroundColor(.blue)
                        .font(.headline)
                }.padding()
                
                NavigationLink(destination: OffScreenZoneTabView()) {
                    Text("Go to Off Screen View")
                        .foregroundColor(.blue)
                        .font(.headline)
                }.padding()

                Spacer()
            }
            .navigationTitle("SwiftUI Adapted").foregroundColor(.orange)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

