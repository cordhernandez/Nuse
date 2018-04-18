//
//  NewsModel.swift
//  Nuse
//
//  Created by Cordero Hernandez on 4/16/18.
//  Copyright © 2018 Cordero Hernandez. All rights reserved.
//

import Foundation

struct News: Decodable {
    
    let id: String
    let type: String
    let header: String
    let subHeader: String
    let tease: String
    let showMore: String
    let items: [Items]
}

struct Items: Decodable {
    
    let id: String
    let type: String
    let url: String
    let headline: String
    let published: String
    let tease: String
    let summary: String
    let breakingLabel: String
    let images: [Images]
}

struct Images: Decodable {
    
    let id: String
    let url: String
    let headline: String
    let published: String
    let caption: String
    let copyright: String
    let graphic: Bool
}
