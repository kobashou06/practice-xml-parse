//
//  IntroViewController.swift
//  Swift5IntroApp1
//
//  Created by kobashou06 on 2021/04/16.
//

//導入のアニメーション画面

import UIKit
import Lottie

class IntroViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    @IBOutlet private weak var skipButton: UIButton!
    
    //アニメーションさせるJsonの配列
    private var onboardArray = ["1","2","3","4","5"]
    
    //アニメーションの下に表示される文字列の配列
    private var onboardStringArray = ["aaaa","iiii","uuuu","eeee","oooo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ボタンの横幅に応じてフォントサイズを自動調整する設定
        skipButton.titleLabel?.adjustsFontSizeToFitWidth = true
        //ページングしたいのでTrueに設定
        scrollView.isPagingEnabled = true

        //アニメーション置き場生成
        setUpScroll()
        
        animationLottie()
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //ナビゲーションバーを消す
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewDidLayoutSubviews() {
        
        //スキップボタンの制約設定
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        
        let skipButtonTopConstraint = NSLayoutConstraint(item: skipButton as Any,
                                                         attribute: NSLayoutConstraint.Attribute.top,
                                                         relatedBy: NSLayoutConstraint.Relation.equal,
                                                         toItem: self.view,
                                                         attribute: NSLayoutConstraint.Attribute.top,
                                                         multiplier: 1.0,
                                                         constant: 50)
        self.view.addConstraint(skipButtonTopConstraint)
        
        let skipButtonLeadingConstraint = NSLayoutConstraint(item: skipButton as Any,
                                                             attribute: NSLayoutConstraint.Attribute.leading,
                                                             relatedBy: NSLayoutConstraint.Relation.equal,
                                                             toItem: self.view,
                                                             attribute: NSLayoutConstraint.Attribute.leading,
                                                             multiplier: 1.0,
                                                             constant: 20)
        self.view.addConstraint(skipButtonLeadingConstraint)
        
        let skipButtonWidthConstraint = NSLayoutConstraint(item: skipButton as Any,
                                                           attribute: NSLayoutConstraint.Attribute.width,
                                                           relatedBy: NSLayoutConstraint.Relation.equal,
                                                           toItem: self.view,
                                                           attribute: NSLayoutConstraint.Attribute.width,
                                                           multiplier: 0.25,
                                                           constant: 0)
        self.view.addConstraint(skipButtonWidthConstraint)
        
        let skipButtonHeightConstraint = NSLayoutConstraint(item: skipButton as Any,
                                                            attribute: NSLayoutConstraint.Attribute.height,
                                                            relatedBy: NSLayoutConstraint.Relation.equal,
                                                            toItem: self.view,
                                                            attribute: NSLayoutConstraint.Attribute.height,
                                                            multiplier: 0.1,
                                                            constant: 0)
        self.view.addConstraint(skipButtonHeightConstraint)
        
        removeAllSubViews(parentView: scrollView)
        setUpScroll()
        animationLottie()
        
    }
    
    private func removeAllSubViews(parentView: UIView){
        let subviews = parentView.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    private func setUpScroll(){
        
        scrollView.delegate = self
        
        //scrollViewの枠の大きさを、親のViewの大きさと同じにして配置する。
        scrollView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height)
        
        scrollView.contentSize = CGSize(width: view.bounds.size.width
                                            * CGFloat(onboardArray.count),
                                        height: view.bounds.size.height)
        
        for i in 0...4{
            
            let onboardLabel = UILabel(frame: CGRect(x: CGFloat(i) * view.bounds.size.width,
                                                     y: view.bounds.size.height / 3,
                                                     width: scrollView.bounds.size.width,
                                                     height: scrollView.bounds.size.height))
            
            onboardLabel.textAlignment = .center
            onboardLabel.text = onboardStringArray[i]
            onboardLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
            
            scrollView.addSubview(onboardLabel)
            
            
        }
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        //scrollViewの制約
        //scrollViewの横方向の中心は、親ビューの横方向の中心と同じ
        scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        //scrollViewの縦方向の中心は、親ビューの縦方向の中心と同じ
        scrollView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        // scrollViewの横幅は、親ビューの幅と同じ
        scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        // scrollViewの縦幅は、親ビューの幅と同じ
        scrollView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1).isActive = true
        
    }
    
    private func animationLottie() {
        //Lottieを使ってアニメーションさせる
        for i in 0...4{
            
            let animationView = AnimationView()
            let animation = Animation.named(onboardArray[i])
            animationView.frame = CGRect(x: CGFloat(i) * view.bounds.size.width,
                                         y: scrollView.bounds.minY,
                                         width: view.bounds.size.width,
                                         height: view.bounds.size.height)
            animationView.animation = animation
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .loop
            animationView.play()
            scrollView.addSubview(animationView)

        }
        
    }

}
