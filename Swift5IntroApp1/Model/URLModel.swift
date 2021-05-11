//
//  URLs.swift
//  Swift5IntroApp1
//
//  Created by user on 2021/05/10.
//

import Foundation

struct URLModel{
    
    var baseUrl = "https://qiita.com/api/v2/items?query="
    let words = ["Swift","CocoaPods","Carthage","Xcode","SwiftUI","アーキテクチャ"]
    var searchUrl = ""
    var encodeUrlString = ""
    
    mutating func setupURL(index: Int){
        
        self.searchUrl = self.baseUrl + self.words[index]
        self.encodeUrlString = self.searchUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    
    }
    
}
