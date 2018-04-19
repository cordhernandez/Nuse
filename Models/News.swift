//
//  NewsModel.swift
//  Nuse
//
//  Created by Cordero Hernandez on 4/16/18.
//  Copyright © 2018 Cordero Hernandez. All rights reserved.
//

import Foundation

struct News {
    
    let id: String
    let type: String
    let header: String
    let subHeader: String
    let tease: String
    let showMore: Bool
    var items: [Items] = []
    
    static func getNewsJSONData(from dictionary: NSDictionary) -> News? {
        
        return News(from: dictionary)
    }
}

extension News {
    
    init?(from newsDictionary: NSDictionary) {
        
        guard let id = newsDictionary["id"] as? String,
            let type = newsDictionary["type"] as? String,
            let header = newsDictionary["header"] as? String,
            let subHeader = newsDictionary["subHeader"] as? String,
            let tease = newsDictionary["tease"] as? String,
            let showMore = newsDictionary["showMore"] as? Bool,
            let itemsJSON = newsDictionary["items"] as? [NSDictionary]
            else {
                
                debugPrint("Failed to parse JSON from newsDictionary: \(newsDictionary)")
                return nil
        }
        
        for item in itemsJSON {
            
            let itemDictionary = Items(id: item["id"] as? String ?? "", type: item["type"] as? String ?? "", url: item["url"] as? String ?? "", headline: item["headline"] as? String ?? "",
                                       published: item["published"] as? String ?? "", tease: item["tease"] as? String ?? "", summary: item["summary"] as? String ?? "",
                                       breakingLabel: item["breakingLabel"] as? String ?? "")
            
            items.append(itemDictionary)
        }
        
        self.id = id
        self.type = type
        self.header = header
        self.subHeader = subHeader
        self.tease = tease
        self.showMore = showMore
    }
    
}

struct Items {
    
    let id: String
    let type: String
    let url: String
    let headline: String
    let published: String
    let tease: String
    let summary: String
    let breakingLabel: String
}
