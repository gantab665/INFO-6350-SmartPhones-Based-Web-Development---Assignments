//
//  SearchViewController.swift
//   Interface Builder
//  Created by Jerry Reddy on 29/02/24.
//

import UIKit

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
        
        let Artists = albumManager.artists.filter { $0.name == nameText }
        guard let artist = Artists.first else {
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
        
        let Albums = albumManager.albums.filter { $0.title == nameText }
        guard let album = Albums.first else {
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
        
        let Songs = albumManager.songs.filter { $0.title == nameText }
        guard let song = Songs.first else {
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
        
        let Genres = albumManager.genres.filter { $0.name == nameText }
        guard let genre = Genres.first else {
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
        let artists = albumManager.viewAllArtists()
        if let artist = artists.first(where: { $0.name == name }) {
                let postString = """
                    ID: \(artist.id)
                    Name: \(artist.name)
                    
                    """
                textView.text = postString
            } else {
                textView.text = "Artist with name \(name) not found"
            }
    }
    
    func displayAlbumDetails(name:String, textView: UITextView) {
        let albums = albumManager.viewAllAlbums()
        if let album = albums.first(where: { $0.title == name }) {
                let postString = """
                    ID: \(album.album_id)
                    Name: \(album.title)
                    Artist ID: \(album.artist_id)
                    Release Date: \(album.release_date)
                    """
                textView.text = postString
            } else {
                textView.text = "Album with name \(name) not found"
            }
    }
    func displaySongDetails(name:String, textView: UITextView) {
        let songs = albumManager.viewAllSongs()
        if let song = songs.first(where: { $0.title == name }) {
                let postString = """
                    ID: \(song.song_id)
                    Name: \(song.title)
                    Artist ID: \(song.artist_id)
                    Album id: \(song.album_id)
                    Genre id: \(song.genre_id)
                    Favourite : \(song.favourite)
                    Duration : \(song.duration)
                    """
                textView.text = postString
            } else {
                textView.text = "Song with name \(name) not found"
            }
    }
    func displayGenreDetails(name:String, textView: UITextView) {
        let genres = albumManager.viewAllGenres()
        if let genre = genres.first(where: { $0.name == name }) {
                let postString = """
                    ID: \(genre.genre_id)
                    Name: \(genre.name)
                    
                    """
                textView.text = postString
              
            } else {
                textView.text = "Genre with name \(name) not found"
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
