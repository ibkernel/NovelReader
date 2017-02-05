//
//  ViewController.swift
//  WebReader
//
//  Created by Wayne Chang on 2017/2/2.
//  Copyright © 2017年 WayneChang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var BookTitle: UILabel!
    @IBOutlet weak var BookListTable: UITableView!
    var books: [Book] = [Book]()
    var selectedBook: Book!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        getBookTitle() { bt in
//            self.BookTitle.text = bt
//        }
        BookListTable.estimatedRowHeight = 88
        //BookListTable.separatorColor = UIColor.clear
        BookListTable.separatorStyle = UITableViewCellSeparatorStyle.none
        //BookListTable.rowHeight = UITableViewAutomaticDimension
        books.append(UUBook(bookUrl: "http://sj.uukanshu.com/book.aspx?id=39314"))
        books.append(UUBook(bookUrl: "http://sj.uukanshu.com/book.aspx?id=48319"))
        //book[0].printBookInfo()
        for book in books {
            book.setBookInfo(){ bookName in
                self.BookListTable.reloadData()
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showContentTable" {
            let secondViewController = segue.destination as! TableContentViewController
            secondViewController.bookInfo = selectedBook
        }
    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You clicked me at \(indexPath.row)")
        //let destinationVC = TableContentViewController()
        selectedBook = books[indexPath.row]
        //destinationVC.message = "\(indexPath.row)" as NSString!
        self.performSegue(withIdentifier: "showContentTable", sender: self)
        
        //self.performSegueWithIdentifier("idFirstSegue", sender: self)
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.BookListTable.rowHeight = 88
        
        let cell: UITableViewCell
        let titleData = books[indexPath.row].bookTitle
        cell = tableView.dequeueReusableCell(withIdentifier: "bookTitleCell", for: indexPath)
        
        (cell as! BookTitleCell).textLabel?.text = titleData
        (cell as! BookTitleCell).detailTextLabel?.text = "Author: 作者"
        (cell as! BookTitleCell).imageView?.image = UIImage(named: "test2.jpg")
        //(cell as! BookTitleCell).bookTitleButton.setTitle(titleData, for: .normal)
        //print(titleData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Urls.count
    }
}
