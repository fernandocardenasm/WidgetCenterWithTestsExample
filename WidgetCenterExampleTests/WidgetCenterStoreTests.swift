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
        
        expect(sut, toCompleteWith: .success([.small,
                                              .medium,
                                              .large])) {
            let infos = [WidgetInfo(family: .systemSmall),
                         WidgetInfo(family: .systemMedium),
                         WidgetInfo(family: .systemLarge)]
            center.complete(withInfos: infos)
        }
    }
    
    func test_retrieveInstalledWidgets_deliversWithEmptyArray() {
        let (sut, center) = makeSUT()
        
        expect(sut, toCompleteWith: .success([])) {
            center.complete(withInfos: [])
        }
    }
    
    func test_retrieveInstalledWidgets_deliversErrorOnError() {
        let (sut, center) = makeSUT()
        
        let centerError = anyNSError()
        expect(sut, toCompleteWith: .failure(centerError)) {
            center.complete(withError: centerError)
        }
    }
    
    func expect(_ sut: WidgetStore, toCompleteWith expectedResult: WidgetStore.RetrievalResult, when action: () -> Void) {
        let exp = expectation(description: "retrieve completion")
        sut.retrieveInstalledWidgets { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedSizes), .success(expectedSizes)):
                XCTAssertEqual(receivedSizes, expectedSizes)
            case let (.failure(receivedError as NSError), .failure(expectedError  as NSError)):
                XCTAssertEqual(receivedError.domain, expectedError.domain)
                XCTAssertEqual(receivedError.code, expectedError.code)
            default:
                XCTFail("Expected: \(expectedResult), got \(receivedResult) instead")
            }
            exp.fulfill()
        }
        
        action()
        
        wait(for: [exp], timeout: 0.1)
    }
    
    private func makeSUT() -> (sut: WidgetStore, widgetCenter: WidgetCenterSpy) {
        let widgetCenter = WidgetCenterSpy()
        let sut = WidgetCenterStore(widgetCenter: widgetCenter)
        return (sut, widgetCenter)
    }
    
    private func anyNSError() -> NSError {
        NSError(domain: "any", code: 200)
    }
}
