//
//  Moment+CoreDataProperties.swift
//  Moments
//
//  Created by Monica on 19/04/19.
//  Copyright © 2019 user. All rights reserved.
//
//

import Foundation
import CoreData


extension Moment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Moment> {
        return NSFetchRequest<Moment>(entityName: "Moment")
    }

    @NSManaged public var color: String?
    @NSManaged public var createdAt: Int64
    @NSManaged public var day: Int16
    @NSManaged public var desc: String?
    @NSManaged public var modifiedAt: Int64
    @NSManaged public var momentDate: Date?
    @NSManaged public var momentId: String?
    @NSManaged public var momentMonth: Date?
    @NSManaged public var momentTime: Int64
    @NSManaged public var momentWeek: Date?
    @NSManaged public var momentYear: Int16
    @NSManaged public var month: Int16
    @NSManaged public var name: String?
    @NSManaged public var searchToken: String?
    @NSManaged public var year: Int16

}
