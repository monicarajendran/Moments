//
//  MomentExtenion.swift
//  Moments
//
//  Created by user on 06/08/1939 Saka.
//  Copyright © 1939 Saka user. All rights reserved.
//

import Foundation
import CloudKit
import SwiftDate

extension Moment {
    
    func toICloudRecord() -> CKRecord {
        
        let recordID = CKRecordID(recordName: self.momentID!)
        
        let record = CKRecord(recordType: "Moment", recordID: recordID)
        
        record["name"] = self.name as CKRecordValue?
        record["desc"] = self.desc as CKRecordValue?
        record["momentTime"] = self.momentTime as CKRecordValue?
        record["momentDate"] = self.momentDate as CKRecordValue?
        record["createdAt"] = self.createdAt as CKRecordValue?
        record["modifiedAt"] = self.modifiedAt as CKRecordValue?
        record["day"] = self.day as CKRecordValue?
        record["month"] = self.month as CKRecordValue?
        record["year"] = self.year as CKRecordValue?
        record["momentID"] = self.momentID as CKRecordValue?
        record["color"] = self.color as CKRecordValue?
        record["searchToken"] = self.searchToken as CKRecordValue?
        
        return record
    }
    
    func updateICloudRecord(record: CKRecord){
        
        record.setObject(self.name as CKRecordValue?, forKey: "name")
        record.setObject(self.desc as CKRecordValue?, forKey: "desc")
        record.setObject(self.momentTime as CKRecordValue?, forKey: "momentTime")
        record.setObject(self.momentDate as CKRecordValue?, forKey: "momentDate")
        record.setObject(self.createdAt as CKRecordValue?, forKey: "createdAt")
        record.setObject(self.modifiedAt as CKRecordValue?, forKey: "modifiedAt")
        record.setObject(self.day as CKRecordValue?, forKey: "day")
        record.setObject(self.month as CKRecordValue?, forKey: "month")
        record.setObject(self.year as CKRecordValue?, forKey: "year")
        record.setObject(self.color as CKRecordValue?, forKey: "color")
        record.setObject(self.searchToken as CKRecordValue?, forKey: "searchToken")
        
    }
    
    func fromICloudRecordToMoment(record: CKRecord) -> (Moment) {
        print(record)
        
        self.name = record.object(forKey: "name") as? String? ?? " "
        self.desc = record.object(forKey: "desc") as? String? ?? " "
        self.momentTime = record.object(forKey: "momentTime") as? NSNumber? as? Int64 ?? 0
        self.momentDate = record.object(forKey: "momentDate") as? Date ?? momentTime.toDate.startOfDay
        self.createdAt = record.object(forKey: "createdAt") as? NSNumber? as? Int64 ?? 0
        self.modifiedAt = record.object(forKey: "modifiedAt") as? NSNumber? as? Int64 ?? 0
        self.day = record.object(forKey: "day") as? NSNumber? as? Int16 ?? 0
        self.month = record.object(forKey: "month") as? NSNumber? as? Int16 ?? 0
        self.year = record.object(forKey: "year") as? NSNumber? as? Int16 ?? 0
        self.momentID = record.object(forKey: "momentID") as? String? ?? " "
        self.color = record.object(forKey: "color") as? String? ?? " "
        self.searchToken = record.object(forKey: "searchToken") as? String? ?? " "
        
        return self
    }
}

