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
    
    var headerView = UIView()
    var webView = WKWebView()
    var backButton = UIButton()
    var headerHeight: CGFloat = 0.0

    fileprivate func setupHeader(){

        if #available(iOS 11.0, *) {
            print("true")
            print(view.bounds.size.height)
            headerHeight = (view.bounds.size.height / 14)

        } else {
            print("false")
            print(view.bounds.size.height)
            headerHeight = (view.bounds.size.height / 14)

        }

        headerView.backgroundColor = .systemGray
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true

    }
    
    //Webサイト表示画面
    fileprivate func setupWebView() {
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.topAnchor,constant: headerHeight).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        webView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
    }
    
    //記事リストへ戻るボタン
    fileprivate func setupBackButton() {
        
        backButton.setTitle("< 戻る", for: .normal)
        // ボタンのフォントサイズ
        backButton.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 18)
        backButton.setTitleColor(UIColor.green, for: .normal)
        backButton.layer.cornerRadius = 10
        
        backButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        // タップされたときのaction
        backButton.addTarget(self,
                             action: #selector(self.buttonTapped(_:)),
                             for: .touchUpInside)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor,constant: 5).isActive = true
        backButton.widthAnchor.constraint(equalTo: headerView.widthAnchor,multiplier: 0.2).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        
    }
    
    //実際に前の画面へ戻る処理
    @objc func buttonTapped(_ sender : UIButton) {
            dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(headerView)
        view.addSubview(webView)
        view.addSubview(backButton)
        
        setupHeader()
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
