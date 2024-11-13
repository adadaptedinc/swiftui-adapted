//
//  OffScreenZoneView.swift
//  SwiftUIAdapted
//
//  Created by Brett Clifton on 10/26/24.
//

import SwiftUI
import adadapted_swift_sdk

struct OffScreenZoneView: View, ZoneViewListener, AdContentListener {
    @State private var isZoneViewOneVisible: Bool = false
    @State private var isZoneViewTwoVisible: Bool = false
    @State private var zoneContextId: String =  "organic"
    
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
                    AaZoneViewSwiftUI(zoneId: "110003", zoneListener: self, contentListener: self, isZoneVisible: $isZoneViewOneVisible, zoneContextId: $zoneContextId)
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
            }.padding()
            
            if #available(iOS 18.0, *) {
                AaZoneViewSwiftUI(zoneId: "110002", zoneListener: self, contentListener: self, isZoneVisible: $isZoneViewTwoVisible)
                    .frame(width: CGFloat(UIScreen.main.bounds.width), height: 80)
                    .onScrollVisibilityChange { isVisible in
                        isZoneViewTwoVisible = isVisible
                    }
            }
        }
    }
}

struct ScrollingTextButtonView_Previews: PreviewProvider {
    static var previews: some View {
        OffScreenZoneView()
    }
}
