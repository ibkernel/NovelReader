//
//  BookContentViewController.swift
//  WebReader
//
//  Created by Wayne Chang on 2017/2/6.
//  Copyright © 2017年 WayneChang. All rights reserved.
//

import UIKit

class BookContentViewController: UIViewController {

    @IBOutlet weak var chapterContentText: UITextView!
    var domain : String!
    var chapterUrl : NSString!
    var bookInfo : Book!
    var selectedBook: Book!
    var nextUrl: NSString?
    var chapterTitle: String!
    var preprocessContent: String?
    var preprocessTitle: String?
    var preprocessUrl: NSString?
    //var nextChapterTitle: String!
    

    override func viewWillAppear(_ animated: Bool) {
        print("view will appear")
        self.navigationController?.isNavigationBarHidden = true
        super.viewWillAppear(animated)
        
        
        if let t = chapterTitle {
            self.navigationItem.title = s2t(text: t)
        }
        chapterContentText.isEditable = false
        chapterContentText.backgroundColor = UserDefaults.standard.bool(forKey: "isNightMode") ? UIColor.black : UIColor.white
        switch UserDefaults.standard.string(forKey: "FontColor") {
        case "white"?:
            chapterContentText.textColor = UIColor.white
            break
        case "black"?:
            chapterContentText.textColor = UIColor.black
            break
        case "gray"?:
            chapterContentText.textColor = UIColor.gray
            break
        default:
            chapterContentText.textColor = UIColor.white
        }
        
        
        chapterContentText.font = UIFont(name: (chapterContentText?.font?.fontName)!, size: CGFloat(UserDefaults.standard.integer(forKey: "FontSize")))
        // Do any additional setup after loading the view.
        
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activityIndicator.alpha = 1.0
        self.view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "回目錄", style: UIBarButtonItemStyle.done, target: self, action: #selector(BookContentViewController.returnToChapterList(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        let optionButton = UIBarButtonItem(title: "設定", style: UIBarButtonItemStyle.done, target: self, action: #selector(BookContentViewController.goToOption(sender:)))
        self.navigationItem.rightBarButtonItem = optionButton
        let methodStart = Date()
        print("Starting: \(methodStart)");
        
        // TODO learn Dispatch
        if(self.preprocessContent == nil){
            getChapterContent(url: chapterUrl as String, domain: domain){ content, title, url in
                activityIndicator.stopAnimating()
                self.chapterContentText.text = content
                self.navigationItem.title = title
                self.nextUrl = url as? NSString
                self.chapterTitle = title
                let methodFinish = Date()
                let executionTime = methodFinish.timeIntervalSince(methodStart)
                print("Execution time: \(executionTime)")
            }
        }else {
            activityIndicator.stopAnimating()
            self.chapterContentText.text = self.preprocessContent
            self.navigationItem.title = self.preprocessTitle
            self.chapterTitle = self.preprocessTitle
            self.nextUrl = self.preprocessUrl
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        print("view did load")
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func goToOption(sender: UIBarButtonItem) {
        print("In goToOption")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OptionMenu") as! OptionMenuTableViewController
        navigationController?.pushViewController(vc,animated: true)
        
    }
    
    func returnToChapterList(sender: UIBarButtonItem) {
        print("In returnToChapterList")
        
        _ = self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])! , animated: true)
        //self.navigationController!.popToViewController(BookTableContentViewController() as! UIViewController, animated: true);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChapterContentSegue" {
            //let secondViewController = segue.destination as! BookContentViewController
            //secondViewController.chapterUrl = selectedChapter
            //secondViewController.selectedBook = bookInfo
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view appearred")
        self.preprocessContent = nil
        
        if (self.nextUrl != nil) {
            getChapterContent(url: self.nextUrl as! String, domain: domain){ content, title, url in
                self.preprocessContent = content
                self.preprocessTitle = title
                self.preprocessUrl = url as? NSString
                //self.chapterTitle = title
                print("calculated: "+title)
            }
        }

    
    }
    
    @IBAction func doubleTapAction(_ sender: Any) {
        // TODO: store this value to user setting table
        self.navigationController?.isNavigationBarHidden = !(self.navigationController?.isNavigationBarHidden)!
        //navigationController?.isNavigationBarHidden = true
        //self.navigationController?.navigationBar.isHidden = !(self.navigationController?.navigationBar.isHidden)!
    }
    
    @IBAction func handleSwipeGesture(_ sender: Any) {
        print("You have swiped me!")
        if (self.nextUrl != nil){
            let storyboardName = "Main"
            let viewControllerID = "Content"
            let storyboard = UIStoryboard(name: storyboardName, bundle:nil)
            let controller = storyboard.instantiateViewController(withIdentifier: viewControllerID) as! BookContentViewController
            controller.chapterUrl = self.nextUrl
            controller.selectedBook = self.bookInfo
            controller.preprocessTitle = self.preprocessTitle
            controller.preprocessContent = self.preprocessContent
            controller.preprocessUrl = self.preprocessUrl
            controller.domain = self.domain
            let segue = UIStoryboardSegue(identifier: "NextChapterSegue", source: self, destination: controller, performHandler: {self.navigationController?.show( controller, sender: self)})
            segue.perform()
        } else {
            let alert = UIAlertController(title: "您已讀到最一章囉", message: "今天的扣打用完了", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "該回去認真了", style: .cancel))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func swipeBackGesture(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // hide status bar only on this screen
    override var prefersStatusBarHidden: Bool {
        return true
    }

    
    
    //    @IBAction func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
    //        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
    //
    //            let translation = gestureRecognizer.translation(in: self.view)
    //            // note: 'view' is optional and need to be unwrapped
    //            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
    //            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
    //        }
    //
    //    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
