//
//  MainViewModel.swift
//  Star Wars Encyclopedia
//
//  Created by ROMAN VRONSKY on 14.08.2023.
//

import Foundation

class MainViewModel: ViewModelProtocol {
    
    private let coreDataManager: CoreDataManagerProtocol
    private let networkManager: NetworkProtocol
    
    init(coreDataManager: CoreDataManagerProtocol, networkManager: NetworkProtocol) {
        self.coreDataManager = coreDataManager
        self.networkManager = networkManager
    }
    weak var coordinator: Coordinatable!
    
    func getHeroes(searchText: String, completion: @escaping ((_ heroes: [Hero]) -> Void)) {
        networkManager.getHeroes(searchText: searchText) { heroes in
            guard let heroes else {return}
            completion(heroes)
        }
    }
    
}
