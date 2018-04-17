//
//  SearchNews.swift
//  Nuse
//
//  Created by Cordero Hernandez on 4/16/18.
//  Copyright © 2018 Cordero Hernandez. All rights reserved.
//

import Foundation

class SearchNews {
    
    var newsAPI: String?
    var news: [NewsModel] = []
    typealias Callback = ([NewsModel]) -> ()
    
    func searchForNews(callback: @escaping Callback) {
        
        newsAPI = "http://msgviewer.nbcnewstools.net:9207/v1/query/curation/news/"
        guard let url = URL(string: newsAPI ?? "") else {
            
            debugPrint("Failed to get URL API")
            callback([])
            return
        }
        
        getNewsFrom(url: url, callback: callback)
    }
    
    func getNewsFrom(url: URL, callback: @escaping Callback) {
        
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
                self.news = try decoder.decode([NewsModel].self, from: data)
                callback(self.news)
            }
            catch {
                debugPrint(error)
            }
        }
        
        task.resume()
    }
}
