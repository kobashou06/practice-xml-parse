//
//  LoginMovieViewController.swift
//  Swift5IntroApp1
//
//  Created by kobashou06 on 2021/04/16.
//

import UIKit
import AVFoundation

class LoginMovieViewController: UIViewController {
    
    var player = AVPlayer()
    let path = Bundle.main.path(forResource: "start", ofType: "mov")

    override func viewDidLoad() {
        super.viewDidLoad()

        player = AVPlayer(url: URL(fileURLWithPath: path!))
        
        //AVPlayer用のレイヤー作成
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.repeatCount = 0
        playerLayer.zPosition = -1
        view.layer.insertSublayer(playerLayer, at: 0)
        
        self.player.play()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        
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
