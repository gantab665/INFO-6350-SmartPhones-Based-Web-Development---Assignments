//
//  Artist.swift
//  
//
//  Created by Jerry Reddy on 2/22/24.



class Artist {
    var dictionary: [String: Any]
    
    var id: Int {
        get { return dictionary["id"] as? Int ?? 0 }
        set { dictionary["id"] = newValue }
    }
    
    var name: String {
        get { return dictionary["name"] as? String ?? "" }
        set { dictionary["name"] = newValue }
    }
    

    
    init(id: Int, name: String) {
        self.dictionary = [
            "id": id,
            "name": name,
        ]
    }
}
