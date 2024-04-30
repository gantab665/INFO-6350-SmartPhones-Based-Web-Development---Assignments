//
//  ManageAlbumsViewController.swift
//  Interface Builder
//  Created by Jerry Reddy on 29/02/24.
//

import UIKit

class ManageAlbumsViewController: UIViewController {

    @IBOutlet weak var AlbumIdField: UITextField!
    @IBOutlet weak var AlbumNameField: UITextField!
    @IBOutlet weak var AlbumReleaseDateField: UITextField!
    @IBOutlet weak var AlbumArtistIdField: UITextField!
    var dateFormatter = DateFormatter()
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
       

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addAlbumButtonTapped(_ sender: UIButton) {
    let vc = ManageAlbumsViewController(nibName: "AddAlbumView", bundle: nil)
    self.present(vc, animated: true, completion: nil)
    }
    @IBAction func deleteAlbumButtonTapped(_ sender: UIButton) {
        let vc = ManageAlbumsViewController(nibName: "DeleteAlbumView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func updateAlbumButtonTapped(_ sender: UIButton) {
        let vc = ManageAlbumsViewController(nibName: "UpdateAlbumView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func viewAllAlbumsButtonTapped(_ sender: UIButton) {
        let vc = ManageAlbumsViewController(nibName: "ViewAllAlbumsView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
        if let textView = vc.textView {
                viewAllAlbums(textView: textView)
                    }
    }

    @IBAction func goBackButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }



    @IBAction func AddAlbum(_ sender: UIButton) {
        print("Add Album button pressed")
        // Placeholder for release date in "yyyy/mm/dd" format - ensure user input matches this format
        // dateFormatter.dateFormat = "yyyy-MM-dd" // This line will format the date correctly based on the user input
        if let albumIdText = AlbumIdField?.text, let albumId = Int(albumIdText),
           let albumNameText = AlbumNameField?.text, !albumNameText.isEmpty,
           let albumDateText = AlbumReleaseDateField?.text, !albumDateText.isEmpty,
           let artistIdText = AlbumArtistIdField?.text, let artistId = Int(artistIdText){
            
            // Check if the album already exists
            let albumIDExists = albumManager.albums.contains { $0.album_id == albumId }
            if albumIDExists {
                let alert = UIAlertController(title: "Error", message: "Album with ID \(albumId) already exists.", preferredStyle: .alert)
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
            
            dateFormatter.dateFormat = "yyyy-MM-dd" // Replace with your desired date format
            guard let date = dateFormatter.date(from: albumDateText) else {
                let alert = UIAlertController(title: "Error", message: "Invalid Date Format \(String(describing: albumDateText))", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
           
            let newAlbum = Album(album_id: albumId, artist_id: artistId, title: albumNameText, release_date: date)
            albumManager.addAlbum(album: newAlbum)
            
            let alert = UIAlertController(title: "Album Added Successfully", message: "Press OK to continue", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            // Handle case where any required field is empty or not a valid integer
            let alert = UIAlertController(title: "Error", message: "One or more fields are empty or contain invalid values.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }


    @IBAction func DeleteAlbum(_ sender: UIButton) {
        if let albumIdText = AlbumIdField?.text, let albumDeleteId = Int(albumIdText){
            let albumIDExists = albumManager.albums.contains { $0.album_id == albumDeleteId }
            if albumIDExists {
                // Delete the  from the  array
                if let albumToDelete = albumManager.albums.first(where: { $0.album_id == albumDeleteId }) {
                    // Check if the album has associated songs
                            let hasSongs = albumManager.songs.contains { $0.album_id == albumDeleteId }
                            if hasSongs {
                                let alert = UIAlertController(title: "Error", message: "Album has one or more songs Can't delete .", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                present(alert, animated: true, completion: nil)
                                return
                            }
                    
                    albumManager.deleteAlbum(album: albumToDelete)
                    print("Album deleted successfully!")
                    // Handle case where  id is deleted
                    let alert = UIAlertController(title: "Success", message: "Album deleted successfully", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
            } else {
                // Handle case where  id is not valid
                let alert = UIAlertController(title: "Error", message: "Album ID does not exist to delete.", preferredStyle: .alert)
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

    @IBAction func UpdateAlbum(_ sender: UIButton) {
        print("Update Album button pressed")
        //        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let albumIdText = AlbumIdField?.text, let albumId = Int(albumIdText),
           let albumNameText = AlbumNameField?.text, !albumNameText.isEmpty,
           let albumDateText = AlbumReleaseDateField?.text, !albumDateText.isEmpty,
           let artistIdText = AlbumArtistIdField?.text, let artistId = Int(artistIdText){
            
            // Check if the song already exists
            if let albumIDExists = albumManager.albums.first (where: { $0.album_id == albumId })
             {
                // Check if the  ID is valid
                if !albumManager.albums.contains(where: { $0.album_id == albumId }) {
                    let alert = UIAlertController(title: "Error", message: "Album ID \(albumId) is invalid.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
                // Check if the artist ID matches the existing record, to not allow artist ID updates
                            if albumIDExists.artist_id != artistId {
                                let alert = UIAlertController(title: "Error", message: "Cannot change the artist ID for an existing album. Artist ID must match the current artist ID associated with the album.", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                present(alert, animated: true, completion: nil)
                                return
                            }
                // Check if the artist ID is valid
                if !albumManager.albums.contains(where: { $0.artist_id == artistId }) {
                    let alert = UIAlertController(title: "Error", message: "Artist ID \(artistId) is invalid.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
               
                //
                dateFormatter.dateFormat = "yyyy-MM-dd" // Replace with your desired date format
                guard let date = dateFormatter.date(from: albumDateText) else {
                    let alert = UIAlertController(title: "Error", message: "Invalid Date Format \(String(describing: albumDateText))", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
                // Create a new song and add it to the songs array
                let newAlbum = Album(album_id: albumId ,artist_id:artistId, title: albumNameText,release_date:date)
                albumManager.updateAlbum(album: newAlbum)
                
                let alert = UIAlertController(title: "Album updated Successfully", message: "Press OK to continue", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            else{
                // Handle case where song id is not valid
                let alert = UIAlertController(title: "Error", message: "Artist ID does not exist to update.", preferredStyle: .alert)
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
    
    func viewAllAlbums(textView: UITextView) {
            let albums = albumManager.viewAllAlbums() // Assuming albumManager is defined and has a viewAllAlbums method that returns [Album]
            var albumString = ""
            dateFormatter.dateFormat = "yyyy-MM-dd" // Set the date format for displaying album release dates
            for album in albums {
                let formattedReleaseDate = dateFormatter.string(from: album.release_date) // Format the release date as a string
                albumString += "Album ID: \(album.album_id)\n"
                albumString += "Name: \(album.title)\n"
                albumString += "Artist ID: \(album.artist_id)\n"
                albumString += "Release Date: \(formattedReleaseDate)\n\n" // Use the formatted date string
            }
            textView.text = albumString
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
