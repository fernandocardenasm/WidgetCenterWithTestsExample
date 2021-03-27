//
//  WidgetTrackerTests.swift
//  WidgetCenterExampleTests
//
//  Created by Fernando Cardenas on 27.03.21.
//

import WidgetCenterExample
import XCTest

class WidgetTrackerTests: XCTestCase {
    
    func test_init_doesTrackInstalledWidgets() {
        let (_, tracking, _) = makeSUT()
        
        XCTAssertTrue(tracking.events.isEmpty)
    }
    
    func test_trackInstalledWidgets_whenWidgetsNonEmpty() {
        let (sut, tracking, store) = makeSUT()
        
        sut.trackInstalledWidgets()
        
        let widgets: [WidgetSize] = [.small,
                                     .medium,
                                     .large]
        store.completeRetrieval(withWidgets: widgets)
        
        XCTAssertEqual(tracking.events,
                       [EventTrackingSpy.Event(
                            name: "widgetEvent",
                            dict: ["small",
                                   "medium",
                                   "large"]
                       )]
        )
    }
    
    func test_trackInstalledWidgetsTwice_tracksTwice() {
        let (sut, tracking, store) = makeSUT()
        
        sut.trackInstalledWidgets()
        sut.trackInstalledWidgets()
        
        let widgets: [WidgetSize] = [.small,
                                     .medium,
                                     .large]
        store.completeRetrieval(withWidgets: widgets, at: 0)
        store.completeRetrieval(withWidgets: widgets, at: 1)
        
        let eventName = "widgetEvent"
        let dict = ["small",
                    "medium",
                    "large"]
        XCTAssertEqual(tracking.events,
                       [EventTrackingSpy.Event(
                            name: eventName,
                            dict: dict
                       ),
                       EventTrackingSpy.Event(
                            name: eventName,
                            dict: dict
                       )]
        )
    }
    
    func test_trackInstalledWidgets_whenWidgetsEmpty() {
        let (sut, tracking, store) = makeSUT()
        
        sut.trackInstalledWidgets()
        
        let widgets: [WidgetSize] = []
        store.completeRetrieval(withWidgets: widgets)
        
        XCTAssertEqual(tracking.events,
                       [EventTrackingSpy.Event(
                            name: "widgetEvent",
                            dict: []
                       )]
        )
    }
    
    func test_trackInstalledWidgets_doesNotTrack_whenError() {
        let (sut, tracking, store) = makeSUT()
        
        sut.trackInstalledWidgets()
        
        store.completeRetrieval(withError: NSError(domain: "any", code: 200))
        
        XCTAssertTrue(tracking.events.isEmpty)
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (WidgetTracker, EventTrackingSpy, WidgetStoreSpy) {
        let tracking = EventTrackingSpy()
        let store = WidgetStoreSpy()
        let sut = WidgetTracker(trackingService: tracking, store: store)
        
        trackForMemoryLeaks(tracking, file: file, line: line)
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, tracking, store)
    }
    
    private func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential Memory leak.", file: file, line: line)
        }
    }
}
