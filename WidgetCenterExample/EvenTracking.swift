//
//  EvenTracking.swift
//  WidgetCenterExample
//
//  Created by Fernando Cardenas on 27.03.21.
//

import Foundation

public protocol EventTracking {
    func track(_ eventName: String, dict: [String])
}
