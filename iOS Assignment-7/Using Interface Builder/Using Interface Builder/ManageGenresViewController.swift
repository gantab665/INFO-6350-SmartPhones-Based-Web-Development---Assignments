//
//  ManageGenresViewController.swift
//  Interface Builder
//  Created by Jerry Reddy on 29/02/24.
//

import UIKit

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
        if let idText = GenreIdField?.text, let genreId = Int(idText) ,
           let genreName = GenreNameField?.text, !genreName.isEmpty{
            let genreExists = albumManager.genres.contains { $0.genre_id == genreId || $0.name == genreName}
            if genreExists {
                var errorMessage = "Genre with the following already exists:\n"
                if albumManager.genres.contains(where: { $0.genre_id == genreId }) {
                    errorMessage += "ID: \(genreId)"
                }
                if albumManager.genres.contains(where: { $0.name == genreName }) {
                    errorMessage += "\nGenre Name: \(genreName)"
                }
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            let newGenre = Genre(genre_id: genreId, name: genreName)
            albumManager.addGenre(genre: newGenre)
            let alert = UIAlertController(title: "Genre Added Successfully", message: "Press ok to continue", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            // handle case where idField has no text or the text is not a valid integer
            let alert = UIAlertController(title: "Error", message: "Fields are inavalid/empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func DeleteGenre(_ sender: UIButton) {
        if let genreIdText = GenreIdField?.text, let genreDeleteId = Int(genreIdText){
            let genreIDExists = albumManager.genres.contains { $0.genre_id == genreDeleteId }
            if genreIDExists {
                // Delete the array
                if let genreToDelete = albumManager.genres.first(where: { $0.genre_id == genreDeleteId }) {
                    
                    // Check if the genre is associated with songs
                            let isAssociatedWithSong = albumManager.songs.contains { $0.genre_id == genreDeleteId }
                            if isAssociatedWithSong {
                                let alert = UIAlertController(title: "Error", message: "Genre is s associated with one or more Song, cannot delete it", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                present(alert, animated: true, completion: nil)
                                return
                            }
                    
                    albumManager.deleteGenre(genre: genreToDelete)
                    print("Genre deleted successfully!")
                    // Handle case where product post id is deleted
                    let alert = UIAlertController(title: "Success", message: "Genre deleted successfully", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
            } else {
                // Handle case where  id is not valid
                let alert = UIAlertController(title: "Error", message: "Genre ID does not exist to delete.", preferredStyle: .alert)
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
    
    @IBAction func UpdateGenre(_ sender: UIButton) {
        print("Update Genre button pressed")
        //        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let genreIdText = GenreIdField?.text, let genreId = Int(genreIdText),
           let genreName = GenreNameField?.text, !genreName.isEmpty{
            
            // Check if the artist already exists
            let genreIDExists = albumManager.genres.contains { $0.genre_id == genreId }
            if genreIDExists {
                // Check if the  ID is valid
                if !albumManager.genres.contains(where: { $0.genre_id == genreId }) {
                    let alert = UIAlertController(title: "Error", message: "Genre ID \(genreId) is invalid.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
              
                // Create a new genre and add it to the genre array
                let newGenre = Genre(genre_id: genreId, name: genreName)
                albumManager.updateGenre(genre: newGenre)
                
                let alert = UIAlertController(title: "Genre updated Successfully", message: "Press OK to continue", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            else{
                // Handle case where genre id is not valid
                let alert = UIAlertController(title: "Error", message: "Genre ID does not exist to update.", preferredStyle: .alert)
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
    func viewAllGenres(textView: UITextView) {
        let genres = albumManager.viewAllGenres()
        var genresString = ""
        for genre in genres {
            genresString += "ID: \(genre.genre_id)\n"
            genresString += "Genre: \(genre.name)\n\n"
        }
        textView.text = genresString
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
