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
    
    var news: [NewsModel] = []
    var teases: [String] = []
    var headlines: [String] = []
    var urls: [String] = []
    
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
        
        return cell
    }
}

//MARK: - Load Data
extension ArticlesCollectionViewController {
    
    func loadArticles() {
        
        SearchNews.searchForNews(callback: self.populateNews)
    }
    
    func populateNews(news: [NewsModel], teases: [String], headlines: [String], urls: [String]) {
        
        self.news = news
        self.teases = teases
        self.headlines = headlines
        self.urls = urls
        
        main.addOperation {
            
            self.articlesCollectionView.reloadData()
        }
    }
}

