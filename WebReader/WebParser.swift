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


class Book {
    
    let bookUrl: String
    var bookTitle: String?
    var bookAuthor: String?
    var updateDate: String?
    
    init(url: String) {
        bookUrl = url
    }
    func printBookInfo() {
        assert(false, "This method must be overriden by the subclass")
    }

    func setBookInfo(completion: @escaping (String) -> Void) {
        assert(false, "This method must be overriden by the subclass")
    }
    
}

class UUBook: Book {
    
    override func setBookInfo(completion: @escaping (String) -> Void) {
        Alamofire.request(self.bookUrl).response { response in
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                if let doc = Kanna.HTML(html: utf8Text, encoding: .utf8) {
                    if let bookname = doc.at_css("dl dt"){
                        
                        self.bookTitle = s2t(text: bookname.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
                        completion(self.bookTitle!)
                    }
                }
            }
        }
        
    }

    override func printBookInfo() {
        print("\(self.bookTitle), \(self.bookUrl)")
    }
    
    init(bookUrl: String) {
        super.init(url: bookUrl)
    }
}


enum Urls: String {
    case book1 = "http://sj.uukanshu.com/book.aspx?id=39314"
    case book2 = "http://sj.uukanshu.com/book.aspx?id=48319"
    
    static var count: Int { return Urls.book2.hashValue + 1}
}


var url = NSURL(string: Urls.book1.rawValue)
var domain:String? = (url?.host)! + "/"
var NonSense: [String] = [
    "(adsbygoogle = window.adsbygoogle || []).push({});", "章节缺失、错误举报", "U","看书","请记住本书首发域名",
    "言情小说网手机版阅读网址：","手机版阅读网址：", "：。"
]
typealias chapterTuple = (text: String?, url: String?)




func getBookChapterList(url: String, completionHandler: @escaping ([chapterTuple]) -> () ){
    
    var chapterList: [chapterTuple] = []
    var chapterInfo:(String?, String?) = (nil, nil)
    
    Alamofire.request(url).response { response in
        if let data = response.data, let utf8Text = String(data:data, encoding: .utf8) {
            if let doc = Kanna.HTML(html: utf8Text, encoding: .utf8) {
                for link in doc.xpath("//div[contains(@class, 'ml-list')] // a") {
                    chapterInfo = (text:s2t(text:link.text!), url:link["href"]!)
                    chapterList.append(chapterInfo)
                }
                completionHandler(chapterList)
            }
        }
    }
}

func getBookTitle(completionHandler: @escaping (String) ->()){
    //var bookTitle: String?;
    Alamofire.request(Urls.book1.rawValue).response { response in
        
        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
            if let doc = Kanna.HTML(html: utf8Text, encoding: .utf8) {
                if let bookname = doc.at_css("dl dt"){
                    let bookNameT = s2t(text:bookname.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
                    completionHandler(bookNameT)
                }
            }
        }
    }
    
}
func getChapterContent(url: String, completionHandler: @escaping (String, String, String?) -> ()){
    
    var contentText: String = ""
    let fullUrl = "http://" + domain! + url
    var nextUrl: String?
    var chapterTitle: String!
    
    Alamofire.request(fullUrl).response{ response in
        if let data = response.data, var utf8Text = String(data:data, encoding: .utf8){
            // refine content presentation
            utf8Text = utf8Text.replacingOccurrences(of: "<br>", with: "\n")
            utf8Text = utf8Text.replacingOccurrences(of: "<br/>", with: "\n")
            utf8Text = utf8Text.replacingOccurrences(of: "<p>", with: "\n")
            utf8Text = utf8Text.replacingOccurrences(of: "<p/>", with: "\n")
            if let doc = Kanna.HTML(html: utf8Text, encoding: .utf8) {
                
                for txt in doc.xpath("//h3"){
                    chapterTitle = txt.text
                }
                
                contentText = s2t(text: chapterTitle)! + "\n"
                
                for content in doc.xpath("//div[contains(@id, 'bookContent')]") {
                    contentText += content.text!
                }
                
                for url in doc.xpath("//div[contains(@class, 'rp-switch')] //a[contains(@id, 'read_next')]") {
                    nextUrl = url["href"]
                }
                /*
                // This method sucks, too many uncertainties
                
                let tmp = doc.xpath("//div[contains(@id, 'bookContent')] //p")
                if tmp.count == 0 {
                    for content in doc.xpath("//div[contains(@id, 'bookContent')]") {
                        contentText += content.text!
                    }
                    contentText = contentText.replacingOccurrences(of: "　　", with: "\n        ")

                } else {
                    
                    // In some situation there are texts not in <p/>
                    
                    
                    for content in doc.xpath("//div[contains(@id, 'bookContent')] //p") {
                        contentText += "    "
                        contentText += content.text!
                        contentText += "\n"
                    }
                    print(doc.text!)
                    
                    
                }
                */

                
                // Compare time with the replacing function inside the above for-loop
                for words in NonSense {
                    contentText = contentText.replacingOccurrences(of: words, with: "")
                }
                contentText = s2t(text: contentText)!
                completionHandler(contentText, chapterTitle, nextUrl)
            }
            
        }
    
    }
    
}
