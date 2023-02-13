//
//  AlertBuilder.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2023/02/12.
//

import UIKit
import RxSwift

final class AlertBuilder {
    struct AlertComponents {
        var title: String?
        var message: String?
        var type: UIAlertController.Style = .alert
        var actions: [UIAlertAction] = []
    }
    
    static private let alertBuilder = AlertBuilder()
    static private var components = AlertComponents()
    
    static var shared: AlertBuilder {
        self.components = AlertComponents()
        return alertBuilder
    }
    
    private init() { }
    
    func setTitle(_ title: String) -> AlertBuilder {
        Self.components.title = title
        
        return self
    }
    
    func setMessage(_ message: String?) -> AlertBuilder {
        Self.components.message = message
        
        return self
    }
    
    func setType(_ type: UIAlertController.Style) -> AlertBuilder {
        Self.components.type = type
        
        return self
    }
    
    func setActions(_ actions: [UIAlertAction]?) -> AlertBuilder {
        guard let actions = actions else { return self }
        actions.forEach { Self.components.actions.append($0) }
        
        return self
    }
    
    func apply() -> UIAlertController {
        let alert = UIAlertController(
            title: AlertBuilder.components.title,
            message: AlertBuilder.components.message,
            preferredStyle: AlertBuilder.components.type
        )
        
        AlertBuilder
            .components
            .actions
            .forEach { alert.addAction($0) }
        
        return alert
    }
}
