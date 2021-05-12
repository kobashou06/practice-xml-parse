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
    var urlString: String?
    var encodeUrlString: String?
    
    //HomeVCからキーワードを受け取り、生成したURLを返す
    mutating func getURLString(word: String?) -> String? {
        
        //wordの中身をチェックする
        guard let receivedWord = word else {
            return nil
        }
        //urlの原型を作る
        self.urlString = self.baseUrl + receivedWord
        //パーセントエンコーディングする
        self.encodeUrlString = self.urlString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        return self.encodeUrlString
        
    }
    
}
