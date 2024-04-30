//
//  ManageGenresViewController.swift
//  Interface Builder
//  Created by Jerry Reddy on 29/02/24.
//

import UIKit
import CoreData

class ManageGenresViewController: UIViewController {

    

    @IBOutlet weak var GenreIdField: UITextField!
    @IBOutlet weak var GenreNameField: UITextField!
    @IBOutlet weak var TextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func AddGenreButtonTapped(_ sender: UIButton) {
        let vc = ManageGenresViewController(nibName: "AddGenreView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func deleteGenreButtonTapped(_ sender: UIButton) {
        let vc = ManageGenresViewController(nibName: "DeleteGenreView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func updateGenreButtonTapped(_ sender: UIButton) {
        let vc = ManageGenresViewController(nibName: "UpdateGenreView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func viewAllGenresButtonTapped(_ sender: UIButton) {
        let vc = ManageGenresViewController(nibName: "ViewAllGenresView", bundle: nil)
            self.present(vc, animated: true, completion: nil)
        if let textView = vc.TextView {
                viewAllGenres(textView: textView)
            }
    }

    @IBAction func GoBackButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func AddGenre(_ sender: UIButton) {
        print("Add Genre button pressed")
        guard let idText = GenreIdField?.text, let genreId = Int(idText),
              let genreName = GenreNameField?.text, !genreName.isEmpty else {
            // handle case where required fields are empty
            let alert = UIAlertController(title: "Error", message: "Please fill out all required fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // check if an artist with the same id or name already exists
        let fetchRequest: NSFetchRequest<GenreData> = GenreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d OR name == %@", genreId, genreName)
        do {
            let existingGenres = try context.fetch(fetchRequest)
            if !existingGenres.isEmpty {
                var errorMessage = "Genre with the following already exists:\n"
                if existingGenres.contains(where: { $0.id == genreId }) {
                    errorMessage += "ID: \(genreId)"
                }
                if existingGenres.contains(where: { $0.name == genreName }) {
                    errorMessage += "\nGenre Name: \(genreName)"
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

        // create a new Genre object and set its properties
        let newGenre = GenreData(context: context)
        newGenre.id = Int64(genreId)
        newGenre.name = genreName

        // save changes to Core Data
        do {
            try context.save()
            let alert = UIAlertController(title: "Success", message: "Genre added successfully", preferredStyle: .alert)
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
    
    @IBAction func DeleteGenre(_ sender: UIButton) {
        print("Delete Genre button pressed")
        guard let genreIdText = GenreIdField?.text, let genreDeleteId = Int(genreIdText) else {
            let alert = UIAlertController(title: "Error", message: "Please enter a valid Genre ID", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // Check if any songs are associated with this genre
        let songFetchRequest: NSFetchRequest<SongData> = SongData.fetchRequest()
        songFetchRequest.predicate = NSPredicate(format: "genre_id == %ld", genreDeleteId)
        do {
            let genres = try context.fetch(songFetchRequest)
            if !genres.isEmpty {
                let alert = UIAlertController(title: "Error", message: "There are songs associated with this genre id. Please disassociate or delete them before deleting the genre", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
        } catch let error {
            // Handle any errors that occur during fetch
            let alert = UIAlertController(title: "Error", message: "Failed to fetch songs associated with this genre with error: \(error.localizedDescription)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        // Now delete the company
        let fetchRequest: NSFetchRequest<GenreData> = GenreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", genreDeleteId)
        do {
            let result = try context.fetch(fetchRequest)
            if let genreToDelete = result.first {
                context.delete(genreToDelete)
                try context.save()

                let alert = UIAlertController(title: "Genre Deleted Successfully", message: "Press OK to continue", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "Genre ID does not exist to delete.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        } catch {
            let alert = UIAlertController(title: "Error", message: "Failed to delete genre", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }

    }
    
    @IBAction func UpdateGenre(_ sender: UIButton) {
        print("Update Genre button pressed")
        guard let genreIdText = GenreIdField?.text, let genreId = Int(genreIdText),
              let genreName = GenreNameField?.text, !genreName.isEmpty
        else {
            let alert = UIAlertController(title: "Error", message: "Please enter a valid details", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<GenreData> = GenreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", genreId)

        do {
            let result = try context.fetch(fetchRequest)
            
            if let genreToUpdate = result.first {
                genreToUpdate.name = genreName
                
                try context.save()
                
                let alert = UIAlertController(title: "Genre Updated Successfully", message: "Press OK to continue", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "Genre ID does not exist to update.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        } catch {
            let alert = UIAlertController(title: "Error", message: "Failed to update company", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }

    }
    func viewAllGenres(textView: UITextView) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        do {
            // Create a fetch request for the GenreData entity
            let fetchRequest: NSFetchRequest<GenreData> = GenreData.fetchRequest()
            
            // Fetch all genres from Core Data
            let genres = try context.fetch(fetchRequest)
            
            // Construct a string with details of all genres
            var genreString = ""
            for genre in genres {
                genreString += "ID: \(genre.id)\n"
                genreString += "Name: \(genre.name ?? "")\n"
            }
            
            // Set the string as the text for the given UITextView
            textView.text = genreString
        } catch {
            // Handle any errors that occur during fetch
            print("Failed to fetch genres: \(error.localizedDescription)")
            
            // Check if an alert is already being presented
            guard presentedViewController == nil else {
                return
            }
            
            // Show an alert with the error message
            let alert = UIAlertController(title: "Error", message: "Failed to fetch genre.", preferredStyle: .alert)
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
