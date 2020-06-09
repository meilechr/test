//
//  ViewController.swift
//  CustomLogin
//
//  Created by Chris Meile on 2020-06-08.
//  Copyright © 2020 Chris Meile. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var videoPlayer:AVPlayer?
    
    var videoPlayerLayer:AVPlayerLayer?
    
    
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Hides navigation bar on first view controller
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
        
        // Sets up video in background
        setUpVideo()
    }
    
    // Hides Navigation bar if go back to first view controller
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    func setUpElements(){
        
        //Style
        Utilities.styleFilledButton2(signUpButton)
        Utilities.styleFilledButton(loginButton)
    }
    
    func setUpVideo(){
        
        // Get the path to the resource in the bundle (holds videos / sounds etc)
        let bundlePath = Bundle.main.path(forResource: "loginbg", ofType: "mp4")
        
        // if cant find it just skip
        guard bundlePath != nil else {
            return
        }
        
        // Create a URL from it
        
        let url = URL(fileURLWithPath: bundlePath!)
        
        // Create the video player item
        let item = AVPlayerItem(url: url)
        
        // Create player
        videoPlayer = AVPlayer(playerItem: item)
        
        // Create layer
        
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        // Adjust size and frame
        videoPlayerLayer?.frame = CGRect(x:-self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
        //videoPlayerLayer?.frame = CGRect(x:0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        // Add it and play it
        
        videoPlayer?.playImmediately(atRate: 1)
        
    }

    

}

