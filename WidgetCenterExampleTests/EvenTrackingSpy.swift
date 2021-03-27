//
//  EvenTrackingSpy.swift
//  WidgetCenterExampleTests
//
//  Created by Fernando Cardenas on 27.03.21.
//

import Foundation

class EventTrackingSpy: EventTracking {
    
    struct Event: Equatable {
        let name: String
        let dict: [String]
    }
    var events = [Event]()
    
    func track(_ eventName: String, dict: [String]) {
        events.append(Event(name: eventName, dict: dict))
    }
}
