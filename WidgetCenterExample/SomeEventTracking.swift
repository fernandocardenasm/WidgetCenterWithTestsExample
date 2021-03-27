//
//  SomeEventTracking.swift
//  WidgetCenterExample
//
//  Created by Fernando Cardenas on 27.03.21.
//

import Foundation

class SomeEventTracking: EventTracking {
    func track(_ eventName: String, dict: [String]) {
        print("Track with eventName: \(eventName) and dict: \(dict)")
    }
}
