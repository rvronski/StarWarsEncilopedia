//
//  NetworkManager.swift
//  Star Wars Encyclopedia
//
//  Created by ROMAN VRONSKY on 14.08.2023.
//

import Foundation

protocol NetworkProtocol {
    func getHeroes(searchText: String, completion: ((_ heroes: [Hero]?) -> Void)?)
}

class NetworkManager: NetworkProtocol {
    
    func getHeroes(searchText: String, completion: ((_ heroes: [Hero]?) -> Void)?) {
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
                    print(heroes.results)
                    completion?(heroes.results)
                } catch {
                    completion?(nil)
                    print(error)
                }
            }
            
            task.resume()
        }

}
