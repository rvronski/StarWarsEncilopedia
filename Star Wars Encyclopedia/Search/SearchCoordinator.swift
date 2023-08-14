//
//  SearchCoordinator.swift
//  Star Wars Encyclopedia
//
//  Created by ROMAN VRONSKY on 14.08.2023.
//

import UIKit

class SearchCoordinator: ModuleCoordinatable {
    
    var module: Module?
    private let factory: AppFactory
    private(set) var moduleType: Module.ModuleType
    private(set) var coordinators: [Coordinatable] = []
    
    init(moduleType: Module.ModuleType, factory: AppFactory) {
        self.moduleType = moduleType
        self.factory = factory
    }
    
    func start() -> UIViewController {
        let module = factory.makeModule(ofType: .search)
        let viewController = module.view
        viewController.tabBarItem = moduleType.tabBarItem
        (module.viewModel as? MainViewModel)?.coordinator = self
        self.module = module
        return viewController
    }
    
   
    
}
