//
//  NewsPageVC+JSONParse.swift
//  Swift5IntroApp1
//
//  Created by user on 2021/05/14.
//

import Foundation
import Alamofire
import SwiftyJSON

extension NewsPageViewController {
    
    //JSONパース
    func request() {

        AF.request(urlString as URLConvertible , method: .get,encoding: JSONEncoding.default).responseJSON{(response) in
            switch response.result{
            case .success:
                do {
                    
                    let json: JSON = try JSON(data: response.data!)
                    var totalHitCount = json.count
                    
                    if totalHitCount > 50 {
                        totalHitCount = 50
                    }
                    
                    for i in 0...totalHitCount - 1 {
                        
                        if json[i]["title"] != "" && json[i]["url"] != "" {
                            
                            let item = ArticleModel()
                            item.title = json[i]["title"].string
                            item.url = json[i]["url"].string
                            self.articleArray.append(item)
                           
                        } else {
                            print("何かしらが空です")
                        }
                    }
                    
                } catch {
                    print("error")
                }
                
                break
                
            case .failure: break
                
            }
            
            self.tableView.reloadData()
            
        }
        
    }
    
}
