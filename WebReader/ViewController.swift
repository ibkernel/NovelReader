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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        getBookTitle() { bt in
//            self.BookTitle.text = bt
//        }
//        BookListTable.estimatedRowHeight = 100
        //BookListTable.rowHeight = UITableViewAutomaticDimension
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        BookListTable.reloadData()
    }
    

}


extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        print("in tableView")
        let titleData = BookTitles[indexPath.row]
        cell = tableView.dequeueReusableCell(withIdentifier: "bookTitleCell", for: indexPath)
        
        (cell as! BookTitleCell).textLabel?.text = titleData
        (cell as! BookTitleCell).detailTextLabel?.text = "Author: 作者"
        (cell as! BookTitleCell).imageView?.image = UIImage(named: "test2.jpg")
        //(cell as! BookTitleCell).bookTitleButton.setTitle(titleData, for: .normal)
        print(titleData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Urls.count
    }
}
