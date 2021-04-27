//
//  person.swift
//  Biography
//
//  Created by jestin antony on 06/10/20.
//

import Foundation

struct Person: Identifiable,Decodable {
    var id: String { name }
    
        
    
    let name: String
    let description: String
    let shortDescription: String
    let imageName: String
    let sections: [personSection]?
    
    
}

struct personSection: Identifiable,Decodable{
    var id: String { name }
    
    let name: String
    let picturesImageName: [String]
}

extension Person: Equatable {
    
    static func ==(lhs: Person ,rhs: Person) -> Bool {
        lhs.id == rhs.id
    }
}

extension Person {
    static var stubbed:[Person] {
        
        let url = Bundle.main.url(forResource: "Data", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let people = try! JSONDecoder().decode([Person].self, from: data)
        return people
        
    }
}
