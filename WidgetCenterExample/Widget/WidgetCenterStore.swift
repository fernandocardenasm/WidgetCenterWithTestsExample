//
//  WidgetCenterStore.swift
//  WidgetCenterExample
//
//  Created by Fernando Cardenas on 27.03.21.
//

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

    private func rawValueString(from widgetInfo: WidgetInfoProtocol) -> WidgetSize? {
        switch widgetInfo.family {
        case .systemSmall: return .small
        case .systemMedium: return .medium
        case .systemLarge: return .large
        @unknown default: return nil
        }
    }
}

