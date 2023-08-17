//
//  FavoriteViewModel.swift
//  Star Wars Encyclopedia
//
//  Created by Roman Vronsky on 17/08/23.
//

import Foundation

protocol FavoriteViewModelProtocol: ViewModelProtocol {
    
}

class FavoriteViewModel: FavoriteViewModelProtocol {

    private let coreDataManager: CoreDataManagerProtocol
   
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
        
    }
    weak var coordinator: Coordinatable!
    
   
    
}
