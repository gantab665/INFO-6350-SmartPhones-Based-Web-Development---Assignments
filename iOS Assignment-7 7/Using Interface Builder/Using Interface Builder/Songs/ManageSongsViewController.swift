//
//  ManageSongsViewController.swift
//   Interface Builder
//  Created by Jerry Reddy on 29/02/24.
//

import UIKit
import CoreData

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
        print("Add Product Post button pressed")
        guard let songIdText = SongIdField?.text, let songId = Int(songIdText),
              let songNameText = SongNameField?.text, !songNameText.isEmpty,
              let artistIdText = SongArtistIdField?.text, let artistId = Int(artistIdText),
              let albumIdText = SongAlbumIdField?.text, let albumId = Int(albumIdText),
              let durationText = SongDurationField?.text, let songDurationId = Double(durationText),
              let genreidText = SongGenreIdField?.text, let genreId = Int(genreidText),
              let songFavText = SongFavouriteField?.text?.lowercased()
        else {
            let alert = UIAlertController(title: "Error", message: "Please fill all fields and ensure product rating is less than 5 or = 5", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

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
            return
        }

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // Check if artist exists
        let artistFetchRequest: NSFetchRequest<ArtistData> = ArtistData.fetchRequest()
        artistFetchRequest.predicate = NSPredicate(format: "id == %@", String(artistId))
        do {
            let artists = try context.fetch(artistFetchRequest)
            if artists.count == 0 {
                let alert = UIAlertController(title: "Error", message: "Artist ID does not exist", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
        } catch let error {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        // Check if album exists
        let albumFetchRequest: NSFetchRequest<AlbumData> = AlbumData.fetchRequest()
        albumFetchRequest.predicate = NSPredicate(format: "id == %ld", albumId)
        do {
            let albums = try context.fetch(albumFetchRequest)
            if albums.count == 0 {
                let alert = UIAlertController(title: "Error", message: "Album ID does not exist", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
        } catch {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        // Check if genre exists
        let genreFetchRequest: NSFetchRequest<GenreData> = GenreData.fetchRequest()
        genreFetchRequest.predicate = NSPredicate(format: "id == %ld", genreId)
        do {
            let genres = try context.fetch(genreFetchRequest)
            if genres.count == 0 {
                let alert = UIAlertController(title: "Error", message: "Genre ID does not exist", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
        } catch {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        // Check if song already exists
        let songFetchRequest: NSFetchRequest<SongData> = SongData.fetchRequest()
        songFetchRequest.predicate = NSPredicate(format: "id == %ld", songId)
        do {
            let songs = try context.fetch(songFetchRequest)
            if songs.count > 0 {
                let alert = UIAlertController(title: "Error", message: "Song with the following already exists:\nID: \(songId)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
        } catch {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        // Create new Song object
        let newSong = SongData(context: context)
        newSong.id = Int64(songId)
        newSong.album_id = Int64(albumId)
        newSong.artist_id = Int64(artistId)
        newSong.genre_id = Int64(genreId)
        newSong.name = songNameText
        newSong.favourite = songFavBool
        newSong.duration = Double(songDurationId)

        // Save changes
        do {
            try context.save()
            let alert = UIAlertController(title: "Success", message: "Song added successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            }))
            present(alert, animated: true, completion: nil)
        } catch {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }

    }
    @IBAction func deleteSong(_ sender: UIButton) {
        print("Delete Song button pressed")

        guard let songIdText = SongIdField?.text,
              let songDeleteId = Int(songIdText)
        else {
            let alert = UIAlertController(title: "Error", message: "Please enter a valid Song ID", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // Now delete the song id
        let fetchRequest: NSFetchRequest<SongData> = SongData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", songDeleteId)
        do {
            let results = try context.fetch(fetchRequest)
            if let songToDelete = results.first {
                context.delete(songToDelete)
                try context.save()
                
                // Deletion was successful
                let alert = UIAlertController(title: "Song Deleted Successfully", message: "Press OK to continue", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            } else {
                // Deletion failed
                let alert = UIAlertController(title: "Error", message: "Song ID does not exist to delete.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        } catch {
            // Handle error
            print("Error deleting song: \(error)")
            let alert = UIAlertController(title: "Error", message: "Unable to delete song.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }

    }
    @IBAction func updateSong(_ sender: UIButton) {
        print("Update Song button pressed")

        guard let songIdText = SongIdField?.text,
              let songId = Int(songIdText),
              let songNameText = SongNameField?.text,
              !songNameText.isEmpty,
              let artistIdText = SongArtistIdField?.text,
              let artistId = Int(artistIdText),
              let albumIdText = SongAlbumIdField?.text,
              let albumId = Int(albumIdText),
              let durationText = SongDurationField?.text,
              let songDurationId = Double(durationText),
              let genreidText = SongGenreIdField?.text,
              let genreId = Int(genreidText),
              let songFavText = SongFavouriteField?.text?.lowercased()
        else {
            let alert = UIAlertController(title: "Error", message: "Please fill all fields and ensure product rating is less than 5 or equal to 5", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        var songFavBool: Bool
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
            return
        }

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // Check if artist exists
        let artistFetchRequest: NSFetchRequest<ArtistData> = ArtistData.fetchRequest()
        artistFetchRequest.predicate = NSPredicate(format: "id == %@", String(artistId))
        do {
            let artists = try context.fetch(artistFetchRequest)
            if artists.isEmpty {
                let alert = UIAlertController(title: "Error", message: "Artist ID does not exist", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
        } catch let error {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        // Check if album exists
        let albumFetchRequest: NSFetchRequest<AlbumData> = AlbumData.fetchRequest()
        albumFetchRequest.predicate = NSPredicate(format: "id == %ld", albumId)
        do {
            let albums = try context.fetch(albumFetchRequest)
            if albums.isEmpty {
                let alert = UIAlertController(title: "Error", message: "Album ID does not exist", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
        } catch {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        // Check if Genre exists
        let genreRequest: NSFetchRequest<GenreData> = GenreData.fetchRequest()
        genreRequest.predicate = NSPredicate(format: "id == %ld", genreId)
        do {
            let genres = try context.fetch(genreRequest)
            if genres.isEmpty {
                let alert = UIAlertController(title: "Error", message: "Genre ID does not exist", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
        } catch {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        // Update the song
        let fetchRequestToUpdate: NSFetchRequest<SongData> = SongData.fetchRequest()
        fetchRequestToUpdate.predicate = NSPredicate(format: "id == %ld", songId)
        do {
            let result = try context.fetch(fetchRequestToUpdate)
            
            if let songToUpdate = result.first {
                songToUpdate.id = Int64(songId)
                
                // Check if the artist ID is different from the existing one
                if songToUpdate.artist_id != Int64(artistId) {
                    let alert = UIAlertController(title: "Error", message: "You are not allowed to update the Artist ID", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
                
                // Check if the album ID is different from the existing one
                if songToUpdate.album_id != Int64(albumId) {
                    let alert = UIAlertController(title: "Error", message: "You are not allowed to update the Album ID", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
                
                // Check if the genre ID is different from the existing one
                if songToUpdate.genre_id != Int64(genreId) {
                    let alert = UIAlertController(title: "Error", message: "You are not allowed to update the Genre ID", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
                
                songToUpdate.album_id = Int64(albumId)
                songToUpdate.artist_id = Int64(artistId)
                songToUpdate.genre_id = Int64(genreId)
                songToUpdate.name = songNameText
                songToUpdate.duration = Double(songDurationId)
                songToUpdate.favourite = songFavBool
                
                try context.save()
                
                let alert = UIAlertController(title: "Song Updated Successfully", message: "Press OK to continue", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "Song ID does not exist to update.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        } catch {
            let alert = UIAlertController(title: "Error", message: "Failed to update song", preferredStyle: .alert)
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
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

            do {
                // Fetch all songs from Core Data
                let fetchRequest: NSFetchRequest<SongData> = SongData.fetchRequest()
                let songs = try context.fetch(fetchRequest)

                // Construct a string with details of all songs
                var songString = ""
                for song in songs {
                    songString += "ID: \(song.id)\n"
                    songString += "Name: \(song.name ?? "")\n"

                    // Validate Artist ID
                    let artistFetchRequest: NSFetchRequest<ArtistData> = ArtistData.fetchRequest()
                    artistFetchRequest.predicate = NSPredicate(format: "id == %ld", song.artist_id)
                    let artists = try context.fetch(artistFetchRequest)
                    if let artist = artists.first {
                        songString += "Artist ID: \(artist.id)\n"
                    } else {
                        songString += "Artist ID: Not found\n"
                    }

                    // Validate Album ID
                    let albumFetchRequest: NSFetchRequest<AlbumData> = AlbumData.fetchRequest()
                    albumFetchRequest.predicate = NSPredicate(format: "id == %ld", song.album_id)
                    let albums = try context.fetch(albumFetchRequest)
                    if let album = albums.first {
                        songString += "Album ID: \(album.id)\n"
                    } else {
                        songString += "Album ID: Not found\n"
                    }

                    // Validate Genre ID
                    let genreFetchRequest: NSFetchRequest<GenreData> = GenreData.fetchRequest()
                    genreFetchRequest.predicate = NSPredicate(format: "id == %ld", song.genre_id)
                    let genres = try context.fetch(genreFetchRequest)
                    if let genre = genres.first {
                        songString += "Genre ID: \(genre.id)\n"
                    } else {
                        songString += "Genre ID: Not found\n"
                    }

                    songString += "Duration: \(song.duration)\n"
                    songString += "Favourite: \(song.favourite)\n\n"
                }

                // Set the string as the text for the given UITextView
                textView.text = songString
            } catch {
                // Handle any errors that occur during fetch
                print("Failed to fetch songs: \(error.localizedDescription)")

                // Check if an alert is already being presented
                guard presentedViewController == nil else {
                    return
                }

                // Show an alert with the error message
                let alert = UIAlertController(title: "Error", message: "Failed to fetch song.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }

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
