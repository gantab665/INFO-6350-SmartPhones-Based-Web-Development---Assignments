//
//  ManageAlbumsViewController.swift
//  Interface Builder
//  Created by Jerry Reddy on 29/02/24.
//

import UIKit
import CoreData

class ManageAlbumsViewController: UIViewController {

    @IBOutlet weak var AlbumIdField: UITextField!
    @IBOutlet weak var AlbumNameField: UITextField!
    @IBOutlet weak var AlbumReleaseDateField: UITextField!
    @IBOutlet weak var AlbumArtistIdField: UITextField!
    var dateFormatter = DateFormatter()
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
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
        guard let albumIdText = AlbumIdField?.text, let albumId = Int(albumIdText),
              let albumNameText = AlbumNameField?.text, !albumNameText.isEmpty,
              let albumDateText = AlbumReleaseDateField?.text, !albumDateText.isEmpty,
              let artistIdText = AlbumArtistIdField?.text, let artistId = Int(artistIdText)
        else {
            let alert = UIAlertController(title: "Error", message: "Please fill all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        // Check if product already exists
        let fetchRequest: NSFetchRequest<AlbumData> = AlbumData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %ld OR name == %@", albumId, albumNameText)
        do {
            let existingAlbums = try context.fetch(fetchRequest)
            if existingAlbums.count > 0 {
                var errorMessage = "Album with the following already exists:\n"
                if existingAlbums.contains(where: { $0.id == albumId }) {
                    errorMessage += "ID: \(albumId)\n"
                }
                if existingAlbums.contains(where: { $0.name == albumNameText }) {
                    errorMessage += "Album Name: \(albumNameText)\n"
                }
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
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

        // Check if artist exists
        let artistFetchRequest: NSFetchRequest<ArtistData> = ArtistData.fetchRequest()
        artistFetchRequest.predicate = NSPredicate(format: "id == %ld", artistId)
        do {
            let artists = try context.fetch(artistFetchRequest)
            if artists.count == 0 {
                let alert = UIAlertController(title: "Error", message: "Artist ID does not exist", preferredStyle: .alert)
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
        dateFormatter.dateFormat = "yyyy-MM-dd" // Replace with your desired date format
        guard let date = dateFormatter.date(from: albumDateText) else {
            let alert = UIAlertController(title: "Error", message: "Invalid Date Format \(String(describing: albumDateText))", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        // Create new album object
        let newAlbum = AlbumData(context: context)
        newAlbum.id = Int64(albumId)
        newAlbum.name = albumNameText
        newAlbum.artist_id = Int64(artistId)
        newAlbum.release_date = date
        // Save changes

        // save changes to Core Data
        do {
            try context.save()
            let alert = UIAlertController(title: "Success", message: "Album added successfully", preferredStyle: .alert)
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
    
    
    
    
    
    
    
    
    
    
    
    


    @IBAction func DeleteAlbum(_ sender: UIButton) {
        print("Delete Album button pressed")
        guard let albumIdText = AlbumIdField?.text, let albumDeleteId = Int(albumIdText) else {
            let alert = UIAlertController(title: "Error", message: "Please enter a valid Album ID", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // Check if any songs are associated with this album
        let songFetchRequest: NSFetchRequest<SongData> = SongData.fetchRequest()
        songFetchRequest.predicate = NSPredicate(format: "album_id == %ld", albumDeleteId)

        do {
            let songs = try context.fetch(songFetchRequest)
            if !songs.isEmpty {
                let alert = UIAlertController(title: "Error", message: "There are songs associated with this album id. Please disassociate or delete them before deleting the album", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
        } catch let error {
            // Handle any errors that occur during fetch
            let alert = UIAlertController(title: "Error", message: "Failed to fetch  associated with product id with error: \(error.localizedDescription)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }


        // Now delete the product id
        let fetchRequest: NSFetchRequest<AlbumData> = AlbumData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", albumDeleteId)
        do {
            let results = try context.fetch(fetchRequest)
            if let albumToDelete = results.first {
                context.delete(albumToDelete)
                try context.save()
                // Deletion was successful
                let alert = UIAlertController(title: "Album Deleted Successfully", message: "Press ok to continue", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            } else {
                // Deletion failed
                let alert = UIAlertController(title: "Error", message: "Album ID does not exist to delete.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        } catch {
            // handle error
            print("Error deleting album: \(error)")
            let alert = UIAlertController(title: "Error", message: "Unable to delete album.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }

    }

    @IBAction func UpdateAlbum(_ sender: UIButton) {
        print("Update Album Post button pressed")

        guard let albumIdText = AlbumIdField?.text,
              let albumId = Int(albumIdText),
              let albumNameText = AlbumNameField?.text,
              !albumNameText.isEmpty,
              let albumDateText = AlbumReleaseDateField?.text,
              !albumDateText.isEmpty,
              let artistIdText = AlbumArtistIdField?.text,
              let artistId = Int(artistIdText)
        else {
            let alert = UIAlertController(title: "Error", message: "Please fill all fields ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
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

        dateFormatter.dateFormat = "yyyy-MM-dd" // Replace with your desired date format
        guard let date = dateFormatter.date(from: albumDateText) else {
            let alert = UIAlertController(title: "Error", message: "Invalid Date Format \(String(describing: albumDateText))", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        // Update the album
        let fetchRequestToUpdate: NSFetchRequest<AlbumData> = AlbumData.fetchRequest()
        fetchRequestToUpdate.predicate = NSPredicate(format: "id == %ld", albumId)
        do {
            let result = try context.fetch(fetchRequestToUpdate)
            
            if let albumToUpdate = result.first {
                if albumToUpdate.artist_id != Int64(artistId) {
                    let alert = UIAlertController(title: "Error", message: "You are not allowed to update the Artist ID", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
                albumToUpdate.id = Int64(albumId)
                albumToUpdate.artist_id = Int64(artistId)
                albumToUpdate.release_date = date
                albumToUpdate.name = albumNameText
                
                try context.save()
                
                let alert = UIAlertController(title: "Album Updated Successfully", message: "Press OK to continue", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "Album Id does not exist to update.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        } catch {
            let alert = UIAlertController(title: "Error", message: "Failed to update album", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }


    }
    
    func viewAllAlbums(textView: UITextView) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        do {
            // Create a fetch request for the AlbumData entity
            let fetchRequest: NSFetchRequest<AlbumData> = AlbumData.fetchRequest()
            
            // Fetch all albums from Core Data
            let albums = try context.fetch(fetchRequest)
            
            // Construct a string with details of all albums
            var albumString = ""
            for album in albums {
                albumString += "ID: \(album.id)\n"
                albumString += "Name: \(album.name ?? "")\n"
                albumString += "Artist ID: \(album.artist_id)\n"
                if let releaseDate = album.release_date {
                    let formattedDate = dateFormatter.string(from: releaseDate)
                    albumString += "Release Date: \(formattedDate)\n"
                }
                albumString += "\n" // Add a line break between each album
            }
            
            // Set the string as the text for the given UITextView
            textView.text = albumString
        } catch {
            // Handle any errors that occur during fetch
            print("Failed to fetch albums: \(error.localizedDescription)")
            
            // Show an alert with the error message
            let alert = UIAlertController(title: "Error", message: "Failed to fetch albums.", preferredStyle: .alert)
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
