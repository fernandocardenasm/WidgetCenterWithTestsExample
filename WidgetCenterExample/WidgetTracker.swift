//
//  WidgetTracker.swift
//  WidgetCenterExample
//
//  Created by Fernando Cardenas on 27.03.21.
//

import Foundation

public final class WidgetTracker {
    
    private let trackingService: EventTracking
    private let store: WidgetStore
    
    public init(trackingService: EventTracking,
         store: WidgetStore) {
        self.trackingService = trackingService
        self.store = store
    }
    
    public func trackInstalledWidgets() {
        store.retrieveInstalledWidgets { [weak self] result in
            guard let self = self else { return }
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
