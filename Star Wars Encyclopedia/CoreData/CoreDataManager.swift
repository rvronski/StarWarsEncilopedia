//
//  CoreDataManager.swift
//  Star Wars Encyclopedia
//
//  Created by ROMAN VRONSKY on 14.08.2023.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func createUser(hero: HeroModel, completion: @escaping (Person) -> ())
    func getPerson() -> [Person]
    func deletePerson(person: Person)
}

class CoreDataManager: CoreDataManagerProtocol {
    
    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "Star_Wars_Encyclopedia")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createUser(hero: HeroModel, completion: @escaping (Person) -> ()) {
        let person = Person(context: persistentContainer.viewContext)
        person.name = hero.name
        person.gender = hero.gender
        let starships = hero.starships
        guard let starships else {return}
        for i in starships {
            var starship = StarTransport(context: persistentContainer.viewContext)
            starship.manufacture = i.manufacturer
            starship.model = i.model
            starship.name = i.name
            starship.passengers = i.passengers
            person.addToStarship(starship)
        }
        completion(person)
        saveContext()
    }
    
    
    func getPerson() -> [Person] {
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        var fetchedUsers: [Person] = []
        do {
            fetchedUsers = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Error fetching singers \(error)")
        }
        return fetchedUsers
    }
    
    func deletePerson(person: Person) {
        persistentContainer.viewContext.delete(person)
        saveContext()
    }
    
}
