//
//  NewsPageViewController.swift
//  Swift5IntroApp1
//
//  Created by user on 2021/04/16.
//

//タップされたニュース記事ごとの処理

import UIKit
import SegementSlide
import Alamofire
import SwiftyJSON
import ImpressiveNotifications

class NewsPageViewController: UITableViewController {
    
    //json, xml共通使用
    private var articleArray = [ArticleModel]()
    var urlString: String
    private var jsonParseFlag: Bool
    
    //XML解析で使用
    var parser = XMLParser()
    var currentElementName = ""
    
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
    
    private func notificationError() {
        INNotifications.show(type: .danger,
                             data: INNotificationData(title: "記事の取得に失敗しました",
                                                      image: nil,
                                                      delay: 2.0))
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
        return articleArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height / 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        let article = articleArray[indexPath.row]
        
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
        
        guard let url = articleArray[indexPath.row].url else {
            return
        }
        
        nextPageController.urlString = url
        //３：ナビゲーションコントローラーを生成
        let navigationController = UINavigationController(rootViewController: nextPageController)
        //４：次の画面へGO
        present(navigationController, animated: true, completion: nil)

    }
    
    //JSONパース
    func request() {

        AF.request(urlString as URLConvertible , method: .get, encoding: JSONEncoding.default).responseJSON { [weak self]
            response in
            switch response.result {
            case .success:
                do {
                    
                    guard let data = response.data else {
                        self?.notificationError()
                        return
                    }
                    
                    let json: JSON = try JSON(data: data)
                    var totalHitCount = json.count
                    
                    if totalHitCount > 50 {
                        totalHitCount = 50
                    }
                    
                    for i in 0...totalHitCount - 1 {
                        
                        if json[i]["title"] != "" && json[i]["url"] != "" {
                            
                            let item = ArticleModel()
                            item.title = json[i]["title"].string
                            item.url = json[i]["url"].string
                            self?.articleArray.append(item)
                           
                        }
                    }
                    
                } catch {
                    self?.notificationError()
                }
                
                break
                
            case .failure:
                self?.notificationError()
                break
                
            }
            
            self?.tableView.reloadData()
            
        }
        
    }
    
}

extension NewsPageViewController: XMLParserDelegate {
    
    func xmlParse() {
        
        guard let url = URL(string: urlString) else {
            notificationError()
            return
        }
        
        guard let parser =  XMLParser(contentsOf: url) else {
            notificationError()
            return
        }
        
        parser.delegate = self
        parser.parse()
        
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElementName = ""
        
        if elementName == "item" {
            
            articleArray.append(ArticleModel())
            
        } else {
            
            currentElementName = elementName
            
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if articleArray.count > 0 {
            
            let lastItem = articleArray[articleArray.count - 1]
            
            switch currentElementName {
            
            case "title":
                lastItem.title = string
                
            case "link":
                lastItem.url = string
                
            default:
                break
                
            }
            
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        currentElementName = ""
        
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        
        tableView.reloadData()
        
    }
    
}
