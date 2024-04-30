//
//  ArtistData+CoreProperties.swift
//  Using Interface Builder
//
//  Created by Jerry Reddy on 14/03/24.
//

import Foundation
import CoreData


extension ArtistData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArtistData> {
        return NSFetchRequest<ArtistData>(entityName: "ArtistData")
    }

    
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
  

}

extension ArtistData : Identifiable {

}
