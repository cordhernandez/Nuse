//
//  SearchNews.swift
//  Nuse
//
//  Created by Cordero Hernandez on 4/16/18.
//  Copyright © 2018 Cordero Hernandez. All rights reserved.
//

import Foundation

class SearchNews {
    
    static var newsAPI: String?
    static var news: [News] = []
    
    typealias Callback = ([News]) -> ()
    
    static func searchForNews(callback: @escaping Callback) {
        
        newsAPI = "http://msgviewer.nbcnewstools.net:9207/v1/query/curation/news/"
        guard let url = URL(string: newsAPI ?? "") else {
            
            debugPrint("Failed to get URL API")
            callback([])
            return
        }
        
        getNewsFrom(url: url, callback: callback)
    }
    
    static func getNewsFrom(url: URL, callback: @escaping Callback) {
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if error != nil {
                debugPrint("Failed to download news from \(url)")
                return
            }
            
            guard let data = data else {
                debugPrint("Failed to get data")
                return
            }
            
            let news = parseNews(from: data)
            callback(news)
        }
        
        task.resume()
    }
    
    private static func parseNews(from data: Data) -> [News] {
        
        var newsArray: [News] = []
        
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
            return newsArray
        }
        
        guard let jsonArray = jsonObject as? NSArray else {
            return newsArray
        }
        
        for element in jsonArray {
            
            guard let object = element as? NSDictionary else {
                continue
            }
            
            guard let news = News.getNewsJSONData(from: object) else {
                continue
            }
            
            newsArray.append(news)
        }
        
        return newsArray
    }
}


