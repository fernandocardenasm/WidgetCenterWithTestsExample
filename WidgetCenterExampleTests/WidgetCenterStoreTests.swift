//
//  WidgetCenterStoreTests.swift
//  WidgetCenterExampleTests
//
//  Created by Fernando Cardenas on 27.03.21.
//

import XCTest
import WidgetCenterExample
import WidgetKit

class WidterCenterStore <MyWidgetCenter: WidgetCenterProtocol>: WidgetStore {
    
    let widgetCenter: MyWidgetCenter
    
    init(widgetCenter: MyWidgetCenter) {
        self.widgetCenter = widgetCenter
    }
    
    func retrieveInstalledWidgets(completion: @escaping (Result<[WidgetSize], Error>) -> Void) {
//        widgetCenter.getCurrentConfigurations { [weak self] result in
//            switch result {
//            case let .success(widgetInfos):
//                let widgetFamilies = widgetInfos.compactMap { self?.rawValueString(from: $0) }
//                completion(.success(widgetFamilies))
//            case let .failure(error):
//                completion(.failure(error))
//            }
//        }
    }

//    private func rawValueString(from widgetInfo: WidgetInfoProtocol) -> WidgetSize? {
//        switch widgetInfo.family {
//        case .systemSmall: return .small
//        case .systemMedium: return .medium
//        case .systemLarge: return .large
//        @unknown default: return nil
//        }
//    }
}

class WidgetCenterSpy: WidgetCenterProtocol {
    
    typealias Completion = (Result<[WidgetInfo], Error>) -> Void
    var configCompletions = [Completion]()
    
    func getCurrentConfigurations(_ completion: @escaping Completion) {
        configCompletions.append(completion)
    }
}

struct WidgetInfo: WidgetInfoProtocol {
    var family: WidgetFamily
}

class WidgetCenterStoreTests: XCTestCase {
    
    func test_init_doesRetrieveWidgets() {
        let (_, center) = makeSUT()
        
        XCTAssertTrue(center.configCompletions.isEmpty)
    }
    
    private func makeSUT() -> (sut: WidgetStore, widgetCenter: WidgetCenterSpy) {
        let widgetCenter = WidgetCenterSpy()
        let sut = WidterCenterStore(widgetCenter: widgetCenter)
        return (sut, widgetCenter)
    }
}
