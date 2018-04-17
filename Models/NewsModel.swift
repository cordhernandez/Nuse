//
//  NewsModel.swift
//  Nuse
//
//  Created by Cordero Hernandez on 4/16/18.
//  Copyright © 2018 Cordero Hernandez. All rights reserved.
//

import Foundation

struct NewsModel: Decodable {
    
    let id: String
    let type: String
    let header: String
    let subHeader: String
    let tease: String
    let items: [ItemsModel]
}

struct ItemsModel: Decodable {
    
    let id: String
    let type: String
    let url: String
    let headline: String
    let published: String
    let tease: String
    let summary: String
}
