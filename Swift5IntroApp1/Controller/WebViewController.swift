//
//  WebViewController.swift
//  Swift5IntroApp1
//
//  Created by user on 2021/04/16.
//

//実際のニュース記事の表示画面

import UIKit
import WebKit

class WebViewController: UIViewController,WKUIDelegate {
    
    var webView = WKWebView()
    var backButton = UIButton()

    //Webサイト表示画面
    fileprivate func setupWebView() {

        view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        webView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
    }
    
    //記事リストへ戻るボタン
    fileprivate func setupBackButton() {
        
        backButton.setTitle("Back", for: .normal)
        // ボタンのフォントサイズ
        backButton.titleLabel?.font =  UIFont.systemFont(ofSize: 36)
        backButton.setTitleColor(UIColor.systemGreen, for: .normal)
        backButton.layer.cornerRadius = 10
        
        backButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        // 背景色
        backButton.backgroundColor = UIColor.init(red:0.9, green: 0.9, blue: 0.9, alpha: 1)
        
        // タップされたときのaction
        backButton.addTarget(self,
                             action: #selector(self.buttonTapped(_:)),
                             for: .touchUpInside)
        
        webView.addSubview(backButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: webView.topAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: webView.leadingAnchor,constant: 10).isActive = true
        backButton.widthAnchor.constraint(equalTo: webView.widthAnchor,multiplier: 0.3).isActive = true
        backButton.heightAnchor.constraint(equalTo: webView.heightAnchor,multiplier: 0.1).isActive = true
        
        
    }
    
    //実際に前の画面へ戻る処理
    @objc func buttonTapped(_ sender : UIButton) {
            dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWebView()
        setupBackButton()
        
        let urlString = UserDefaults.standard.object(forKey: "url")
        let url = URL(string: urlString as! String)
        let request = URLRequest(url: url!)
        webView.load(request)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

}
