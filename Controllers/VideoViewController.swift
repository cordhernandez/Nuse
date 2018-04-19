//
//  VideoViewController.swift
//  Nuse
//
//  Created by Cordero Hernandez on 4/18/18.
//  Copyright © 2018 Cordero Hernandez. All rights reserved.
//

import AVFoundation
import AVKit
import UIKit

class VideoViewController: UIViewController {
    
    var avPlayer: AVPlayer!
    var avPlayerLayer: AVPlayerLayer!
    var paused = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAVPlayer()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        avPlayer.play()
        paused = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        avPlayer.pause()
        paused = true
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        
        goToArticlesVC()
    }
}

//MARK: - AV Player
extension VideoViewController {
    
    func configureAVPlayer() {
        
        let videoURL = Bundle.main.path(forResource: "newsVideo", ofType: "mp4")
        avPlayer = AVPlayer(url: URL(fileURLWithPath: videoURL ?? ""))
        
        configureAVPlayerLayer(player: avPlayer)
        addAVPlayerObserver(player: avPlayer)
    }
    
    func configureAVPlayerLayer(player: AVPlayer) {
        
        avPlayerLayer = AVPlayerLayer(player: player)
        avPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        avPlayerLayer.frame = view.layer.frame
        
        avPlayer.actionAtItemEnd = AVPlayerActionAtItemEnd.none
        view.layer.insertSublayer(avPlayerLayer, at: 0)
    }
}

//MARK: - Notifications
extension VideoViewController {
    
    func addAVPlayerObserver(player: AVPlayer) {
        
        let name = NSNotification.Name.AVPlayerItemDidPlayToEndTime
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd(notification:)) , name: name, object: player.currentItem)
    }
    
    @objc func playerItemDidReachEnd(notification: NSNotification) {
        
        let playerItem: AVPlayerItem = notification.object as! AVPlayerItem
        playerItem.seek(to: kCMTimeZero, completionHandler: nil)
    }
}

//MARK: - Segues
extension VideoViewController {
    
    func goToArticlesVC() {
        
        performSegue(withIdentifier: "toArticlesSegue", sender: nil)
    }
}
