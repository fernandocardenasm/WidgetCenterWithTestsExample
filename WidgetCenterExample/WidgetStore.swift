//
//  WidgetStore.swift
//  WidgetCenterExample
//
//  Created by Fernando Cardenas on 27.03.21.
//

import Foundation

public protocol WidgetStore {
    func retrieveInstalledWidgets(completion: @escaping (Result<[WidgetSize], Error>) -> Void)
}
