//
//  ViewController.swift
//  Nuse
//
//  Created by Cordero Hernandez on 4/16/18.
//  Copyright © 2018 Cordero Hernandez. All rights reserved.
//

import UIKit

class ArticlesCollectionViewController: UIViewController {
    
    @IBOutlet weak var articlesCollectionView: UICollectionView!
    
    var news: [News] = []
    var newsItems: [Items] = []
    
    let main = OperationQueue.main
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        loadArticles()
    }
    
    func configureCollectionView() {
        
        articlesCollectionView.delegate = self
        articlesCollectionView.dataSource = self
    }
}

//MARK: - Collection View DataSource and Delegate
extension ArticlesCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        for item in news {
            
            newsItems = item.items
        }
        
        return newsItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: ArticlesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "articlesCell", for: indexPath) as? ArticlesCollectionViewCell else {
            
            debugPrint("Failed to Dequeue Reusable Cell for ArticlesCollectionViewCell")
            return UICollectionViewCell()
        }
        
        goLoadItemsData(in: cell, at: indexPath, with: news)
        
        return cell
    }
}

//MARK: - URLS
extension ArticlesCollectionViewController {
    
    func openNewsArticlesURL(with urls: String) {
        
        if let url = URL(string: urls) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

//MARK: - Load Data
extension ArticlesCollectionViewController {
    
    func loadArticles() {
        
        SearchNews.searchForNews(callback: self.populateNews)
    }
    
    func populateNews(news: [News]) {
        
        self.news = news
        
        main.addOperation {
            
            self.articlesCollectionView.reloadData()
        }
    }
    
    func goLoadItemsData(in cell: ArticlesCollectionViewCell, at indexPath: IndexPath, with news: [News]) {
        
        let row = indexPath.row
        
        for item in news {
            
            for _ in item.items {
                
                let items = item.items[row]
                cell.newsImage.sd_setImage(with: URL(string: items.tease), completed: nil)
                cell.headingLabel.text = items.headline
                
                cell.onReadMoreButtonTapped = { cell in
                    self.openNewsArticlesURL(with: items.url)
                }
            }
        }
    }
    
    func openNewsArticlesURL(with urls: String) {
        
        if let url = URL(string: urls) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

