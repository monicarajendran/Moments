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
    
    typealias completionHandler  = (_ momentRec : [CKRecord]) -> Void
    
    typealias batchHandler  = (_ momentRec : [CKRecord] , _ error : Error?) -> Void
    
    // do (batch { save to core data }, comption : { move to next view })
    // func do cursor = nil, batchHandler, competionHandler
    /*
     
     let queryOps
     let records = []
     
     if curosr  {
        query = query(cursor)
     }else {
     query = Moment query
     
     }
     
     query set limit
     
     query fetch block {
     
      record add to records
     }
     
     query completion block {
     
        call batch handler ()
     
        reset records
     
        if cursor = nil {
            call completion
     }else {
        call same method
     }
     
     // run in icloud
     }
     
     */

    static func fetchAllMomentsWithCursor(cursor : CKQueryCursor? = nil , batch :@escaping batchHandler, completion: @escaping completionHandler){
        
        var queryOperation : CKQueryOperation
        var momentRecord : [CKRecord] = []
        
        if let cursor = cursor {
            
            queryOperation = CKQueryOperation(cursor: cursor)
        }
        else {
            
            let query = CKQuery(recordType: "Moment", predicate: NSPredicate(value: true))
            
             queryOperation = CKQueryOperation(query: query)
        }
        
        queryOperation.resultsLimit = 10
        
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
            }
            else {
                self.fetchAllMomentsWithCursor(cursor: cursor, batch: batch, completion: completion)
            }
         }
            else{
                
                if err?.localizedDescription == "This request requires an authenticated account"{
                batch(momentRecord,err)
                }
                print("error in fetching icloud moments")
            }
        }
        customContainer.privateCloudDatabase.add(queryOperation)
   }
}
