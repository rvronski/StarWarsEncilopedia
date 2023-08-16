//
//  NetworkModel.swift
//  Star Wars Encyclopedia
//
//  Created by Roman Vronsky on 16/08/23.
//

import Foundation

struct HeroAnswer: Codable {
   var count: Int?
   var next: String?
   var results: [Hero]?
}


struct Hero: Codable {
    var name: String?
    var gender: String?
    var starships: [String]?
}

struct Starships: Codable {
    var manufacturer: String?
    var model: String?
    var name: String?
    var passengers: String?
}
