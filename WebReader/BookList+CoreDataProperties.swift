//
//  BookList+CoreDataProperties.swift
//  WebReader
//
//  Created by Wayne Chang on 2017/2/15.
//  Copyright © 2017年 WayneChang. All rights reserved.
//

import Foundation
import CoreData


extension BookList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookList> {
        return NSFetchRequest<BookList>(entityName: "BookList");
    }

    @NSManaged public var bookTitle: String?
    @NSManaged public var bookUrl: String?

}
