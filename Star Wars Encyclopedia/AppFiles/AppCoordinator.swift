//
//  AppCoordinator.swift
//  Star Wars Encyclopedia
//
//  Created by ROMAN VRONSKY on 14.08.2023.
//

import UIKit

final class AppCoordinator: Coordinatable {
    
    private(set) var coordinators: [Coordinatable] = []
    private(set) var module: Module?
    private let factory: AppFactory
    init(factory: AppFactory) {
        self.factory = factory
    }

    func start() -> UIViewController {
        let searchCoordinator = SearchCoordinator(moduleType: .search, factory: factory)
        let favoritesCoordinator = FavoritesCoordinator(moduleType: .favorites, factory: factory)
        let searchVC = searchCoordinator.start()
        let favoritesVC = favoritesCoordinator.start()
        let tabBarController = AppTabBarController(viewControllers: [searchVC, favoritesVC])
        addCoordinator(coordinator: searchCoordinator)
        addCoordinator(coordinator: favoritesCoordinator)
        return tabBarController
    }
    
    func addCoordinator(coordinator: Coordinatable) {
        guard coordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        coordinators.append(coordinator)
    }
    
    func removeCoordinator() {
        coordinators.removeAll()
    }
    
}

