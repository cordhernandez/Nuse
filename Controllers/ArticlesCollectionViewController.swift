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
    var teases: [String] = []
    var urls: [String] = []
    var headlines: [String] = []
    
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
        
        return teases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: ArticlesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "articlesCell", for: indexPath) as? ArticlesCollectionViewCell else {
            
            debugPrint("Failed to Dequeue Reusable Cell for ArticlesCollectionViewCell")
            return UICollectionViewCell()
        }
        
        let row = indexPath.row
        let theTeases = teases[row]
        let theHeadlines = headlines[row]
        let theURLs = urls[row]
        
        cell.newsImage.sd_setImage(with: URL(string: theTeases), completed: nil)
        cell.headingLabel.text = theHeadlines
        
        cell.onReadMoreButtonTapped = { cell in
            self.openNewsArticlesURL(with: theURLs)
        }
        
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
        getItemsDataObject()
        
        main.addOperation {
            
            self.articlesCollectionView.reloadData()
        }
    }
    
    func getItemsDataObject() {
        
        for item in news {
            
            for object in item.items {
                
                teases.append(object.tease)
                headlines.append(object.headline)
                urls.append(object.url)
            }
        }
    }
}

