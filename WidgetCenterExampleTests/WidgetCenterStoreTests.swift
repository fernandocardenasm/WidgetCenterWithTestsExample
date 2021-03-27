//
//  WidgetCenterStoreTests.swift
//  WidgetCenterExampleTests
//
//  Created by Fernando Cardenas on 27.03.21.
//

import XCTest
import WidgetCenterExample
import WidgetKit

class WidgetCenterStoreTests: XCTestCase {
    
    func test_init_doesRetrieveWidgets() {
        let (_, center) = makeSUT()
        
        XCTAssertTrue(center.configCompletions.isEmpty)
    }
    
    func test_retrieveInstalledWidgets_deliversWidgetSizes() {
        let (sut, center) = makeSUT()
        
        let exp = expectation(description: "retrieve completion")
        sut.retrieveInstalledWidgets { result in
            switch result {
            case let .success(receivedSizes):
                XCTAssertEqual(receivedSizes,
                               [.small,
                                .medium,
                                .large])
            case .failure:
                XCTFail("Expected to result successfully, we got \(result) instead")
            }
            exp.fulfill()
        }
        
        let infos = [WidgetInfo(family: .systemSmall),
                     WidgetInfo(family: .systemMedium),
                     WidgetInfo(family: .systemLarge)]
        
        center.complete(withInfos: infos)
        
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_retrieveInstalledWidgets_deliversWithEmptyArray() {
        let (sut, center) = makeSUT()
        
        let exp = expectation(description: "retrieve completion")
        sut.retrieveInstalledWidgets { result in
            switch result {
            case let .success(receivedSizes):
                XCTAssertEqual(receivedSizes, [])
            case .failure:
                XCTFail("Expected to result successfully, we got \(result) instead")
            }
            exp.fulfill()
        }
        
        let infos = [WidgetInfo]()
        
        center.complete(withInfos: infos)
        
        wait(for: [exp], timeout: 0.1)
    }
    
    func test_retrieveInstalledWidgets_deliversErrorOnError() {
        let (sut, center) = makeSUT()
        
        let exp = expectation(description: "retrieve completion")
        sut.retrieveInstalledWidgets { result in
            switch result {
            case .success:
                XCTFail("Expected to result with failure, we got \(result) instead")
            case .failure:
                break
            }
            exp.fulfill()
        }
        
        center.complete(withError: NSError(domain: "any", code: 200))
        
        wait(for: [exp], timeout: 0.1)
    }
    
    private func makeSUT() -> (sut: WidgetStore, widgetCenter: WidgetCenterSpy) {
        let widgetCenter = WidgetCenterSpy()
        let sut = WidgetCenterStore(widgetCenter: widgetCenter)
        return (sut, widgetCenter)
    }
}
