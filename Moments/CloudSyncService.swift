//
//  CloudSyncService.swift
//  Moments
//
//  Created by user on 05/08/1939 Saka.
//  Copyright © 1939 Saka user. All rights reserved.
//

import Foundation
import CloudKit

class CloudSyncServices {
    
   static let privateDb = customContainer.privateCloudDatabase
    
   static let customContainer = CKContainer(identifier: "iCloud.com.full.moments")

   static func addRecordToIColud(record: CKRecord){
    
        privateDb.save(record, completionHandler: { (record,error) -> Void in
            
            guard let record = record else{
            
                print("error occured",error as Any)
                return
            }
            
            print("successful",record)
        
        })
    }
    
    // func to fetch record by id 
    
    static func fetchRecordFromICloud(record: CKRecord){ //-> CKRecord{
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "Moment", predicate: predicate)
        
        let queryOperation = CKQueryOperation(query: query)
        
        var momentRecord : [CKRecord] = []
        
        queryOperation.recordFetchedBlock = { record in
            
            momentRecord.append(record)
            
        }
        
        queryOperation.queryCompletionBlock = { cursor , error in
            
            print(momentRecord)
            
        }
        
        customContainer.privateCloudDatabase.add(queryOperation)
        
        print(momentRecord.count)
        
        //return record

    }
    
}
