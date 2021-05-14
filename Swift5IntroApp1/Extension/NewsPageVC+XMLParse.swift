//
//  NewsPageVC+XMLParse.swift
//  Swift5IntroApp1
//
//  Created by user on 2021/05/14.
//

import Foundation

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
