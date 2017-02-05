//
//  TableContentViewController.swift
//  WebReader
//
//  Created by Wayne Chang on 2017/2/5.
//  Copyright © 2017年 WayneChang. All rights reserved.
//

import UIKit

class TableContentViewController: UIViewController {
    
    @IBOutlet weak var chapterListTable: UITableView!
    var bookInfo : Book!
    var chapters: [chapterTuple] = []
    var selectedChapter: NSString!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("In tableContentView")
        print("message sent from previous controller: \(bookInfo.bookUrl)")
        getBookChapterList(url: bookInfo.bookUrl){ chapterInfo in
            self.chapters = chapterInfo
            self.chapterListTable.reloadData()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func GoBack(_ sender: Any) {
        print("You have touched me!")
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChapterContent" {
            let secondViewController = segue.destination as! ChapterContentViewController
            secondViewController.chapterUrl = selectedChapter
            secondViewController.selectedBook = bookInfo
            
        }
    }

}


extension TableContentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Table content:::You clicked me at \(indexPath.row)")
        
        selectedChapter = chapters[indexPath.row].url as NSString!
        self.performSegue(withIdentifier: "showChapterContent", sender: self)
        
    }
}

extension TableContentViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.chapterListTable.rowHeight = 44
        
        
        let cell: UITableViewCell
        let chapterTitle = chapters[indexPath.row].text
        //let chapterUrl = chapters[indexPath.row].url
        
        cell = tableView.dequeueReusableCell(withIdentifier: "chapterTitleCell", for: indexPath)
        //let titleData = books[indexPath.row].bookTitle
        //cell = tableView.dequeueReusableCell(withIdentifier: "bookTitleCell", for: indexPath)
        
        (cell as! ChapterTitleCell).textLabel?.text = chapterTitle
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chapters.count
        //return 10
    }
}
