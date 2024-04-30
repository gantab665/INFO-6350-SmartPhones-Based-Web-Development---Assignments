//
//  Album.swift
//  EmptyApp
//
//  Created by Jerry Reddy on 2/22/24.
//  Copyright © 2024 rab. All rights reserved.
//

import Foundation

class Album {
    var dictionary: [String: Any]
    
    var album_id: Int {
        get { return dictionary["album_id"] as? Int ?? 0 }
        set { dictionary["album_id"] = newValue }
    }
    
    
    var artist_id: Int {
        get { return dictionary["artist_id"] as? Int ?? 0 }
        set { dictionary["artist_id"] = newValue }
    }
    var title: String {
        get { return dictionary["title"] as? String ?? "" }
        set { dictionary["title"] = newValue }
    }
   
    
    var release_date: Date {
        get { return dictionary["release_date"] as? Date ?? Date() }
        set { dictionary["release_date"] = newValue }
    }
    
    init(album_id: Int,artist_id:Int, title: String,release_date:Date) {
        self.dictionary = [
            "album_id": album_id,
            "artist_id": artist_id,
            "title": title,
            "release_date": release_date,
        ]
    }
}
