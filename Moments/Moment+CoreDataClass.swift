//
//  Moment+CoreDataClass.swift
//  Moments
//
//  Created by Monica on 19/04/19.
//  Copyright © 2019 user. All rights reserved.
//
//

import Foundation
import CoreData
import CloudKit

@objc(Moment)
public class Moment: NSManagedObject {

    func fromICloudRecordToMoment(record: Record) -> (Moment) {
        print(record)
        
        self.name = record.name
        self.desc = record.desc
        self.momentTime = record.time
        self.momentDate = record.recordDate
        self.momentMonth = record.recordMonth
        self.momentWeek = record.recordWeek
        self.momentYear = record.recordYear
        self.createdAt = record.createdAt
        self.modifiedAt = record.modifiedAt
        self.day = record.day
        self.month = record.month
        self.year = record.year
        self.momentId = record.id
        self.color = record.color
        self.searchToken = record.searchToken
        
        return self
    }
    
    func toICloudRecord() -> CKRecord {
        
        let recordID = CKRecordID(recordName: self.momentId!)
        let record = CKRecord(recordType: "Moment", recordID: recordID)
        
        record["name"] = self.name as CKRecordValue?
        record["desc"] = self.desc as CKRecordValue?
        record["momentTime"] = self.momentTime as CKRecordValue?
        record["momentDate"] = self.momentDate as CKRecordValue?
        record["momentMonth"] = self.momentMonth as CKRecordValue?
        record["momentWeek"] = self.momentWeek as CKRecordValue?
        record["momentYear"] = self.momentYear as CKRecordValue?
        record["createdAt"] = self.createdAt as CKRecordValue?
        record["modifiedAt"] = self.modifiedAt as CKRecordValue?
        record["day"] = self.day as CKRecordValue?
        record["month"] = self.month as CKRecordValue?
        record["year"] = self.year as CKRecordValue?
        record["momentID"] = self.momentId as CKRecordValue?
        record["color"] = self.color as CKRecordValue?
        record["searchToken"] = self.searchToken as CKRecordValue?
        
        return record
    }
    

}
