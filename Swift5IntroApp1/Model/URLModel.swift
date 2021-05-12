//
//  URLs.swift
//  Swift5IntroApp1
//
//  Created by user on 2021/05/10.
//

import Foundation

struct URLModel{
    
    var baseUrl = "https://qiita.com/api/v2/items?query="
    var searchUrl = ""
    var encodeUrlString = ""
    
    //BaseVCからキーワードを受け取り、URLを生成する
    mutating func setupURL(word: String){
        
        self.searchUrl = self.baseUrl + word
        //デフォルトのURLを与えることで、Forced unwrappingをしない
        self.encodeUrlString = self.searchUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "https://qiita.com/api/v2/items"
    
    }
    
}
