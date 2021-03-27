//
//  WidgetCenterProtocol.swift
//  WidgetCenterExample
//
//  Created by Fernando Cardenas on 27.03.21.
//

import WidgetKit

public protocol WidgetCenterProtocol {
    associatedtype MyWidgetInfo: WidgetInfoProtocol

    func getCurrentConfigurations(_ completion: @escaping (Result<[MyWidgetInfo], Error>) -> Void)
}

extension WidgetCenter: WidgetCenterProtocol {}
