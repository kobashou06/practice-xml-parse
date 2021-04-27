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
    
    @IBOutlet weak var backButton: UIButton!
    
    var webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        
        view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        webView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        let urlString = UserDefaults.standard.object(forKey: "url")
        let url = URL(string: urlString as! String)
        let request = URLRequest(url: url!)
        webView.load(request)
        
    }
    
    @IBAction func back(_ sender: UIButton) {
//        let baseViewController = BaseViewController()
//        baseViewController.modalPresentationStyle = .fullScreen
//        present(baseViewController, animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
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
