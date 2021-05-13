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

class NewsPageViewController: UITableViewController {
    
    //共通で使用
    private var articleArray = [ArticleModel]()
    private var urlModel = URLModel()
    private var urlString: String
    private var jsonParseFlg: Bool
    
    //XML解析で使用
    private var parser = XMLParser()
    private var currentElementName: String!
    
    init(urlString: String, jsonParseFlg: Bool) {
        
        self.urlString = urlString
        self.jsonParseFlg = jsonParseFlg
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if jsonParseFlg == true {
            
            request()
            
        }else{
            
            xmlParse()
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    
    
}

extension NewsPageViewController: SegementSlideContentScrollViewDelegate {
    
    @objc var scrollView: UIScrollView{
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
        
        if jsonParseFlg == true {
            
            cell.backgroundColor = .systemGreen
            
        }else{
            
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
        //２：トランジションの指定,渡すURLを準備
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

extension NewsPageViewController {
    
    //JSONパース
    private func request() {

        AF.request(urlString as URLConvertible , method: .get,encoding: JSONEncoding.default).responseJSON{(response) in
            switch response.result{
            case .success:
                do{
                    
                    let json: JSON = try JSON(data: response.data!)
                    var totalHitCount = json.count
                    
                    if totalHitCount > 50{
                        totalHitCount = 50
                    }
                    
                    for i in 0...totalHitCount - 1 {
                        
                        if json[i]["title"] != "" && json[i]["url"] != "" {
                            
                            let item = ArticleModel()
                            item.title = json[i]["title"].string
                            item.url = json[i]["url"].string
                            self.articleArray.append(item)
                           
                        }else{
                            print("何かしらが空です")
                        }
                    }
                    
                }catch{
                    print("error")
                }
                
                break
                
            case .failure: break
                
            }
            
            self.tableView.reloadData()
            
        }
        
    }
    
}

extension NewsPageViewController: XMLParserDelegate {
    
    func xmlParse() {
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        guard let parser =  XMLParser(contentsOf: url) else {
            return
        }
        
        parser.delegate = self
        parser.parse()
        
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElementName = nil
        
        if elementName == "item" {
            
            self.articleArray.append(ArticleModel())
            
        }else{
            
            currentElementName = elementName
            
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if self.articleArray.count > 0 {
            
            let lastItem = self.articleArray[self.articleArray.count - 1]
            print(lastItem)
            
            switch self.currentElementName {
            
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
        
        self.currentElementName = nil
        
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        
        self.tableView.reloadData()
        
    }
    
}
