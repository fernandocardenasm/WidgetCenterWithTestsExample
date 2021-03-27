//
//  WidgetTrackerTests.swift
//  WidgetCenterExampleTests
//
//  Created by Fernando Cardenas on 27.03.21.
//

import XCTest

protocol EventTracking {
    func track(_ eventName: String, dict: [String])
}

class WidgetTracker {
    
    let trackingService: EventTracking
    
    init(trackingService: EventTracking) {
        self.trackingService = trackingService
    }
    
    func trackInstalledWidgets() {}
}

class EventTrackingSpy: EventTracking {
    
    var events = [(eventName: String, dict: [String])]()
    
    func track(_ eventName: String, dict: [String]) {
        events.append((eventName: eventName, dict: dict))
    }
}


class WidgetTrackerTests: XCTestCase {
    
    func test_init_doesTrackInstalledWidgets() {
        let trackingSpy = EventTrackingSpy()
        let _ = WidgetTracker(trackingService: trackingSpy)
        
        XCTAssertTrue(trackingSpy.events.isEmpty)
    }
}
