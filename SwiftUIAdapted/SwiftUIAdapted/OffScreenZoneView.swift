// OffScreenZoneView.swift
// SwiftUIAdapted
//
// Created by Brett Clifton on 10/26/24.
//

import SwiftUI
import adadapted_swift_sdk

struct OffScreenZoneTabView: View {
    var body: some View {
        TabView {
            OffScreenZoneView(zoneId1: "102110", zoneId2: "110002", zoneContextId: "organic", title: "Organic")
                .tabItem {
                    Label("Organic", systemImage: "leaf")
                }
            
            OffScreenZoneView(zoneId1: "110003", zoneId2: "110004", zoneContextId: "organic", title: "Grocery")
                .tabItem {
                    Label("Grocery", systemImage: "cart")
                }
            
            OffScreenZoneView(zoneId1: "110005", zoneId2: "110006", zoneContextId: "organic", title: "Electronics")
                .tabItem {
                    Label("Electronics", systemImage: "tv")
                }
        }
    }
}

struct OffScreenZoneView: View, ZoneViewListener, AdContentListener {
    @State private var isZoneViewOneVisible: Bool = false
    @State private var isZoneViewTwoVisible: Bool = false
    @State private var zoneContextId: String
    let zoneId1: String
    let zoneId2: String
    let title: String
    
    init(zoneId1: String, zoneId2: String, zoneContextId: String, title: String) {
        self._zoneContextId = State(initialValue: zoneContextId)
        self.zoneId1 = zoneId1
        self.zoneId2 = zoneId2
        self.title = title
    }
    
    func onZoneHasAds(hasAds: Bool) {
        var check = true
    }
    
    func onAdLoaded() {
        var check = true
    }
    
    func onAdLoadFailed() {
    }
    
    func onContentAvailable(zoneId: String, content: any AddToListContent) {
        var check = content.getItems().count
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if #available(iOS 18.0, *) {
                    AaZoneViewSwiftUI(zoneId: zoneId1, zoneListener: self, contentListener: self, isZoneVisible: $isZoneViewOneVisible, zoneContextId: $zoneContextId)
                        .frame(width: CGFloat(UIScreen.main.bounds.width), height: 80)
                        .onScrollVisibilityChange { isVisible in
                            isZoneViewOneVisible = isVisible
                        }
                }
                
                ForEach(0..<5) { index in
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        
                        Button(action: {
                            zoneContextId = ""
                            print("Button \(index + 1) tapped")
                        }) {
                            Text("Interaction")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
            }
            .padding()
            
            if #available(iOS 18.0, *) {
                AaZoneViewSwiftUI(zoneId: zoneId2, zoneListener: self, contentListener: self, isZoneVisible: $isZoneViewTwoVisible)
                    .frame(width: CGFloat(UIScreen.main.bounds.width), height: 80)
                    .onScrollVisibilityChange { isVisible in
                        isZoneViewTwoVisible = isVisible
                    }
            }
        }
        .navigationTitle(title)
    }
}

struct OffScreenZoneTabView_Previews: PreviewProvider {
    static var previews: some View {
        OffScreenZoneTabView()
    }
}
