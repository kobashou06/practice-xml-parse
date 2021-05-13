//
//  URLs.swift
//  Swift5IntroApp1
//
//  Created by user on 2021/05/10.
//

import Foundation

struct URLModel {
    
    //jsonParse
    let baseUrl = "https://qiita.com/api/v2/items?query="
    let defaultUrl = "https://qiita.com/api/v2/items"
    let errorUrl = "https://qiita.com/404"
    let homeUrl = "https://qiita.com/"
    var urlString: String?
    var encodeUrlString: String?
    var requestUrl: URLRequest?
    
    //xmlParse
    let forXMLParseUrlArray = [ "https://news.yahoo.co.jp/rss/topics/top-picks.xml",
                                "https://news.yahoo.co.jp/rss/media/abema/all.xml",
                                "https://news.yahoo.co.jp/rss/media/ycreatp/all.xml",
                                "https://news.yahoo.co.jp/rss/topics/it.xml",
                                "https://news.yahoo.co.jp/rss/media/bfj/all.xml",
                                "https://news.yahoo.co.jp/rss/media/cnn/all.xml"]
    
    //HomeVCからキーワードを受け取り、生成したURLを返す
    mutating func getURLString(index: Int, jsonParseFlg: Bool) -> String? {
        
        if jsonParseFlg == true {
            
            var titleModel = TitleInSwitcherModel()
            let words = titleModel.getTitle(jsonParseFlg: jsonParseFlg)
            let word:String? = words[index]
            
            //wordの中身をチェックする
            guard let receivedWord = word else {
                //wordがnilの場合、デフォルトURLを返す
                return defaultUrl
            }
            //urlの原型を作る
            self.urlString = self.baseUrl + receivedWord
            //パーセントエンコーディングする
            self.encodeUrlString = self.urlString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            return self.encodeUrlString
            
        }else{
            //XMLパースの場合、配列の要素を返すだけ
            return forXMLParseUrlArray[index]
            
        }
        
    }
    
    mutating func setRequestURL(urlString: String) {
        
        //受け取った文字列がURL形式出ない（nil）の時、ErrorページのURLを返す
        if let url = URL(string: urlString) {
            
            //urlStringが正しいURL形式の時の処理
            self.requestUrl = URLRequest(url: url)

        }else{
            
            //errorUrlもアンラップ
            guard let url = URL(string: errorUrl) else {
                return
            }
            
            self.requestUrl = URLRequest(url: url)
            
        }
        
    }
    
}
