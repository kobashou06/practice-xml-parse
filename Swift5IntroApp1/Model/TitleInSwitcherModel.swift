//
//  TitleInSwitcherModel.swift
//  Swift5IntroApp1
//
//  Created by user on 2021/05/11.
//

import Foundation

struct TitleInSwitcherModel {
    
    var words: [String] = []
    
    mutating func getTitle(jsonParseFlag: Bool) -> [String] {
        
        if jsonParseFlag == false {
            
            words = ["TOP","Abema TIMES","Yahoo! JAPAN クリエイターズプログラム","IT","BuzzFeed Japan","CNN.co.jp"]
            
            return words
            
        }
        
        words = ["Swift","CocoaPods","Carthage","Xcode","SwiftUI","アーキテクチャ"]
        
        return words
            
    }
    
}
