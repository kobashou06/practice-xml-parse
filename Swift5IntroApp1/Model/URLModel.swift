//
//  URLs.swift
//  Swift5IntroApp1
//
//  Created by user on 2021/05/10.
//

import Foundation

struct URLModel{
    
    var url = "https://qiita.com/api/v2/items?query="
    let word: String!
    
    init(word: String){
        self.word = word
        self.url = self.url + self.word
    }
    
}
