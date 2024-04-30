//
//  ManageArtistsViewController.swift
//  Interface Builder
//  Created by Jerry Reddy on 29/02/24.
//

import UIKit

class ManageArtistsViewController: UIViewController {

    @IBOutlet weak var ArtistIdField: UITextField!
    @IBOutlet weak var ArtistNameField: UITextField!
    @IBOutlet weak var TextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addArtistButtonTapped(_ sender: UIButton) {
        let vc = ManageArtistsViewController(nibName: "AddArtistView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func deleteArtistButtonTapped(_ sender: UIButton) {
        let vc = ManageArtistsViewController(nibName: "DeleteArtistView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func updateArtistButtonTapped(_ sender: UIButton) {
        let vc = ManageArtistsViewController(nibName: "UpdateArtistView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func viewAllArtistsButtonTapped(_ sender: UIButton) {
        let vc = ManageArtistsViewController(nibName: "ViewAllArtistsView", bundle: nil)
                    self.present(vc, animated: true, completion: nil)
        if let textView = vc.TextView {
                    viewAllArtists(textView: textView)
                    }
        }

    @IBAction func GoBackButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func AddArtist(_ sender: UIButton) { print("Add Artist button pressed")
        if let idText = ArtistIdField?.text, let artistId = Int(idText) ,
           let artistName = ArtistNameField?.text, !artistName.isEmpty{
            let genreExists = albumManager.artists.contains { $0.id == artistId || $0.name == artistName}
            if genreExists {
                var errorMessage = "Artist with the following already exists:\n"
                if albumManager.artists.contains(where: { $0.id == artistId }) {
                    errorMessage += "ID: \(artistId)"
                }
                if albumManager.artists.contains(where: { $0.name == artistName }) {
                    errorMessage += "\nArtist Name: \(artistName)"
                }
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            let newArtist = Artist(id: artistId, name: artistName)
            albumManager.addArtist(artist: newArtist)
            let alert = UIAlertController(title: "Artist Added Successfully", message: "Press ok to continue", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            // handle case where idField has no text or the text is not a valid integer
            let alert = UIAlertController(title: "Error", message: "Fields are empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func DeleteArtist(_ sender: UIButton) {
        if let artistIdText = ArtistIdField?.text, let artistDeleteId = Int(artistIdText){
            let artistIDExists = albumManager.artists.contains { $0.id == artistDeleteId }
            if artistIDExists {
                
                if let artistToDelete = albumManager.artists.first(where: { $0.id == artistDeleteId }) {
                    // Check if the artist has associated albums
                            let hasAlbums = albumManager.albums.contains { $0.artist_id == artistDeleteId }
                            if hasAlbums {
                                let alert = UIAlertController(title: "Error", message: "Artist has one or more albums Can't delete", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                present(alert, animated: true, completion: nil)
                                return
                            }
                            
                    albumManager.deleteArtist(artist: artistToDelete)
                    print("Artist deleted successfully!")
                    // Handle case where  id is deleted
                    let alert = UIAlertController(title: "Success", message: "Artist deleted successfully", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
            } else {
                // Handle case if it is not valid
                let alert = UIAlertController(title: "Error", message: "Artist ID does not exist to delete.", preferredStyle: .alert)
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
    @IBAction func UpdateArtist(_ sender: UIButton) {
        print("Update Artist button pressed")
        //        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let artistIdText = ArtistIdField?.text, let artistId = Int(artistIdText),
           let artistName = ArtistNameField?.text, !artistName.isEmpty{
            
            // Check if the artist already exists
            let artistIDExists = albumManager.artists.contains { $0.id == artistId }
            if artistIDExists {
                // Check if the product type ID is valid
                if !albumManager.artists.contains(where: { $0.id == artistId }) {
                    let alert = UIAlertController(title: "Error", message: "Artist ID \(artistId) is invalid.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
              
                // Create a new artist and add it to the  array
                let newArtist = Artist(id: artistId, name: artistName)
                albumManager.updateArtist(artist: newArtist)
                
                let alert = UIAlertController(title: "Artist updated Successfully", message: "Press OK to continue", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            else{
                // Handle case where id is not valid
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
    

     func viewAllArtists(textView: UITextView) {
        print("View Artist button pressed")
        let artists = albumManager.viewAllArtists()
        var artistString = ""
        for artist in artists {
            artistString += "ID: \(artist.id)\n"
            artistString += "Name: \(artist.name)\n"
            
        }
        textView.text = artistString
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
