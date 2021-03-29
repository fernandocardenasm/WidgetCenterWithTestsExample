//
//  WidgetTracker.swift
//  WidgetCenterExample
//
//  Created by Fernando Cardenas on 27.03.21.
//

import Foundation

public final class WidgetTracker {
    
    private let tracker: EventTracking
    private let store: WidgetStore
    
    public init(tracker: EventTracking,
         store: WidgetStore) {
        self.tracker = tracker
        self.store = store
    }
    
    public func trackInstalledWidgets() {
        store.retrieveInstalledWidgets { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(widgets):
                self.tracker.track("widgetEvent", dict: self.map(widgets))
            case .failure:
                break
            }
        }
    }
    
    private func map(_ widgetSizes: [WidgetSize]) -> [String] {
        widgetSizes.map { $0.rawValue }
    }
}
