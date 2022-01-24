//
//  JokeModel.swift
//  CoreDataTest
//
//  Created by JeongTaek Han on 2022/01/24.
//

import Foundation

struct JokeModel {
    
    let id: UUID
    let category: Category
    let content: String
    
}

struct Category {
    
    let kind: String
    
}
