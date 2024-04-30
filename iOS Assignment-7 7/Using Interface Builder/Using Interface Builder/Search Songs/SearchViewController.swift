//
//  SearchViewController.swift
//   Interface Builder
//  Created by Jerry Reddy on 29/02/24.
//

import UIKit
import CoreData

class SearchViewController: UIViewController {
    @IBOutlet weak var SearchNameField: UITextField!

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchArtistButtonTapped(_ sender: UIButton) {
        let vc = SearchViewController(nibName: "SearchArtistView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func searchAlbumButtonTapped(_ sender: UIButton) {
        let vc = SearchViewController(nibName: "SearchAlbumView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func searchSongButtonTapped(_ sender: UIButton) {
        let vc = SearchViewController(nibName: "SearchSongView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func searchGenreButtonTapped(_ sender: UIButton) {
        let vc = SearchViewController(nibName: "SearchGenreView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func goBackButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchArtist(_ sender: UIButton) {
        print("submitArtistSearch button pressed")
        guard let nameText = SearchNameField?.text,!nameText.isEmpty else {
            // handle case where idField has no text or the text is not a valid integer
            let alert = UIAlertController(title: "Error", message: "Empty Artist Name Field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        
        guard nameText != "" else {
            // handle case where artist with entered ID is not found
            let alert = UIAlertController(title: "Error", message: "Artist with this name not found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
       
            let vc = SearchViewController(nibName: "DisplaySearchedArtistView", bundle: nil)
            self.present(vc, animated: true, completion: nil)
            if let textView = vc.textView {
                displayArtistDetails(name: nameText, textView: textView)
            }
    }

    @IBAction func searchAlbum(_ sender: UIButton) {
        print("submitAlbumSearch button pressed")
        guard let nameText = SearchNameField?.text,!nameText.isEmpty else {
            // handle case where idField has no text or the text is not a valid integer
            let alert = UIAlertController(title: "Error", message: "Empty Album Name Field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        
        guard nameText != "" else {
            // handle case where album with entered ID is not found
            let alert = UIAlertController(title: "Error", message: "Album with this name not found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
       
            let vc = SearchViewController(nibName: "DisplaySearchedAlbumView", bundle: nil)
            self.present(vc, animated: true, completion: nil)
            if let textView = vc.textView {
                displayAlbumDetails(name: nameText, textView: textView)
            }
    }
    @IBAction func searchSong(_ sender: UIButton) {
        print("submitSongSearch button pressed")
        guard let nameText = SearchNameField?.text,!nameText.isEmpty else {
            // handle case where idField has no text or the text is not a valid integer
            let alert = UIAlertController(title: "Error", message: "Empty Song Name Field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        
        guard nameText != "" else {
            // handle case where album with entered ID is not found
            let alert = UIAlertController(title: "Error", message: "Song with this name not found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
       
            let vc = SearchViewController(nibName: "DisplaySearchedSongView", bundle: nil)
            self.present(vc, animated: true, completion: nil)
            if let textView = vc.textView {
                displaySongDetails(name: nameText, textView: textView)
            }
    }

   

    @IBAction func searchGenre(_ sender: UIButton) {
        print("submitGenreSearch button pressed")
        guard let nameText = SearchNameField?.text,!nameText.isEmpty else {
            // handle case where idField has no text or the text is not a valid integer
            let alert = UIAlertController(title: "Error", message: "Empty Genre Name Field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
       
        guard nameText != "" else {
            // handle case where album with entered ID is not found
            let alert = UIAlertController(title: "Error", message: "Genre with this name not found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
       
            let vc = SearchViewController(nibName: "DisplaySearchedGenreView", bundle: nil)
            self.present(vc, animated: true, completion: nil)
            if let textView = vc.textView {
                displayGenreDetails(name: nameText, textView: textView)
            }
    }
    
   
    func displayArtistDetails(name: String, textView: UITextView) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        do {
            let fetchRequest: NSFetchRequest<ArtistData> = ArtistData.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", name)
            let results = try context.fetch(fetchRequest)
            var artistDetails = ""
            if let artist = results.first {
                // Artist found, display details
                artistDetails += "Artist ID: \(artist.id)\n"
                artistDetails += "Name: \(artist.name ?? "N/A")\n"
                // Add other artist details as needed
                
                // Update UI with artist details
                textView.text = artistDetails
            } else {
                // Artist not found
                textView.text = "Artist with name \(name) not found"
            }
        } catch {
            // Handle error
            print("Error fetching artist: \(error)")
            let alert = UIAlertController(title: "Error", message: "Unable to fetch artist details.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }

        }
    
    
    func displayAlbumDetails(name:String, textView: UITextView) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        do {
            let fetchRequest: NSFetchRequest<AlbumData> = AlbumData.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "name == %@", name)
            let results = try context.fetch(fetchRequest)
            var albumDetails = ""
            if let album = results.first {
                // Artist found, display details
                albumDetails += "Album ID: \(album.id)\n"
                albumDetails += "Name: \(album.name ?? "N/A")\n"
                albumDetails += "Artist ID: \(album.artist_id)\n"
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                if let releaseDate = album.release_date {
                                              albumDetails += "Release Date: \(dateFormatter.string(from: releaseDate))\n"
                                          }
                // Add other artist details as needed
                
                // Update UI with artist details
                textView.text = albumDetails
            } else {
                // Artist not found
                textView.text = "album with name \(name) not found"
            }
        } catch {
            // Handle error
            print("Error fetching artist: \(error)")
            let alert = UIAlertController(title: "Error", message: "Unable to fetch album details.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }

    }
    func displaySongDetails(name:String, textView: UITextView) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            do {
                let fetchRequest: NSFetchRequest<SongData> = SongData.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "name == %@", name)
                let results = try context.fetch(fetchRequest)
                var songDetails = ""
                if let song = results.first {
                    // Song found, display details
                    songDetails += "Song ID: \(song.id)\n"
                    songDetails += "Name: \(song.name ?? "N/A")\n"
                    songDetails += "Artist ID: \(song.artist_id)\n"
                    songDetails += "Album ID: \(song.album_id)\n"
                    songDetails += "Genre ID: \(song.genre_id)\n"
                    songDetails += "Favourite: \(song.favourite)\n"
                    songDetails += "Duration: \(song.duration)\n"
                    // Add other song details as needed
                    
                    // Update UI with song details
                    textView.text = songDetails
                } else {
                    // Song not found
                    textView.text = "Song with name \(name) not found"
                }
            } catch {
                // Handle error
                print("Error fetching song: \(error)")
                let alert = UIAlertController(title: "Error", message: "Unable to fetch song details.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
    }
    func displayGenreDetails(name:String, textView: UITextView) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            do {
                let fetchRequest: NSFetchRequest<GenreData> = GenreData.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "name == %@", name)
                let results = try context.fetch(fetchRequest)
                var genreDetails = ""
                if let genre = results.first {
                    // Genre found, display details
                    genreDetails += "Genre ID: \(genre.id)\n"
                    genreDetails += "Name: \(genre.name ?? "N/A")\n"
                    // Add other genre details as needed
                    
                    // Update UI with genre details
                    textView.text = genreDetails
                } else {
                    // Genre not found
                    textView.text = "Genre with name \(name) not found"
                }
            } catch {
                // Handle error
                print("Error fetching genre: \(error)")
                let alert = UIAlertController(title: "Error", message: "Unable to fetch genre details.", preferredStyle: .alert)
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
