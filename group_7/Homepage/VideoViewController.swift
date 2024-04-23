//
//  VideoViewController.swift
//  group_7
//
//  Created by Byeongjun Oh on 4/19/24.
//

import Foundation
import UIKit
import AVFoundation
import AVKit


class VideoViewController: UIViewController{
    var data : Int?
    var videoName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let receiveData = data {
            print(receiveData)
            if receiveData == 0 {
                videoName = "meditation"
            } else if receiveData == 1{
                videoName = "Calm"
            } else if receiveData == 2{
                videoName = "journal"
            }
                    
            guard let videoURL = Bundle.main.url(forResource: videoName, withExtension: "mp4") else {
                print("Video not found.")
                return
            }
            
            let player = AVPlayer(url: videoURL)
            
            let playerViewC = AVPlayerViewController()
            playerViewC.player = player
            
            addChild(playerViewC)
            view.addSubview(playerViewC.view)
            playerViewC.view.frame = view.bounds
            playerViewC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            playerViewC.didMove(toParent: self)
            
            player.play()
        }
    }
}
