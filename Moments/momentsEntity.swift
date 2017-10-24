//
//  momentsEntity.swift
//  Moments
//
//  Created by user on 17/07/1939 Saka.
//  Copyright © 1939 Saka user. All rights reserved.
//

import Foundation
import CoreData
import AlecrimCoreData

extension NSManagedObjectContext{
    
    var moment: Table<Moments> {
        return Table<Moments>(context : self)
    }
    
}
