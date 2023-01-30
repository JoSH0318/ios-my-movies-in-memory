//
//  Coordinator.swift
//  MyMoviesInMemory
//
//  Created by 조성훈 on 2022/12/29.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
}

extension Coordinator {
    func removeChildCoordinator(child: Coordinator) {
        childCoordinators.removeAll()
    }
}
