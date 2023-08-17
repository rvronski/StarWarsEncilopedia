//
//  AppFactory.swift
//  Star Wars Encyclopedia
//
//  Created by ROMAN VRONSKY on 14.08.2023.
//

import UIKit

class AppFactory {
    
    
    private let coreDataManager: CoreDataManagerProtocol
    private let networkManager: NetworkProtocol
    
    init(coreDataManager: CoreDataManagerProtocol, networkManager: NetworkProtocol) {
        self.coreDataManager = coreDataManager
        self.networkManager = networkManager
    }
    
    func makeModule(ofType moduleType: Module.ModuleType) -> Module {
        switch moduleType {
        case .search:
            let viewModel = SearchViewModel(coreDataManager: coreDataManager, networkManager: networkManager )
            let view = UINavigationController(rootViewController: SearchViewController(viewModel: viewModel))
            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
        case .favorites:
            let viewModel = FavoriteViewModel(coreDataManager: coreDataManager)
            let view = FavoritesViewController(viewModel: viewModel)
            return Module(moduleType: moduleType, viewModel: viewModel, view: view)
       
        }
    }
}
