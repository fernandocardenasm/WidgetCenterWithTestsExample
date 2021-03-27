//
//  WidgetStoreSpy.swift
//  WidgetCenterExampleTests
//
//  Created by Fernando Cardenas on 27.03.21.
//

import Foundation

class WidgetStoreSpy: WidgetStore {
    
    typealias Completion = (Result<[WidgetSize], Error>) -> Void
    var retrievalCompletions = [Completion]()
    
    func retrieveInstalledWidgets(completion: @escaping Completion) {
        retrievalCompletions.append(completion)
    }
    
    func completeRetrieval(withWidgets widgetSizes: [WidgetSize], at index: Int = 0) {
        retrievalCompletions[index](.success(widgetSizes))
    }
    
    func completeRetrieval(withError error: Error, at index: Int = 0) {
        retrievalCompletions[index](.failure(error))
    }
}
