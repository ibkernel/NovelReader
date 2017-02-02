//
//  WebParser.swift
//  WebReader
//
//  Created by Wayne Chang on 2017/2/2.
//  Copyright © 2017年 WayneChang. All rights reserved.
//

import Foundation
import Alamofire
import Kanna

enum Urls: String {
    case book1 = "http://sj.uukanshu.com/book.aspx?id=39314"
}

var NonSense: [String] = [String]()

func getPureContent() -> Void {
    Alamofire.request(Urls.book1.rawValue).response { response in
        print("Request: \(response.request)")
        print("Response: \(response.response)")
        print("Error: \(response.error)")
    
        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
            if let doc = Kanna.HTML(html: utf8Text, encoding: .utf8) {
                print(doc.title!)
                
//                // Search for nodes by CSS
//                for link in doc.css("a, link") {
//                    print(link.text)
//                    print(link["href"])
//                }
//                
//                // Search for nodes by XPath
//                for link in doc.xpath("//a | //link") {
//                    print(link.text)
//                    print(link["href"])
//                }
            }
        }
    }
}
