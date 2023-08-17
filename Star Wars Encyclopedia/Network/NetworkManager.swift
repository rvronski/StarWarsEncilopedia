//
//  NetworkManager.swift
//  Star Wars Encyclopedia
//
//  Created by ROMAN VRONSKY on 14.08.2023.
//

import Foundation

protocol NetworkProtocol {
    func getHeroes(searchText: String, completion: ((_ heroes: HeroModel?) -> Void)?)
}

class NetworkManager: NetworkProtocol {
    
    func getHeroes(searchText: String, completion: ((_ heroes: HeroModel?) -> Void)?) {
        guard let url = URL(string: "https://swapi.dev/api/people/?search=\(searchText)" ) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let error {
                print(error.localizedDescription)
                completion?(nil)
                return
            }
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            let headerFields = (response as? HTTPURLResponse)?.allHeaderFields
            print("🍏 Statys Code = \(String(describing: statusCode))")
            if statusCode != 200 {
                print("Status Code = \(String(describing: statusCode))")
                completion?(nil)
                return
            }
            guard let data else {
                print("data = nil")
                completion?(nil)
                return
            }
            do {
                let heroes = try JSONDecoder().decode(HeroAnswer.self, from: data)
                var starshipsArray = [Starships]()
                let hero = heroes.results
                guard let hero else {return}
                for h in hero {
                    var  heroName = h.name ?? ""
                    var heroGender = h.gender ?? ""
                    let starships = h.starships
                    guard let starships else {return}
                    for starship in starships {
                        guard let url = URL(string: starship ) else { return }
                        let session = URLSession(configuration: .default)
                        let task = session.dataTask(with: url) { data, response, error in
                            if let error {
                                print(error.localizedDescription)
                                completion?(nil)
                                return
                            }
                            let statusCode = (response as? HTTPURLResponse)?.statusCode
                            if statusCode != 200 {
                                print("Status Code = \(String(describing: statusCode))")
                                completion?(nil)
                                return
                            }
                            guard let data else {
                                print("data = nil")
                                completion?(nil)
                                return
                            }
                            do {
                                let starship = try JSONDecoder().decode(Starships.self, from: data)
                                starshipsArray.append(starship)
                                if starshipsArray.count == starships.count {
                                    let heroModel = HeroModel(name: heroName, gender: heroGender, starships: starshipsArray)
                                    starshipsArray.removeAll()
                                    completion?(heroModel)
                                }
                            } catch {
                                completion?(nil)
                                print(error)
                            }
                        }
                        task.resume()
                    }
                }
                
            } catch {
                completion?(nil)
                print(error)
            }
        }
        
        task.resume()
    }
}
