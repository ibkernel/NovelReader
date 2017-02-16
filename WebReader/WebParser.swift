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


var NonSense: [String] = [
    "請記住本站域名: 黃金屋",
]

typealias chapterTuple = (text: String?, url: String?)

class Book {
    
    let bookUrl: String
    let domain: String
    var bookTitle: String?
    var bookAuthor: String?
    var updateDate: String?
    
    init(url: String, title: String) {
        bookUrl = url
        domain = (NSURL(string: url)?.host)! + "/"
        bookTitle = title
    }
    func printBookInfo() {
        assert(false, "This method must be overriden by the subclass")
    }

    func setBookInfo(completion: @escaping (String) -> Void) {
        assert(false, "This method must be overriden by the subclass")
    }
    
    func getBookChapterList(url: String, completionHandler: @escaping ([chapterTuple]) -> () ){
        assert(false, "This method must be overriden by the subclass")
    }
    
    func getChapterContent(url: String, completionHandler: @escaping (String, String, String?) -> ()) {
        assert(false, "This method must be overriden by the subclass")
    }
    
}

class DemoBook: Book {
    
    override func setBookInfo(completion: @escaping (String) -> Void) {
        Alamofire.request(self.bookUrl).response { response in
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                if let doc = Kanna.HTML(html: utf8Text, encoding: .utf8) {
                    if let bookname = doc.at_css("h1"){
                        
                        self.bookTitle = s2t(text: bookname.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))

                        completion(self.bookTitle!)
                    }
                }
            }
        }
    }
    
    override func getBookChapterList(url: String, completionHandler: @escaping ([chapterTuple]) -> () ){
        
        var chapterList: [chapterTuple] = []
        var chapterInfo:(String?, String?) = (nil, nil)
        
        Alamofire.request(url).response { response in
            if let data = response.data, let utf8Text = String(data:data, encoding: .utf8) {
                if let doc = Kanna.HTML(html: utf8Text, encoding: .utf8) {
                    
                    for link in doc.xpath("//div[contains(@id, 'tbchapterlist')] // td // a") {
                        chapterInfo = (text:s2t(text:link.text!), url:link["href"]!)
                        chapterList.append(chapterInfo)
                    }

                    completionHandler(chapterList)
                }
            }
        }
    }
    
    override func getChapterContent(url: String, completionHandler: @escaping (String, String, String?) -> ()){
        
        var contentText: String = ""
        // Ckeck url completeness before concatenation
        let fullUrl = "http://tw.hjwzw.com/" + url
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
                    for txt in doc.xpath("//h1"){
                        chapterTitle = s2t(text:txt.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
                    }
                    //contentText = chapterTitle + "\n"
                    
                    for content in doc.xpath("//div[contains(@id, 'AllySite')]/following-sibling::div[1]") {
                        contentText += content.text!
                    }
                    
                    for url in doc.xpath("//a") {
                        if (url.text! == "下一章"){
                            let i = url["href"]!.index(url["href"]!.endIndex, offsetBy: -2)
                            let sub = url["href"]!.substring(from: i)
                            if (sub == ",0"){ break }
                            nextUrl = url["href"]
                            print(nextUrl!)
                            break
                        }
                    }
                    
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
    
    override func printBookInfo() {
        print("\(self.bookTitle), \(self.bookUrl)")
    }
    
    init(bookUrl: String, bookTitle: String) {
        super.init(url: bookUrl, title: bookTitle)
    }
}

// Used at searching vc
func getBookList(url: String, completionHandler: @escaping ([chapterTuple]) -> ()){
    
    var bookList: [chapterTuple] = []
    var bookInfo:(String?, String?) = (nil, nil)
    
    Alamofire.request(url).response { response in
        if let data = response.data, let utf8Text = String(data:data, encoding: .utf8) {
            if let doc = Kanna.HTML(html: utf8Text, encoding: .utf8) {
                for link in doc.xpath("//div/following-sibling::div[1] //a") {
                    if let title = link["title"]{
                        let correctUrl = "http://tw.hjwzw.com/" + link["href"]!.replacingOccurrences(of: "/Book/", with: "Book/Chapter/")
                        bookInfo = (text: title, url:correctUrl)
                        bookList.append(bookInfo)
                    }
                }
                completionHandler(bookList)
            }
        }
    }
}
