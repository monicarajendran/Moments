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
    
    typealias completionHandler  = (_ momentRec: [CKRecord]) -> Void
    typealias batchHandler  = (_ momentRec: [CKRecord] , _ error: Error?) -> Void
    
    static let privateDb = customContainer.privateCloudDatabase
    static let customContainer = CKContainer(identifier: "iCloud.com.fullCreative.Moments")
    
    static func addRecordToIColud(record: CKRecord){
        
        privateDb.save(record, completionHandler: { (record,error) -> Void in
            guard let record = record else{
                print("error occured",error as Any)
                return
            }
            print("successful",record)
        })
    }
 
    static func fetchAllMomentsWithCursor(cursor: CKQueryCursor? = nil , batch: @escaping batchHandler, completion: @escaping completionHandler) {
        
        var queryOperation : CKQueryOperation
        var momentRecord : [CKRecord] = []
        
        if let cursor = cursor {
            queryOperation = CKQueryOperation(cursor: cursor)
        } else {
            let query = CKQuery(recordType: "Moment", predicate: NSPredicate(value: true))
            queryOperation = CKQueryOperation(query: query)
        }
        queryOperation.resultsLimit = 15
        
        queryOperation.recordFetchedBlock = { record in
            momentRecord.append(record)
        }
        
        queryOperation.queryCompletionBlock = { cursor , err in
            
            if err == nil {
                batch(momentRecord, err)
                momentRecord = []
                
                if cursor == nil {
                    completion([])
                    print("fetching all moments is done")
                } else {
                    self.fetchAllMomentsWithCursor(cursor: cursor, batch: batch, completion: completion)
                }
            } else{
                if err?.localizedDescription == "This request requires an authenticated account"{
                    batch(momentRecord, err)
                }
                print("error in fetching icloud moments")
            }
        }
        customContainer.privateCloudDatabase.add(queryOperation)
    }
    
    static func deleteICloudMoment(recordId: CKRecordID) {
        privateDb.delete(withRecordID: recordId) { (recordId, err) in
            if err == nil {
                print("Deleted record Id :", recordId )
            } else {
                print("Error in deleting record:", err)
            }
        }
    }
}
