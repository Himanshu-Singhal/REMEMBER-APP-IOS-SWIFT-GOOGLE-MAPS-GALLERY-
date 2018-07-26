//
//  NotesList+CoreDataProperties.swift
//  NoteTakingApp
//
//  Created by MacStudent on 2017-08-12.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import Foundation
import CoreData


extension NotesList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NotesList> {
        return NSFetchRequest<NotesList>(entityName: "NotesList");
    }

    @NSManaged public var image: NSData?
    @NSManaged public var note: String?
    @NSManaged public var latitude: String?
    @NSManaged public var longtitude: String?

}
