//
//  LoginMovieViewController.swift
//  Swift5IntroApp1
//
//  Created by kobashou06 on 2021/04/16.
//

//ログイン画面

import UIKit
import AVFoundation

class LoginMovieViewController: UIViewController {
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    var player = AVPlayer()
    let path = Bundle.main.path(forResource: "start", ofType: "mov")

    override func viewDidLoad() {
        
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        
        setUpMoviePlayer()
        
    }
    
    override func viewDidLayoutSubviews() {
        
        //blurViewの制約を設定
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        let blurViewTopConstraint =
            NSLayoutConstraint(item: blurView as Any,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: self.view,
                               attribute: .top,
                               multiplier: 1.0,
                               constant: 0)

        self.view.addConstraint(blurViewTopConstraint)
        
        let blurViewLeadingConstraint =
            NSLayoutConstraint(item: blurView as Any,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: self.view,
                               attribute: .leading,
                               multiplier: 1.0,
                               constant: 0)
        
        self.view.addConstraint(blurViewLeadingConstraint)
        
        let blurViewBottomConstraint =
            NSLayoutConstraint(item: blurView as Any,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: self.view,
                               attribute: .bottom,
                               multiplier: 1.0,
                               constant: 0)
        
        self.view.addConstraint(blurViewBottomConstraint)
        
        
        let blurViewTralingConstraint =
            NSLayoutConstraint(item: blurView as Any,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: self.view,
                               attribute: .trailing,
                               multiplier: 1.0,
                               constant: 0)
        
        self.view.addConstraint(blurViewTralingConstraint)
        
        
        
    }
    
    func setUpMoviePlayer(){
        
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        
        //AVPlayer用のレイヤー作成
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 0,
                                   y: 0,
                                   width: view.frame.size.width,
                                   height: view.frame.size.height)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.repeatCount = 0
        playerLayer.zPosition = -1
        view.layer.insertSublayer(playerLayer, at: 0)
        
        self.player.isMuted = true
        self.player.play()
        
    }
    
    @IBAction func login(_ sender: Any) {
        
        player.pause()
        
    }

}
