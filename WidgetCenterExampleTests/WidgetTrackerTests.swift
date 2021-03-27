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

enum WidgetSize: String {
    case small
    case medium
    case large
}

protocol WidgetStore {
    func retrieveInstalledWidgets(completion: @escaping (Result<[WidgetSize], Error>) -> Void)
}

class WidgetTracker {
    
    let trackingService: EventTracking
    let store: WidgetStore
    
    init(trackingService: EventTracking,
         store: WidgetStore) {
        self.trackingService = trackingService
        self.store = store
    }
    
    func trackInstalledWidgets() {
        store.retrieveInstalledWidgets { result in
            switch result {
            case let .success(widgets):
                self.trackingService.track("widgetEvent", dict: self.map(widgets))
            case .failure:
                break
            }
        }
    }
    
    private func map(_ widgetSizes: [WidgetSize]) -> [String] {
        widgetSizes.map { $0.rawValue }
    }
}

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

class WidgetStoreSpy: WidgetStore {
    
    typealias Completion = (Result<[WidgetSize], Error>) -> Void
    var retrievalCompletions = [Completion]()
    
    func retrieveInstalledWidgets(completion: @escaping Completion) {
        retrievalCompletions.append(completion)
    }
    
    func completeRetrieval(withWidgets widgetSizes: [WidgetSize], at index: Int = 0) {
        retrievalCompletions[index](.success(widgetSizes))
    }
}

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
    
    private func makeSUT() -> (WidgetTracker, EventTrackingSpy, WidgetStoreSpy) {
        let tracking = EventTrackingSpy()
        let store = WidgetStoreSpy()
        let sut = WidgetTracker(trackingService: tracking, store: store)
        
        return (sut, tracking, store)
    }
}
