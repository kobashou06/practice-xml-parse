//
//  NewsPageViewController.swift
//  Swift5IntroApp1
//
//  Created by user on 2021/04/16.
//

//タップされたニュース記事ごとの処理

import UIKit
import SegementSlide

class NewsPageViewController: UITableViewController {
    
    //json, xml共通使用
    var articleArray = [ArticleModel]()
    var urlString: String
    private var jsonParseFlag: Bool
    
    //XML解析で使用
    var parser = XMLParser()
    var currentElementName: String!
    
    init(urlString: String, jsonParseFlag: Bool) {
        
        self.urlString = urlString
        self.jsonParseFlag = jsonParseFlag
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if jsonParseFlag == true {
            
            request()
            
        } else {
            
            xmlParse()
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    
    
}

extension NewsPageViewController: SegementSlideContentScrollViewDelegate {
    
    @objc var scrollView: UIScrollView {
        return tableView
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        let article = self.articleArray[indexPath.row]
        
        if jsonParseFlag == true {
            
            cell.backgroundColor = .systemGreen
            
        } else {
            
            cell.backgroundColor = .systemRed
            
        }
        
        cell.textLabel?.text = article.title
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        cell.textLabel?.textColor = .black
        cell.textLabel?.numberOfLines = 3
            
        cell.detailTextLabel?.text = article.url
        cell.detailTextLabel?.textColor = .black
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //１：遷移先の設定
        let nextPageController: WebViewController = WebViewController()
        //２：トランジションの指定, 渡すURLを準備
        nextPageController.modalTransitionStyle = .coverVertical
        
        guard let url = self.articleArray[indexPath.row].url else {
            return
        }
        
        nextPageController.urlString = url
        //３：ナビゲーションコントローラーを生成
        let navigationController = UINavigationController(rootViewController: nextPageController)
        //４：次の画面へGO
        present(navigationController, animated: true, completion: nil)

    }
    
}
