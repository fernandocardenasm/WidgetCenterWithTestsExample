//
//  WidgetCenterSpy.swift
//  WidgetCenterExampleTests
//
//  Created by Fernando Cardenas on 27.03.21.
//

import WidgetCenterExample
import WidgetKit

class WidgetCenterSpy: WidgetCenterProtocol {
    
    typealias ConfigResult = Result<[WidgetInfo], Error>
    typealias Completion = (ConfigResult) -> Void
    var configCompletions = [Completion]()
    
    func getCurrentConfigurations(_ completion: @escaping Completion) {
        configCompletions.append(completion)
    }
    
    func complete(withInfos infos: [WidgetInfo], at index: Int = 0) {
        configCompletions[index](.success(infos))
    }
    
    func complete(withError error: Error, at index: Int = 0) {
        configCompletions[index](.failure(error))
    }
}

struct WidgetInfo: WidgetInfoProtocol {
    let family: WidgetFamily
}
