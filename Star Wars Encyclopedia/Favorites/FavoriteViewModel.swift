//
//  FavoriteViewModel.swift
//  Star Wars Encyclopedia
//
//  Created by Roman Vronsky on 17/08/23.
//

import Foundation

protocol FavoriteViewModelProtocol: ViewModelProtocol {
    func getPerson() -> [Person]
    func deletePerson(person: Person)
}

class FavoriteViewModel: FavoriteViewModelProtocol {

    private let coreDataManager: CoreDataManagerProtocol
   
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
        
    }
    weak var coordinator: Coordinatable!
    
    func getPerson() -> [Person] {
        return coreDataManager.getPerson()
    }
    
    func deletePerson(person: Person) {
        coreDataManager.deletePerson(person: person)
    }
}
