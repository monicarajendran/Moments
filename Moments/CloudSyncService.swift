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
                print("error occured")
                return
            }
            
            print("successful",record)
        
        })
        
    }
    
}
