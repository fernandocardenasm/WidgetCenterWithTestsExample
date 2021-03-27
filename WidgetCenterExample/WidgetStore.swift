//
//  WidgetStore.swift
//  WidgetCenterExample
//
//  Created by Fernando Cardenas on 27.03.21.
//

import Foundation

public protocol WidgetStore {
    typealias RetrievalResult = Result<[WidgetSize], Error>
    func retrieveInstalledWidgets(completion: @escaping (RetrievalResult) -> Void)
}
