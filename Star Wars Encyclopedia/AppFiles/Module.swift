//
//  Module.swift
//  Star Wars Encyclopedia
//
//  Created by ROMAN VRONSKY on 14.08.2023.
//

import UIKit

protocol ViewModelProtocol: AnyObject {
    func getHeroes(searchText: String, completion: @escaping ((_ heroes: [Hero]) -> Void))
}

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
            return UITabBarItem(title: "Search",image: UIImage(systemName: "magnifyingglass.circle"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        case .favorites:
            return  UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
      
        }
    }
}


