//
//  WebViewController.swift
//  Swift5IntroApp1
//
//  Created by user on 2021/04/16.
//

//実際のニュース記事の表示画面

import UIKit
import WebKit
import ImpressiveNotifications

class WebViewController: UIViewController {
    
    private var webView = WKWebView()
    private var urlModel = URLModel()
    var urlString: String = ""
    
    //Webサイト表示画面
    private func setupWebView() {
        
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
            UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(close(_:)))
        //２：生成したボタンを、ナビゲーションバー左部分に配置
        navigationItem.setLeftBarButtonItems([sideMenuBarButtonItem], animated: true)
        
        view.addSubview(webView)
        
        setupWebView()
        
        //NewsPageVCから受け取ったURL文字列を引数に、URLModelからURLRequest型の値を受け取る
        urlModel.setRequestURL(urlString: urlString)
        
        //webView.loadのときアンラップが必要なので
        guard let url = urlModel.requestUrl else {
            
            if let homeurl = URL(string: urlModel.homeUrl) {
                webView.load(URLRequest(url: homeurl) )
            }
            
            //ImpressiveNotificationsを使って、通知（URLの不正を伝える）
            INNotifications.show(type: .danger,
                                 data: INNotificationData(title: "URL Not Found",
                                                          description: "自動的にHomeへ遷移しました",
                                                          image: nil,
                                                          delay: 5.0))
            
            return
        }
        
        webView.load(url)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //このviewを表示するとき、NavigationBarは隠さない
        let webViewNavigationController = presentingViewController as? UINavigationController
        webViewNavigationController?.isNavigationBarHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //このviewを破棄するとき、NavigationBarを隠す
        let webViewNavigationController = presentingViewController as? UINavigationController
        webViewNavigationController?.isNavigationBarHidden = true
        
    }
    
    //ナビゲーションバーボタンが押された時に実行される
    @objc private func close(_ sender: UIBarButtonItem){
        //現在の画面を破棄する
        dismiss(animated: true, completion: nil)
    }
    

}
