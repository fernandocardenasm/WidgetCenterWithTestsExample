//
//  WidgetInfoProtocol.swift
//  WidgetCenterExample
//
//  Created by Fernando Cardenas on 27.03.21.
//

import WidgetKit

public protocol WidgetInfoProtocol {
    var family: WidgetFamily { get }
}

extension WidgetInfo: WidgetInfoProtocol {}
