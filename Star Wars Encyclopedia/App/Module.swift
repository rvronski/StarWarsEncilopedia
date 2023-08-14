//
//  Module.swift
//  Star Wars Encyclopedia
//
//  Created by ROMAN VRONSKY on 14.08.2023.
//

import UIKit

protocol ViewModelProtocol: AnyObject {}

struct Module {
    
    enum ModuleType {
        case search
        case favorites
    }
    
    let moduleType: ModuleType
    let viewModel: ViewModelProtocol
    let view: UIViewController
}
extension Module.ModuleType {
    var tabBarItem: UITabBarItem {
        switch self {
        case .search:
            return UITabBarItem(title: "Search",image: UIImage(systemName: "rectangle.grid.1x2.fill"), tag: 0)
        case .favorites:
            return UITabBarItem(title: "Favorites" ,image: UIImage(systemName: "hammer"), tag: 1)
       
        }
    }
}


