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
    var playerLayer = AVPlayerLayer()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "start", ofType: "mov")
        player = AVPlayer(url: URL(fileURLWithPath: path!))
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.zPosition = -1
        playerLayer.repeatCount = 0
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.needsDisplayOnBoundsChange = true
        playerLayer.player?.isMuted = true
        
        view.layer.insertSublayer(playerLayer, at: 0)

        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerLayer.player?.currentItem, queue: .main){(_)in

            self.player.seek(to: .zero)
            self.player.play()
        }

        self.player.play()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false

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
        
        playerLayer.frame = view.bounds
        
        self.player.play()
        
    }
    
    @IBAction func login(_ sender: Any) {
        
        self.player.pause()
        
    }

}
