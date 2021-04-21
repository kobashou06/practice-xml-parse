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
                               attribute: NSLayoutConstraint.Attribute.top,
                               relatedBy: NSLayoutConstraint.Relation.equal,
                               toItem: self.view,
                               attribute: NSLayoutConstraint.Attribute.top,
                               multiplier: 1.0,
                               constant: 0)

        self.view.addConstraint(blurViewTopConstraint)
        
        let blurViewLeadingConstraint =
            NSLayoutConstraint(item: blurView as Any,
                               attribute: NSLayoutConstraint.Attribute.leading,
                               relatedBy: NSLayoutConstraint.Relation.equal,
                               toItem: self.view,
                               attribute: NSLayoutConstraint.Attribute.leading,
                               multiplier: 1.0,
                               constant: 0)
        
        self.view.addConstraint(blurViewLeadingConstraint)
        
        let blurViewBottomConstraint =
            NSLayoutConstraint(item: blurView as Any,
                               attribute: NSLayoutConstraint.Attribute.bottom,
                               relatedBy: NSLayoutConstraint.Relation.equal,
                               toItem: self.view,
                               attribute: NSLayoutConstraint.Attribute.bottom,
                               multiplier: 1.0,
                               constant: 0)
        
        self.view.addConstraint(blurViewBottomConstraint)
        
        
        let blurViewTralingConstraint =
            NSLayoutConstraint(item: blurView as Any,
                               attribute: NSLayoutConstraint.Attribute.trailing,
                               relatedBy: NSLayoutConstraint.Relation.equal,
                               toItem: self.view,
                               attribute: NSLayoutConstraint.Attribute.trailing,
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
