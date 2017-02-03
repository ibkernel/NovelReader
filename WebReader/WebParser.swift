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
    case book2 = "http://sj.uukanshu.com/book.aspx?id=48319"
    
    static var count: Int { return Urls.book2.hashValue + 1}
}

var BookTitles: [String] = [
    "書名1","書名2"
]

var url = NSURL(string: Urls.book1.rawValue)
//var domain = url!.host + "/"
var domain:String? = (url?.host)! + "/"
var n:String? = "read.aspx?tid=39314&sid=145510"


var NonSense: [String] = [
    "(adsbygoogle = window.adsbygoogle || []).push({});", "章节缺失、错误举报", "U","看书"
]

func getBookTitle(completionHandler: @escaping (String) ->()){
    //var bookTitle: String?;
    Alamofire.request(Urls.book1.rawValue).response { response in

        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
            if let doc = Kanna.HTML(html: utf8Text, encoding: .utf8) {
                if let bookname = doc.at_css("dl dt"){
                    
                    completionHandler(bookname.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
                }
            }
        }
    }
    
}

func getPureContent() -> Void {
    Alamofire.request(Urls.book1.rawValue).response { response in
//        print("Request: \(response.request)")
//        print("Response: \(response.response)")
//        print("Error: \(response.error)")

        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
            if let doc = Kanna.HTML(html: utf8Text, encoding: .utf8) {
                //print(doc.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
                if let bookname = doc.at_css("dl dt"){
                    print(bookname.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
                }
                
                // Search for nodes by XPath
                for link in doc.xpath("//div[contains(@class, 'ml-list')] // a") {
                    print(link.text!)
                    //print(link["href"]!)
                }
                print(domain!)
            }
        }
    }
    
    let a = "http://"+domain!+"read.aspx?tid=39314&sid=145510"
    
    Alamofire.request(a).response { response in
        print("\(response.request)")
        print("\(response.data)")
        
        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
            var refinedText = utf8Text
            for words in NonSense {
                refinedText = refinedText.replacingOccurrences(of: words, with: "")
            }
            if let doc = Kanna.HTML(html: refinedText, encoding: .utf8) {
                //print(doc.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
                var rawChapterContent: String = ""
                //print(doc.text!)
                //var refinedChapterContent: String = ""
                // Search for nodes by XPath
                
                for content in doc.xpath("//div[contains(@id, 'bookContent')]") {
                    rawChapterContent += content.text!
                }
                //for words in NonSense {
                //    rawChapterContent = rawChapterContent.replacingOccurrences(of: words, with: "")
                //}
                print(rawChapterContent)
            }
        }
    }


}
