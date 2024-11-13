//
//  SwiftUIAdaptedApp.swift
//  SwiftUIAdapted
//
//  Created by Brett Clifton on 1/12/24.
//

import SwiftUI
import adadapted_swift_sdk
import AppTrackingTransparency

@main
struct SwiftUIAdaptedApp: App, AaSdkSessionListener, AaSdkEventListener, AaSdkAdditContentListener {
    
    func onHasAdsToServe(hasAds: Bool, availableZoneIds: Array<String>) {
        print("Has Ads To Serve: \(hasAds)")
        print("The following zones have ads to serve: \(availableZoneIds)")
    }
    
    func onNextAdEvent(zoneId: String, eventType: String) {
        print("Ad \(eventType) for Zone \(zoneId)")
    }
    
    func onContentAvailable(content: AddToListContent) {
        let listItems = content.getItems()
        let itemTitle = listItems.first?.title ?? ""
        content.acknowledge()
        print(String(format: "%d item(s) added to Default List", listItems.count))
    }
    
    init() {
        AdAdapted
            .withAppId(key: "7D58810X6333241C") //NJIXNMRHZWUYNJBH 7D58810X6333241C
            .inEnv(env: AdAdapted.Env.DEV)
            .enableKeywordIntercept(value: true)
            .enablePayloads(value: true)
            .setSdkSessionListener(listener: self)
            .setSdkEventListener(listener: self)
            .setSdkAdditContentListener(listener: self)
            .setCustomIdentifier(identifier: "SwiftUiAdapted")
            .start()
        
        DispatchQueue.main.async { //ONLY used for payload testing, the SDK will never request this.
            ATTrackingManager.requestTrackingAuthorization() { status in
                switch status {
                case .authorized:
                    // User granted permission
                    print("Tracking authorized.")
                case .denied:
                    // User denied permission
                    print("Tracking denied.")
                case .restricted:
                    // Tracking is restricted
                    print("Tracking restricted.")
                case .notDetermined:
                    // Tracking permission not determined yet
                    print("Tracking permission not determined.")
                @unknown default:
                    break
                }
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
