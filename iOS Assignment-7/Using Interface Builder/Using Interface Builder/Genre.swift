//
//  Genre.swift
//
//
//  Created by Jerry Reddy on 2/22/24.




class Genre {
    var dictionary: [String: Any]
    
    var genre_id: Int {
        get { return dictionary["genre_id"] as? Int ?? 0 }
        set { dictionary["genre_id"] = newValue }
    }
    
    var name: String {
        get { return dictionary["name"] as? String ?? "" }
        set { dictionary["name"] = newValue }
    }
    
    init(genre_id: Int, name: String ) {
        self.dictionary = [
            "genre_id": genre_id,
            "name": name,
        ]
    }
}
