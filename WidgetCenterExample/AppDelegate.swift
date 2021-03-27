//
//  AppDelegate.swift
//  WidgetCenterExample
//
//  Created by Fernando Cardenas on 27.03.21.
//

import UIKit
import WidgetKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let widgetTracker = WidgetComposer.makeWidgetTracker()
        widgetTracker.trackInstalledWidgets()
        
        return true
    }
}

private struct WidgetComposer {
    static func makeWidgetTracker() -> WidgetTracker {
        let tracking = SomeEventTracking()
        let store = WidgetCenterStore(widgetCenter: WidgetCenter.shared)
        return WidgetTracker(trackingService: tracking, store: store)
    }
}
