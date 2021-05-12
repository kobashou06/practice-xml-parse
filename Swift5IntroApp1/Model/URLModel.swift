//
//  URLs.swift
//  Swift5IntroApp1
//
//  Created by user on 2021/05/10.
//

import Foundation

struct URLModel{
    
    var baseUrl = "https://qiita.com/api/v2/items?query="
    var defaultUrl = "https://qiita.com/api/v2/items"
    var errorUrl = "https://qiita.com/404"
    var urlString: String?
    var encodeUrlString: String?
    
    //HomeVCからキーワードを受け取り、生成したURLを返す
    mutating func getURLString(word: String?) -> String? {
        
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
        
    }
    
    func getRequestURL(urlString: String) -> URLRequest {
        
        let url: URL
        
        //受け取った文字列がURL形式出ない（nil）の時、ErrorページのURLを返す
        if URL(string: urlString) == nil {
            
            //ここでの「！」はURLの返り値がnilでないことを示す
            url = URL(string: errorUrl)!
            
        }else {
            //ここでの「！」はURLの返り値がnilでないことを示す
            url = URL(string: urlString)!

        }
        
        let requestUrl = URLRequest(url: url)
        
        return requestUrl
        
    }
    
}
