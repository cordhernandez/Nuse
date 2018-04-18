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
    static var teases: [String] = []
    static var headlines: [String] = []
    static var urls: [String] = []
    
    typealias Callback = ([News], [String], [String], [String]) -> ()
    
    static func searchForNews(callback: @escaping Callback) {
        
        newsAPI = "http://msgviewer.nbcnewstools.net:9207/v1/query/curation/news/"
        guard let url = URL(string: newsAPI ?? "") else {
            
            debugPrint("Failed to get URL API")
            callback([], [], [], [])
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
            
            do {
                
                let decoder = JSONDecoder()
                self.news = try decoder.decode([News].self, from: data)
                
                for item in self.news {
                    
                    for theItems in item.items {
                        
                        teases.append(theItems.tease)
                        headlines.append(theItems.headline)
                        urls.append(theItems.url)
                        
                        callback(self.news, teases, headlines, urls)
                    }
                }
                
//                callback(self.news)
            }
            catch {
                debugPrint(error)
            }
        }
        
        task.resume()
    }
}
