//
//  ManageSongsViewController.swift
//   Interface Builder
//  Created by Jerry Reddy on 29/02/24.
//

import UIKit

class ManageSongsViewController: UIViewController {

    @IBOutlet weak var SongIdField: UITextField!
    @IBOutlet weak var SongNameField: UITextField!
    @IBOutlet weak var SongArtistIdField: UITextField!
    @IBOutlet weak var SongAlbumIdField: UITextField!
    @IBOutlet weak var SongGenreIdField: UITextField!
    @IBOutlet weak var SongDurationField: UITextField!
    @IBOutlet weak var SongFavouriteField: UITextField!
   
    @IBOutlet weak var textView: UITextView!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func addSongButtonTapped(_ sender: UIButton) {
        let vc = ManageSongsViewController(nibName: "AddSongView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func deleteSongButtonTapped(_ sender: UIButton) {
        let vc = ManageSongsViewController(nibName: "DeleteSongView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func updateSongButtonTapped(_ sender: UIButton) {
        let vc = ManageSongsViewController(nibName: "UpdateSongView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func viewAllSongsButtonTapped(_ sender: UIButton) {
        let vc = ManageSongsViewController(nibName: "ViewAllSongsView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
        if let textView = vc.textView {
            viewAllSongs(textView: textView)
                   }
    }


    @IBAction func goBackButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func addSong(_ sender: UIButton) {
        print("Add Song button pressed")
                if let songIdText = SongIdField?.text, let songId = Int(songIdText) ,
                   let songNameText = SongNameField?.text, !songNameText.isEmpty,
                   let artistIdText = SongArtistIdField?.text, let artistId = Int(artistIdText) ,
                   let albumIdText = SongAlbumIdField?.text, let albumId = Int(albumIdText) ,
                   let durationText = SongDurationField?.text, let songDurationId = Double(durationText) ,
                   let genreidText = SongGenreIdField?.text, let genreId = Int(genreidText) ,
                   let songFavText = SongFavouriteField?.text?.lowercased(){
                    let songFavBool: Bool
                    switch songFavText {
                    case "true", "yes", "1":
                        songFavBool = true
                    case "false", "no", "0":
                        songFavBool = false
                    default:
                        let alert = UIAlertController(title: "Error", message: "Invalid value for Favorite. Please use 'yes', 'no', '0', '1', 'true', or 'false'.", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                present(alert, animated: true, completion: nil)
                        songFavBool = false
                        return}
            // Check if the songs already exists
                    let songIDExists = albumManager.songs.contains { $0.song_id == songId }
            if songIDExists {
                let alert = UIAlertController(title: "Error", message: "Song with ID \(songId) already exists.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }

            // Check if the artist ID is valid
            if !albumManager.artists.contains(where: { $0.id == artistId }) {
                let alert = UIAlertController(title: "Error", message: "Artist ID \(artistId) is invalid.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            
                    // Check if the album ID is valid
                    if !albumManager.albums.contains(where: { $0.album_id == albumId }) {
                        let alert = UIAlertController(title: "Error", message: "Album ID \(albumId) is invalid.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        present(alert, animated: true, completion: nil)
                        return
                    }
                    
                    //check if genre id is valid
                    if !albumManager.genres.contains(where: { $0.genre_id == genreId }) {
                        let alert = UIAlertController(title: "Error", message: "Genre ID \(genreId) is invalid.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        present(alert, animated: true, completion: nil)
                        return
                    }
            // Create a new song and add it to the songs array
            let newSong = Song(song_id: songId, artist_id: artistId, album_id: albumId, genre_id: genreId, title: songNameText, duration: songDurationId, favourite: songFavBool)
            albumManager.addSong(song: newSong)
            
            let alert = UIAlertController(title: "Song Added Successfully", message: "Press OK to continue", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
        } else {
            // Handle case where any required field is empty or not a valid integer
            let alert = UIAlertController(title: "Error", message: "One or more fields are empty or contain invalid values.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func deleteSong(_ sender: UIButton) {
        if let songIdText = SongIdField?.text, let songDeleteId = Int(songIdText){
            let songIDExists = albumManager.songs.contains { $0.song_id == songDeleteId }
            if songIDExists {
                // Delete the songs from the songs array
                if let songToDelete = albumManager.songs.first(where: { $0.song_id == songDeleteId }) {
                    albumManager.deleteSong(song: songToDelete)
                    print("Song deleted successfully!")
                    // Handle case where product post id is deleted
                    let alert = UIAlertController(title: "Success", message: "Song deleted successfully", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
            } else {
                // Handle case where songid is not valid
                let alert = UIAlertController(title: "Error", message: "Song ID does not exist to delete.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Please enter an ID", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func updateSong(_ sender: UIButton) {
        print("Update Song button pressed")
        //        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let songIdText = SongIdField?.text, let songId = Int(songIdText) ,
           let songNameText = SongNameField?.text, !songNameText.isEmpty,
           let artistIdText = SongArtistIdField?.text, let artistId = Int(artistIdText) ,
           let albumIdText = SongAlbumIdField?.text, let albumId = Int(albumIdText) ,
           let durationText = SongDurationField?.text, let songDurationId = Double(durationText) ,
           let genreidText = SongGenreIdField?.text, let genreId = Int(genreidText) ,
           let songFavText = SongFavouriteField?.text?.lowercased(){
            let songFavBool: Bool
            switch songFavText {
            case "true", "yes", "1":
                songFavBool = true
            case "false", "no", "0":
                songFavBool = false
            default:
                songFavBool = false
                return}
            // Check if the song id already exists
            if let songIDExists = albumManager.songs.first(where: { $0.song_id == songId })
            {
                // Check if the song ID is valid
                if !albumManager.songs.contains(where: { $0.song_id == songId }) {
                    let alert = UIAlertController(title: "Error", message: "Song ID \(songId) is invalid.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
              
              //
                // Check if the artist ID matches the existing record, to not allow artist ID updates
                            if songIDExists.artist_id != artistId {
                                let alert = UIAlertController(title: "Error", message: "Cannot change the artist ID for an existing album. Artist ID must match the current artist ID associated with the song.", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                present(alert, animated: true, completion: nil)
                                return
                            }
                
                // Check if the album ID matches the existing record, to not allow artist ID updates
                if songIDExists.album_id != albumId {
                                let alert = UIAlertController(title: "Error", message: "Cannot change the album ID for an existing album. Album ID must match the current album ID associated with the song.", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                                return
                            }
                // Check if the genre ID matches the existing record, to not allow artist ID updates
                            if songIDExists.artist_id != genreId {
                                let alert = UIAlertController(title: "Error", message: "Cannot change the genre ID for an existing album. Genre ID must match the current genre ID associated with the song.", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                present(alert, animated: true, completion: nil)
                                return
                            }
                // Check if the artist ID is valid
                if !albumManager.artists.contains(where: { $0.id == artistId }) {
                    let alert = UIAlertController(title: "Error", message: "Artist ID \(artistId) is invalid.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
               
                // Check if the album ID is valid
                if !albumManager.albums.contains(where: { $0.album_id == albumId }) {
                    let alert = UIAlertController(title: "Error", message: "Album ID \(albumId) is invalid.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
                
                // Check if the genre ID is valid
                if !albumManager.genres.contains(where: { $0.genre_id == genreId }) {
                    let alert = UIAlertController(title: "Error", message: "Genre ID \(genreId) is invalid.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
               
                // updated a new song and add it to the songs array
                let newSong = Song(song_id: songId, artist_id: artistId, album_id: albumId, genre_id: genreId, title: songNameText, duration: songDurationId, favourite: songFavBool)
                albumManager.updateSong(song: newSong)
                
                let alert = UIAlertController(title: "Song updated Successfully", message: "Press OK to continue", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            else{
                // Handle case where song id is not valid
                let alert = UIAlertController(title: "Error", message: "Song ID does not exist to update.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        } else {
            // Handle case where any required field is empty or not a valid integer
            let alert = UIAlertController(title: "Error", message: "One or more fields are empty or contain invalid values.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func viewAllSongs(_ sender: UIButton) {
        print("view all songs pressed")
        let songs = albumManager.viewAllSongs()
        
        // Create a new view to display the songs
        let allSongsView = UIView(frame: UIScreen.main.bounds)
        allSongsView.backgroundColor = .systemTeal
        
        if songs.isEmpty {
            // Add a placeholder label if there are no artists
            let label = UILabel(frame: CGRect(x: 100, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width - 40, height: 30))
            label.text = "No songs available"
            label.textColor = .black
            allSongsView.addSubview(label)
        } else {
            // Add a label for each product post
            var yOffset: CGFloat = 50.0 // starting y offset
            for song in songs {
                let idLabel = UILabel(frame: CGRect(x: 20, y: yOffset, width: UIScreen.main.bounds.width - 40, height: 30))
                idLabel.text = "Song ID: \(song.song_id)"
                idLabel.textColor = .black
                allSongsView.addSubview(idLabel)
                
                let songNameLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 30.0, width: UIScreen.main.bounds.width - 40, height: 30))
                songNameLabel.text = "Song Name: \(song.title)"
                songNameLabel.textColor = .black
                allSongsView.addSubview(songNameLabel)
                
                let songFavLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 60.0, width: UIScreen.main.bounds.width - 40, height: 30))
                songFavLabel.text = "Favourite Song: \(song.favourite)"
                songFavLabel.textColor = .black
                allSongsView.addSubview(songFavLabel)
                
                let artistIdLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 90.0, width: UIScreen.main.bounds.width - 40, height: 30))
                artistIdLabel.text = "Song Artist ID: \(song.artist_id)"
                artistIdLabel.textColor = .black
                allSongsView.addSubview(artistIdLabel)
                
                let albumIdLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 120.0, width: UIScreen.main.bounds.width - 40, height: 30))
                albumIdLabel.text = "Song ID: \(song.album_id)"
                albumIdLabel.textColor = .black
                allSongsView.addSubview(albumIdLabel)
                
                let genreIdLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 160.0, width: UIScreen.main.bounds.width - 40, height: 30))
                genreIdLabel.text = "Song ID: \(song.genre_id)"
                genreIdLabel.textColor = .black
                allSongsView.addSubview(genreIdLabel)
                
                // Create a background color with rounded edges for each label
                let backgroundColor = UIColor(red: CGFloat.random(in: 0.5...1.0), green: CGFloat.random(in: 0.5...1.0), blue: CGFloat.random(in: 0.5...1.0), alpha: 1.0)
                let labelBackgroundView = UIView(frame: CGRect(x: 0, y: yOffset, width: UIScreen.main.bounds.width, height: 210))
                labelBackgroundView.backgroundColor = backgroundColor
                labelBackgroundView.layer.cornerRadius = 10
                allSongsView.insertSubview(labelBackgroundView, belowSubview: idLabel)
                
                yOffset += 230.0 // increment y offset for next label
            }
        }
       
    }
   
    func viewAllSongs(textView: UITextView) {
        let songs = albumManager.viewAllSongs()
        var songsString = ""
        for song in songs {
            songsString += "Song ID: \(song.song_id)\n"
            songsString += "Artist ID: \(song.artist_id)\n"
            songsString += "Genre ID: \(song.genre_id)\n"
            songsString += "Album ID: \(song.album_id)\n"
            songsString += "Title: \(song.title)\n"
            songsString += "Duration: \(song.duration)\n"
            songsString += "Favourite: \(song.favourite)\n\n"
        }
        textView.text = songsString
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
