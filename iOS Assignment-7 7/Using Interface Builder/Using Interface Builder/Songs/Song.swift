//
//  Song.swift
//
//
//  Created by Jerry Reddy on 2/22/24.



import Foundation

class Song {
    var dictionary: [String: Any]

    var song_id: Int {
        get { return dictionary["song_id"] as? Int ?? 0 }
        set { dictionary["song_id"] = newValue }
    }

    var artist_id: Int {
        get { return dictionary["artist_id"] as? Int ?? 0 }
        set { dictionary["artist_id"] = newValue }
    }

    var album_id: Int {
        get { return dictionary["album_id"] as? Int ?? 0 }
        set { dictionary["album_id"] = newValue }
    }

    var genre_id: Int {
        get { return dictionary["genre_id"] as? Int ?? 0 }
        set { dictionary["genre_id"] = newValue }
    }
    
    var title: String {
        get { return dictionary["title"] as? String ?? "" }
        set { dictionary["title"] = newValue }
    }
    
    var duration: Double {
        get { return dictionary["duration"] as? Double ?? 0 }
        set { dictionary["duration"] = newValue }
    }

    var favourite: Bool {
        get { return dictionary["favourite"] as? Bool ?? false }
        set { dictionary["favourite"] = newValue } // Set the property using the provided value
    }
    
    init(song_id: Int, artist_id: Int, album_id: Int, genre_id: Int, title: String, duration: Double, favourite: Bool) {
        self.dictionary = [
            "song_id": song_id,
            "artist_id": artist_id,
            "album_id": album_id,
            "genre_id": genre_id,
            "title": title,
            "duration": duration,
            "favourite": favourite // Initialize the favourite property with the provided value
        ]
    }
}

