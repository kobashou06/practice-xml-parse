//
//  IntroViewController.swift
//  Swift5IntroApp1
//
//  Created by kobashou06 on 2021/04/16.
//

import UIKit
import Lottie

class IntroViewController: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //アニメーションさせるJsonの配列
    var onboardArray = ["1","2","3","4","5"]
    
    //アニメーションの下に表示される文字列の配列
    var onboardStringArray = ["aaaa","iiii","uuuu","eeee","oooo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //スクロールしたいのでTrueに設定
        scrollView.isScrollEnabled = true
        
        //アニメーション置き場生成
        setUpScroll()
        
        //Lottieを使ってアニメーションさせる
        for i in 0...4{
            
            let animationView = AnimationView()
            let animation = Animation.named(onboardArray[i])
            animationView.frame = CGRect(x: CGFloat(i) * view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height)
            animationView.animation = animation
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .loop
            animationView.play()
            scrollView.addSubview(animationView)
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //ナビゲーションバーを消す
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setUpScroll(){
        
        scrollView.delegate = self
        
        scrollView.contentSize = CGSize(width: view.frame.size.width * 5, height: view.frame.size.height)
        //contentSizeの横幅　＝ view.frame.size.width　* （表示したい要素の数分！）という認識。。。
        
        //jsonファイルの置き場所用意
        for i in 0...4{
            
            let onboardLabel = UILabel(frame: CGRect(x: CGFloat(i) * view.frame.size.width, y: view.frame.size.height / 3, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
            
            onboardLabel.font = UIFont.systemFont(ofSize: 15.0)
            onboardLabel.textAlignment = .center
            onboardLabel.text = onboardStringArray[i]
            scrollView.addSubview(onboardLabel)
            
        }
        
    }

}
