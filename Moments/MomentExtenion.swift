//
//  MomentExtenion.swift
//  Moments
//
//  Created by user on 06/08/1939 Saka.
//  Copyright © 1939 Saka user. All rights reserved.
//

import Foundation
import CloudKit

extension Moment {
    
    func toICloudRecord() -> CKRecord {
        
        record["name"] = self.name as CKRecordValue?
        record["desc"] = self.desc as CKRecordValue?
        record["momentTime"] = self.momentTime as CKRecordValue?
        record["createdAt"] = self.createdAt as CKRecordValue?
        record["modifiedAt"] = self.modifiedAt as CKRecordValue?
        record["day"] = self.day as CKRecordValue?
        record["month"] = self.month as CKRecordValue?
        record["year"] = self.year as CKRecordValue?
        
        return record
    }
    
    func fromICloudRecord() -> Moment{

        self.name = record.object(forKey: "name") as! String?
        self.desc = record.object(forKey: "desc") as! String?
        self.momentTime = record.object(forKey: "momentTime") as? Int64 ?? 00
        self.createdAt = record.object(forKey: "createdAt") as! Int64? ?? 00
        self.modifiedAt = (record.object(forKey: "modifiedAt") as! Int64?) ?? 00
        self.day = (record.object(forKey: "day") as! Int16?) ?? 00
        self.month = (record.object(forKey: "month") as! Int16?) ?? 00
        self.year = (record.object(forKey: "year") as! Int16?) ?? 00
        
        return self
    }
}

