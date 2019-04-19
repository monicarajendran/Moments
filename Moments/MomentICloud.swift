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
    
//    func toICloudRecord() -> CKRecord {
//
//        let recordID = CKRecordID(recordName: self.momentId!)
//        let record = CKRecord(recordType: "Moment", recordID: recordID)
//
//        record["name"] = self.name as CKRecordValue?
//        record["desc"] = self.desc as CKRecordValue?
//        record["momentTime"] = self.momentTime as CKRecordValue?
//        record["momentDate"] = self.momentDate as CKRecordValue?
//        record["momentMonth"] = self.momentMonth as CKRecordValue?
//        record["momentWeek"] = self.momentWeek as CKRecordValue?
//        record["momentYear"] = self.momentYear as CKRecordValue?
//        record["createdAt"] = self.createdAt as CKRecordValue?
//        record["modifiedAt"] = self.modifiedAt as CKRecordValue?
//        record["day"] = self.day as CKRecordValue?
//        record["month"] = self.month as CKRecordValue?
//        record["year"] = self.year as CKRecordValue?
//        record["momentID"] = self.momentId as CKRecordValue?
//        record["color"] = self.color as CKRecordValue?
//        record["searchToken"] = self.searchToken as CKRecordValue?
//
//        return record
//    }
    
    func updateICloudRecord(record: CKRecord){
        
        record.setObject(self.name as CKRecordValue?, forKey: "name")
        record.setObject(self.desc as CKRecordValue?, forKey: "desc")
        record.setObject(self.momentTime as CKRecordValue?, forKey: "momentTime")
        record.setObject(self.momentDate as CKRecordValue?, forKey: "momentDate")
        record.setObject(self.momentMonth as CKRecordValue?, forKey: "momentMonth")
        record.setObject(self.momentWeek as CKRecordValue?, forKey: "momentWeek")
        record.setObject(self.momentYear as CKRecordValue?, forKey: "momentYear")
        record.setObject(self.createdAt as CKRecordValue?, forKey: "createdAt")
        record.setObject(self.momentId as CKRecordValue?, forKey: "momentID")
        record.setObject(self.modifiedAt as CKRecordValue?, forKey: "modifiedAt")
        record.setObject(self.day as CKRecordValue?, forKey: "day")
        record.setObject(self.month as CKRecordValue?, forKey: "month")
        record.setObject(self.year as CKRecordValue?, forKey: "year")
        record.setObject(self.color as CKRecordValue?, forKey: "color")
        record.setObject(self.searchToken as CKRecordValue?, forKey: "searchToken")
        
    }
    
//    func fromICloudRecordToMoment(record: CKRecord) -> (Moment) {
//        print(record)
//
//        self.name = record.object(forKey: "name") as? String? ?? " "
//        self.desc = record.object(forKey: "desc") as? String? ?? " "
//        self.momentTime = record.object(forKey: "momentTime") as? NSNumber? as? Int64 ?? 0
//        self.momentDate = record.object(forKey: "momentDate") as? Date ?? momentTime.toDate.startOfDay
//        self.momentMonth = record.object(forKey: "momentMonth") as? Date ?? momentTime.toDate.prevMonth.nextMonth(at: .start)
//        self.momentWeek = record.object(forKey: "momentWeek") as? Date ?? momentTime.toDate.startWeek
//        self.momentYear = record.object(forKey: "momentYear") as? Int16 ?? momentTime.toDate.year.int16Value
//        self.createdAt = record.object(forKey: "createdAt") as? NSNumber? as? Int64 ?? 0
//        self.modifiedAt = record.object(forKey: "modifiedAt") as? NSNumber? as? Int64 ?? 0
//        self.day = record.object(forKey: "day") as? NSNumber? as? Int16 ?? 0
//        self.month = record.object(forKey: "month") as? NSNumber? as? Int16 ?? 0
//        self.year = record.object(forKey: "year") as? NSNumber? as? Int16 ?? momentTime.toDate.year.int16Value
//        self.momentId = record.object(forKey: "momentID") as? String ?? ""
//        self.color = record.object(forKey: "color") as? String? ?? " "
//        self.searchToken = record.object(forKey: "searchToken") as? String? ?? " "
//
//        return self
//    }
//
    func delteICloudMoment(recordId: CKRecordID) {
        CloudSyncServices.deleteICloudMoment(recordId: recordId)
    }
}

class Record {
    
    let name: String
    let desc: String
    let time: Int64!
    let recordDate: Date
    let recordMonth: Date
    let recordWeek: Date
    let recordYear: Int16
    let createdAt: Int64
    let modifiedAt: Int64
    
    let day: Int16
    let month: Int16
    let year: Int16
    
    let id: String
    
    let color: String
    let searchToken: String
    
    var momentDate = Date()
    
    init(record: CKRecord) {
        self.name = record.object(forKey: "name") as? String ?? ""
        self.desc = record.object(forKey: "desc") as? String ?? " "
        
        self.time = record.object(forKey: "momentTime") as? NSNumber? as? Int64 ?? 0
        
        let tempTime = record.object(forKey: "momentTime") as? NSNumber? as? Int64 ?? 0
        
        self.recordDate = record.object(forKey: "momentDate") as? Date ?? tempTime.toDate.startOfDay
        self.recordMonth = record.object(forKey: "momentMonth") as? Date ?? tempTime.toDate.prevMonth.nextMonth
        self.recordWeek = record.object(forKey: "momentWeek") as? Date ?? tempTime.toDate.startWeek
        self.recordYear = record.object(forKey: "momentYear") as? Int16 ?? tempTime.toDate.year.int16Value
        
        self.createdAt = record.object(forKey: "createdAt") as? NSNumber? as? Int64 ?? 0
        self.modifiedAt = record.object(forKey: "modifiedAt") as? NSNumber? as? Int64 ?? 0
        
        self.day = record.object(forKey: "day") as? NSNumber? as? Int16 ?? 0
        self.month = record.object(forKey: "month") as? NSNumber? as? Int16 ?? 0
        self.year = record.object(forKey: "year") as? NSNumber? as? Int16 ?? 0
        
        self.id = record.object(forKey: "momentID") as? String ?? ""
        self.color = record.object(forKey: "color") as? String ?? "039BE5"
        self.searchToken = record.object(forKey: "searchToken") as? String ?? " "
    }
    
}


