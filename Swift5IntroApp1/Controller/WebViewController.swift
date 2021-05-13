//
//  WebViewController.swift
//  Swift5IntroApp1
//
//  Created by user on 2021/04/16.
//

//実際のニュース記事の表示画面

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var webView = WKWebView()
    var urlModel = URLModel()
    var urlString: String = ""
    
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
        
        view.addSubview(webView)
        
        setupWebView()
        
        //NewsPageVCから受け取ったURL文字列を引数に、URLModelからURLRequest型の値を受け取る
        urlModel.setRequestURL(urlString: self.urlString)
        
        //webView.loadのときアンラップが必要なので
        guard let url = urlModel.requestUrl else {
            return
        }
        
        webView.load(url)
        
        edgesForExtendedLayout = []
        
        //１：サイドメニューバーボタンを生成
        let sideMenuBarButtonItem: UIBarButtonItem =
            UIBarButtonItem(image:UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(close(_:)))
        //２：生成したボタンを、ナビゲーションバー左部分に配置
        navigationItem.setLeftBarButtonItems([sideMenuBarButtonItem], animated: true)
        
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
    @objc func close(_ sender: UIBarButtonItem){
        //現在の画面を破棄する
        dismiss(animated: true, completion: nil)
    }
    

}
