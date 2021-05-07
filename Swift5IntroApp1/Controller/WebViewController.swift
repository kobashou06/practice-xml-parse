//
//  WebViewController.swift
//  Swift5IntroApp1
//
//  Created by user on 2021/04/16.
//

//実際のニュース記事の表示画面

import UIKit
import WebKit

class WebViewController: UIViewController,WKUIDelegate, WKNavigationDelegate {
    
    var webView = WKWebView()
    
    //Webサイト表示画面
    fileprivate func setupWebView() {
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        webView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        
        //１：サイドメニューバーボタンを生成
        let sideMenuBarButtonItem: UIBarButtonItem =
            UIBarButtonItem(title:"< back", style: .plain, target: self, action: #selector(back(_:)))
        //２：生成したボタンを、ナビゲーションバー左部分に配置
        self.navigationItem.setLeftBarButtonItems([sideMenuBarButtonItem], animated: true)
        
        view.addSubview(webView)
        
        setupWebView()
        
        let urlString = UserDefaults.standard.object(forKey: "url")
        let url = URL(string: urlString as! String)
        let request = URLRequest(url: url!)
        
        webView.load(request)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let nc = self.presentingViewController as! UINavigationController
        nc.isNavigationBarHidden = false
        
    }
    
    //ナビゲーションバーボタンが押された時に実行される
    @objc func back(_ sender: UIBarButtonItem){
        //現在の画面を破棄する
        dismiss(animated: true, completion: nil)
    }
    

}
