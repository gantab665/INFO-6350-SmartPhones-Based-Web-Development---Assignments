//
//  exec.swift
//
//
//  Created by Jerry Reddy on 2/22/24.




import Foundation

// Create a AlbumManager instance
let albumManager = AlbumManager()

class AlbumManager {
        
    var artists: [Artist] = []
    var albums: [Album] = []
    var genres: [Genre] = []
    var songs: [Song] = []
    
    
    // Add a artist
    func addArtist(artist: Artist) {
        artists.append(artist)
    }
    // View all artists
    func viewAllArtists() -> [Artist] {
        return artists
    }

    // Update an artist
    func updateArtist(artist: Artist) {
        // Find the songs in the songs array
        if let index = artists.firstIndex(where: { $0.id == artist.id }) {
            // Update the product post
            artists[index] = artist
            print("Artist updated successfully!")
        } else {
            print("Unable to update artist. Invalid ID.")
        }
    }

    // Delete an artist
       func deleteArtist(artist: Artist) {
           // Remove the artist from the artists array
           if let index = artists.firstIndex(where: { $0.id == artist.id }) {
               artists.remove(at: index)
               print("Artist deleted successfully!")
           } else {
               print("Unable to delete artist. Invalid ID.")
           }
       }
    
    
    
    // Add a album
    func addAlbum(album: Album) {
        albums.append(album)
    }
    // View all albums
    func viewAllAlbums() -> [Album] {
        return albums
    }

    // Update an album
    func updateAlbum(album: Album) {
        // Find the album in the songs array
        if let index = albums.firstIndex(where: { $0.album_id == album.album_id }) {
            // Update the product post
            albums[index] = album
            print("Album updated successfully!")
        } else {
            print("Unable to update Album. Invalid ID.")
        }
    }

    // Delete an album
       func deleteAlbum(album: Album) {
           // Remove the songs from the songs array
           if let index = albums.firstIndex(where: { $0.album_id == album.album_id }) {
               albums.remove(at: index)
               print("Album deleted successfully!")
           } else {
               print("Unable to delete album. Invalid ID.")
           }
       }
    
    // Add a genre
    func addGenre(genre: Genre) {
        genres.append(genre)
    }
    // View all albums
    func viewAllGenres() -> [Genre] {
        return genres
    }

    // Update a genre
    func updateGenre(genre: Genre) {
        // Find the genre in the genres array
        if let index = genres.firstIndex(where: { $0.genre_id == genre.genre_id }) {
            // Update the genre
            genres[index] = genre
            print("Genre updated successfully!")
        } else {
            print("Unable to update Genre. Invalid ID.")
        }
    }

    // Delete a genre
       func deleteGenre(genre: Genre) {
           // Remove the genre from the genres array
           if let index = genres.firstIndex(where: { $0.genre_id == genre.genre_id }) {
               genres.remove(at: index)
               print("Genre deleted successfully!")
           } else {
               print("Unable to delete genre. Invalid ID.")
           }
       }
    
    
    // Add a song
    func addSong(song: Song) {
        songs.append(song)
    }
    // View all albums
    func viewAllSongs() -> [Song] {
        return songs
    }

    // Update a genre
    func updateSong(song: Song) {
        // Find the song in the songs array
        if let index = songs.firstIndex(where: { $0.song_id == song.song_id }) {
            // Update the product post
            songs[index] = song
            print("Song updated successfully!")
        } else {
            print("Unable to update Song. Invalid ID.")
        }
    }

    // Delete a genre
       func deleteSong(song: Song) {
           // Remove the song from the songs array
           if let index = songs.firstIndex(where: { $0.song_id == song.song_id }) {
               songs.remove(at: index)
               print("Song deleted successfully!")
           } else {
               print("Unable to delete song. Invalid ID.")
           }
       }
    

}

func search() {
    
    print("Enter your search query:")
    guard let query = readLine() else {
        print("Invalid search query.")
        return
    }
    
    var searchResults: [String] = []
    
    // Search for albums
    let matchingAlbums = albumManager.albums.filter { $0.title.lowercased().contains(query.lowercased()) }
    if !matchingAlbums.isEmpty {
        let albumNames = matchingAlbums.map { $0.title }
        searchResults.append("Albums: \(albumNames.joined(separator: ", "))")
    }
    
    // Search for genre
    let matchingGenres = albumManager.genres.filter { $0.name.lowercased().contains(query.lowercased()) }
        if !matchingGenres.isEmpty {
            let genreNames = matchingGenres.map { $0.name }
            searchResults.append("Genres: \(genreNames.joined(separator: ", "))")
        }

    
    // Search for songs
    let matchingSongs = albumManager.songs.filter { $0.title.lowercased().contains(query.lowercased()) }
    if !matchingSongs.isEmpty {
        let songNames = matchingSongs.map { $0.title }
        searchResults.append("Songs: \(songNames.joined(separator: ", "))")
    }
    
    // Search for artists
    let matchingArtists = albumManager.albums.filter { $0.title.lowercased().contains(query.lowercased()) }
    if !matchingArtists.isEmpty {
        let artistNames = matchingArtists.map { $0.title }
        searchResults.append("Artists: \(artistNames.joined(separator: ", "))")
    }
    

    if searchResults.isEmpty {
        print("No results found.")
    } else {
        print("Search results:")
        for result in searchResults {
            print("- \(result)")
        }
    }
}

