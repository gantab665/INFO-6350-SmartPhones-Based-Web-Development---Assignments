//
//  ManageArtistsViewController.swift
//  Interface Builder
//  Created by Jerry Reddy on 29/02/24.
//

import UIKit
import CoreData

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
        guard let idText = ArtistIdField?.text, let artistId = Int(idText),
              let artistName = ArtistNameField?.text, !artistName.isEmpty else {
            // handle case where required fields are empty
            let alert = UIAlertController(title: "Error", message: "Please fill out all required fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // check if an artist with the same id or name already exists
        let fetchRequest: NSFetchRequest<ArtistData> = ArtistData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d OR name == %@", artistId, artistName)
        do {
            let existingArtists = try context.fetch(fetchRequest)
            if !existingArtists.isEmpty {
                var errorMessage = "An Artist with the following already exists:\n"
                if existingArtists.contains(where: { $0.id == artistId }) {
                    errorMessage += "ID: \(artistId)"
                }
                if existingArtists.contains(where: { $0.name == artistName }) {
                    errorMessage += "\nArtist Name: \(artistName)"
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
        
        // create a new Artist object and set its properties
        let newArtist = ArtistData(context: context)
        newArtist.id = Int64(artistId)
        newArtist.name = artistName
        
        // save changes to Core Data
        do {
            try context.save()
            let alert = UIAlertController(title: "Success", message: "ARTIST added successfully", preferredStyle: .alert)
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

    @IBAction func DeleteArtist(_ sender: UIButton) {
        print("Delete Company button pressed")
           guard let idText = ArtistIdField.text, let artistId = Int(idText) else {
               let alert = UIAlertController(title: "Error", message: "Please enter a valid Artist ID", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
               return
           }

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
        // Check if any product posts are associated with this company
        let albumFetchRequest: NSFetchRequest<AlbumData> = AlbumData.fetchRequest()
        albumFetchRequest.predicate = NSPredicate(format: "artist_id == %ld", artistId)
        do {
            let albums = try context.fetch(albumFetchRequest)
            if !albums.isEmpty {
                let alert = UIAlertController(title: "Error", message: "There are albums associated with this artist id. Please disassociate or delete them before deleting the product type.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
        } catch let error {
            // Handle any errors that occur during fetch
            let alert = UIAlertController(title: "Error", message: "Failed to fetch product posts associated with company with error: \(error.localizedDescription)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        
    // Now delete the company
       let fetchRequest: NSFetchRequest<ArtistData> = ArtistData.fetchRequest()
       fetchRequest.predicate = NSPredicate(format: "id == %d", artistId)
       do {
           let result = try context.fetch(fetchRequest)
           if let artistToDelete = result.first {
               context.delete(artistToDelete)
               try context.save()

               let alert = UIAlertController(title: "Company Deleted Successfully", message: "Press OK to continue", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
           } else {
               let alert = UIAlertController(title: "Error", message: "Company ID does not exist to delete.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
           }
       } catch {
           let alert = UIAlertController(title: "Error", message: "Failed to delete company", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
       }
    }
    
    
    
    
    
    
    @IBAction func UpdateArtist(_ sender: UIButton) {
       
        print("Update artist button pressed")
        guard let idText = ArtistIdField.text, let artistId = Int(idText),
               let nameText = ArtistNameField.text, !nameText.isEmpty
               
               else {
                   let alert = UIAlertController(title: "Error", message: "Please enter a valid Company ID, Name, Address, Country, Zip, and Type", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   present(alert, animated: true, completion: nil)
                   return
           }
           
           let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
           let fetchRequest: NSFetchRequest<ArtistData> = ArtistData.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "id == %d", artistId)
           
           do {
               let result = try context.fetch(fetchRequest)
               
               if let companyToUpdate = result.first {
                   companyToUpdate.name = nameText
                   
                   
                   try context.save()
                   
                   let alert = UIAlertController(title: "Artist Updated Successfully", message: "Press OK to continue", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   present(alert, animated: true, completion: nil)
               } else {
                   let alert = UIAlertController(title: "Error", message: "Artist ID does not exist to update.", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   present(alert, animated: true, completion: nil)
               }
           } catch {
               let alert = UIAlertController(title: "Error", message: "Failed to update company", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
           }
    }
    

     func viewAllArtists(textView: UITextView) {
         // Get the managed object context
             let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
             
             do {
                 // Create a fetch request for the CompanyData entity
                 let fetchRequest: NSFetchRequest<ArtistData> = ArtistData.fetchRequest()
                 
                 // Fetch all companies from Core Data
                 let artists = try context.fetch(fetchRequest)
                 
                 // Construct a string with details of all companies
                 var artistString = ""
                 for artist in artists {
                     artistString += "ID: \(artist.id)\n"
                     artistString += "Name: \(artist.name ?? "")\n"
                     
                 }
                 
                 // Set the string as the text for the given UITextView
                 textView.text = artistString
             } catch {
                 // Handle any errors that occur during fetch
                 print("Failed to fetch companies: \(error.localizedDescription)")
                 
                 // Check if an alert is already being presented
                 guard presentedViewController == nil else {
                     return
                 }
                 
                 // Show an alert with the error message
                 let alert = UIAlertController(title: "Error", message: "Failed to fetch artist.", preferredStyle: .alert)
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
