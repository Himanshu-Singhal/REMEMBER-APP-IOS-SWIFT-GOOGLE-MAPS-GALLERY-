//
//  List+CoreDataProperties.swift
//  NoteTakingApp
//
//  Created by MacStudent on 2017-08-12.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List");
    }

    @NSManaged public var image: NSData?
    @NSManaged public var latitude: String?
    @NSManaged public var longtitude: String?
    @NSManaged public var notes: String?

}
