//
//  AppDelegate.swift
//  EmptyApp
//
//  Created by rab on 02/15/24.
//  Copyright © 2024 rab. All rights reserved.
//

import UIKit



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITextFieldDelegate  {
    
    var window: UIWindow?
    
    //  declare properties for each field
    var backButton: UIView?
    
    //  Artist Declarations
    var ArtistIdField: UITextField!
    var ArtistNameField: UITextField!
    
    //Album Declarations
    var AlbumIdField: UITextField!
    var AlbumNameField: UITextField!
    var AlbumReleaseDateField: UITextField!
    var AlbumArtistIdField: UITextField!
    var dateFormatter = DateFormatter()
    
    //Song Declarations
    var SongIdField: UITextField!
    var SongNameField: UITextField!
    var SongArtistIdField: UITextField!
    var SongAlbumIdField: UITextField!
    var SongGenreIdField: UITextField!
    var SongDurationField: UITextField!
    var SongFavouriteField: UITextField!

    // Genre Declarations
    var GenreIdField: UITextField!
    var GenreNameField: UITextField!
    
    // Search Declarations
    var AlbumSearchField: UITextField!
    var GenreSearchField: UITextField!
    var SongSearchField: UITextField!
    var ArtistSearchField: UITextField!
    
    
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // Override point for customization after application launch.
            window = UIWindow(frame: UIScreen.main.bounds)
            if let window = window {
                window.backgroundColor = UIColor.lightGray
                
                window.rootViewController = UIViewController()
                window.makeKeyAndVisible()
                
                //manage artist
                let manageArtistsButton = UIButton(type: .system)
                manageArtistsButton.frame = CGRect(x: 20, y: 300, width: UIScreen.main.bounds.width - 40, height: 30)
                manageArtistsButton.setTitle("Manage Artist", for: .normal)
                manageArtistsButton.addTarget(self, action: #selector(manageArtistsButtonTapped), for: .touchUpInside)
                manageArtistsButton.backgroundColor = UIColor.white
                manageArtistsButton.layer.cornerRadius = 5
                manageArtistsButton.layer.borderWidth = 1
                manageArtistsButton.layer.borderColor = UIColor.black.cgColor
                window.addSubview(manageArtistsButton)
                
                //manage album
                let manageAlbumsButton = UIButton(type: .system)
                manageAlbumsButton.frame = CGRect(x: 20, y: 350, width: UIScreen.main.bounds.width - 40, height: 30)
                manageAlbumsButton.setTitle("Manage Albums", for: .normal)
                manageAlbumsButton.addTarget(self, action: #selector(manageAlbumsButtonTapped), for: .touchUpInside)
                manageAlbumsButton.backgroundColor = UIColor.white
                manageAlbumsButton.layer.cornerRadius = 5
                manageAlbumsButton.layer.borderWidth = 1
                manageAlbumsButton.layer.borderColor = UIColor.black.cgColor
                window.addSubview(manageAlbumsButton)
                
                
                //manage song
                let manageSongsButton = UIButton(type: .system)
                manageSongsButton.frame = CGRect(x: 20, y: 400, width: UIScreen.main.bounds.width - 40, height: 30)
                manageSongsButton.setTitle("Manage Songs", for: .normal)
                manageSongsButton.addTarget(self, action: #selector(manageSongsButtonTapped), for: .touchUpInside)
                manageSongsButton.backgroundColor = UIColor.white
                manageSongsButton.layer.cornerRadius = 5
                manageSongsButton.layer.borderWidth = 1
                manageSongsButton.layer.borderColor = UIColor.black.cgColor
                window.addSubview(manageSongsButton)
                
                //manage genre
                let manageGenreButton = UIButton(type: .system)
                manageGenreButton.frame = CGRect(x: 20, y: 450, width: UIScreen.main.bounds.width - 40, height: 30)
                manageGenreButton.setTitle("Manage Genre", for: .normal)
                manageGenreButton.addTarget(self, action: #selector(manageGenreButtonTapped), for: .touchUpInside)
                manageGenreButton.backgroundColor = UIColor.white
                manageGenreButton.layer.cornerRadius = 5
                manageGenreButton.layer.borderWidth = 1
                manageGenreButton.layer.borderColor = UIColor.black.cgColor
                window.addSubview(manageGenreButton)
                
                //search
                let searchButton = UIButton(type: .system)
                searchButton.frame = CGRect(x: 20, y: 600, width: UIScreen.main.bounds.width - 40, height: 30)
                searchButton.setTitle("Search", for: .normal)
                searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
                searchButton.layer.cornerRadius = 5.0
                searchButton.layer.borderWidth = 1
                searchButton.backgroundColor = UIColor.white
                searchButton.layer.borderColor = UIColor.black.cgColor
                window.addSubview(searchButton)
            }
            
            return true
        }

    

    
    // All Songs Declarations
    @objc func manageSongsButtonTapped() {
        // Create a new view to display the options
        let optionsView = UIView(frame: UIScreen.main.bounds)
        optionsView.backgroundColor = .darkGray
        
        // Add a label to display the title
        let titleLabel = UILabel(frame: CGRect(x: 80, y: 50, width: UIScreen.main.bounds.width - 40, height: 30))
        titleLabel.text = "Manage Songs"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        optionsView.addSubview(titleLabel)
        
        // Add a button to add a new artist
        let addButton = UIButton(type: .system)
        addButton.frame = CGRect(x: 20, y: 100, width: UIScreen.main.bounds.width - 40, height: 50)
        addButton.setTitle("Add New Song", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .systemBlue
        addButton.layer.cornerRadius = 10
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.black.cgColor
        addButton.addTarget(self, action: #selector(addSongButtonTapped), for: .touchUpInside)
        optionsView.addSubview(addButton)
        
        // Add a button to update an existing artist
        let updateButton = UIButton(type: .system)
        updateButton.frame = CGRect(x: 20, y: 170, width: UIScreen.main.bounds.width - 40, height: 50)
        updateButton.setTitle("Update Song", for: .normal)
        updateButton.setTitleColor(.white, for: .normal)
        updateButton.backgroundColor = .systemGreen
        updateButton.layer.cornerRadius = 10
        updateButton.layer.borderWidth = 1
        updateButton.layer.borderColor = UIColor.black.cgColor
        updateButton.addTarget(self, action: #selector(updateSongTapped), for: .touchUpInside)
        optionsView.addSubview(updateButton)
        
      //   Add a button to delete an existing artist
                let deleteButton = UIButton(type: .system)
                deleteButton.frame = CGRect(x: 20, y: 240, width: UIScreen.main.bounds.width - 40, height: 50)
                deleteButton.setTitle("Delete Song", for: .normal)
                deleteButton.setTitleColor(.white, for: .normal)
                deleteButton.backgroundColor = .systemRed
                deleteButton.layer.cornerRadius = 10
                deleteButton.layer.borderWidth = 1
                deleteButton.layer.borderColor = UIColor.black.cgColor
                deleteButton.addTarget(self, action: #selector(DeleteSongTapped), for: .touchUpInside)
                optionsView.addSubview(deleteButton)
        
        // Add a button to view all songs
        let viewAllButton = UIButton(type: .system)
        viewAllButton.frame = CGRect(x: 20, y: 310, width: UIScreen.main.bounds.width - 40, height: 50)
        viewAllButton.setTitle("View All Songs", for: .normal)
        viewAllButton.setTitleColor(.white, for: .normal)
        viewAllButton.backgroundColor = .systemOrange
        viewAllButton.layer.cornerRadius = 10
        viewAllButton.layer.borderWidth = 1
        viewAllButton.layer.borderColor = UIColor.black.cgColor
        viewAllButton.addTarget(self, action: #selector(ViewAllSongsTapped), for: .touchUpInside)
        optionsView.addSubview(viewAllButton)
        
        // Add a "Go Back" button to the view
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        optionsView.addSubview(backButton)
        
        // Add the view to the window
        window?.addSubview(optionsView)
    }
    
    @objc func addSongButtonTapped() {
        // create new view
        let SongView = UIView(frame: UIScreen.main.bounds)
        SongView.backgroundColor = .white
        
        // add subviews for each input field
        // song id
        let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        idLabel.text = "ID:"
        SongView.addSubview(idLabel)
        
        SongIdField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        SongIdField.borderStyle = .roundedRect
        SongIdField.keyboardType = .numberPad  // only accept numeric input
        SongView.addSubview(SongIdField)
        
        //artist id
        let artistIdLabel = UILabel(frame: CGRect(x: 20, y: 140, width: 100, height: 30))
        artistIdLabel.text = "Artist ID:"
        SongView.addSubview(artistIdLabel)
        
        SongArtistIdField = UITextField(frame: CGRect(x: 120, y: 140, width: UIScreen.main.bounds.width - 140, height: 30))
        SongArtistIdField.borderStyle = .roundedRect
        SongArtistIdField.keyboardType = .numberPad  // only accept numeric input
        SongView.addSubview(SongArtistIdField)
        
        //album id
        let albumIdLabel = UILabel(frame: CGRect(x: 20, y: 180, width: 100, height: 30))
        albumIdLabel.text = "Album ID:"
        SongView.addSubview(albumIdLabel)
        
        SongAlbumIdField = UITextField(frame: CGRect(x: 120, y: 180, width: UIScreen.main.bounds.width - 140, height: 30))
        SongAlbumIdField.borderStyle = .roundedRect
        SongAlbumIdField.keyboardType = .numberPad  // only accept numeric input
        SongView.addSubview(SongAlbumIdField)
        
        //genre id
        let genreIdLabel = UILabel(frame: CGRect(x: 20, y: 220, width: 100, height: 30))
        genreIdLabel.text = "Genre ID:"
        SongView.addSubview(genreIdLabel)
        
        SongGenreIdField = UITextField(frame: CGRect(x: 120, y: 220, width: UIScreen.main.bounds.width - 140, height: 30))
        SongGenreIdField.borderStyle = .roundedRect
        SongGenreIdField.keyboardType = .numberPad  // only accept numeric input
        SongView.addSubview(SongGenreIdField)
        
        //song title
        let SongNameLabel = UILabel(frame: CGRect(x: 20, y: 260, width: 100, height: 30))
        SongNameLabel.text = "Song Title:"
        SongView.addSubview(SongNameLabel)
        
        SongNameField = UITextField(frame: CGRect(x: 120, y: 260, width: UIScreen.main.bounds.width - 140, height: 30))
        SongNameField.borderStyle = .roundedRect
        SongView.addSubview(SongNameField)
        
        //song duration
        let idDurationLabel = UILabel(frame: CGRect(x: 20, y: 300, width: 300, height: 30))
        idDurationLabel.text = "Song Duration"
        SongView.addSubview(idDurationLabel)
        
        SongDurationField = UITextField(frame: CGRect(x: 120, y: 300, width: UIScreen.main.bounds.width - 140, height: 30))
        SongDurationField.borderStyle = .roundedRect
        SongDurationField.keyboardType = .numberPad  // only accept numeric input
        SongView.addSubview(SongDurationField)
        
        //song favourite
        let songFavouriteLabel = UILabel(frame: CGRect(x: 20, y: 340, width: 300, height: 30))
        songFavouriteLabel.text = "Favourite Song"
        SongView.addSubview(songFavouriteLabel)
        
        SongFavouriteField = UITextField(frame: CGRect(x: 120, y: 340, width: UIScreen.main.bounds.width - 140, height: 30))
        SongFavouriteField.borderStyle = .roundedRect
        SongView.addSubview(SongFavouriteField)
        
        // add submit button
        let addSongButton = UIButton(type: .system)
        addSongButton.frame = CGRect(x: 20, y: 400, width: UIScreen.main.bounds.width - 40, height: 30)
        addSongButton.setTitle("Add Song", for: .normal)
        addSongButton.setTitleColor(.black, for: .normal)
        addSongButton.addTarget(self, action: #selector(AddSong), for: .touchUpInside)
        addSongButton.backgroundColor = UIColor.green
        addSongButton.layer.cornerRadius = 5
        addSongButton.layer.borderWidth = 1
        addSongButton.layer.borderColor = UIColor.black.cgColor
        SongView.addSubview(addSongButton)
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 450, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        SongView.addSubview(backButton)
        
        // add the product type view to the window
        window?.addSubview(SongView)
    }
    
    //add songs
    @objc func AddSong(){
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
                        songFavBool = false
                        return}
            // Check if the product post already exists
                    let songIDExists = albumManager.songs.contains { $0.song_id == songId }
            if songIDExists {
                let alert = UIAlertController(title: "Error", message: "Song with ID \(songId) already exists.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
                return
            }

            // Check if the artist ID is valid
            if !albumManager.artists.contains(where: { $0.id == artistId }) {
                let alert = UIAlertController(title: "Error", message: "Artist ID \(artistId) is invalid.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
                return
            }
            
                    // Check if the album ID is valid
                    if !albumManager.albums.contains(where: { $0.album_id == albumId }) {
                        let alert = UIAlertController(title: "Error", message: "Album ID \(albumId) is invalid.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        if let rootViewController = window?.rootViewController {
                            rootViewController.present(alert, animated: true, completion: nil)
                        }
                        return
                    }
                    
                    //check if genre id is valid
                    if !albumManager.genres.contains(where: { $0.genre_id == genreId }) {
                        let alert = UIAlertController(title: "Error", message: "Genre ID \(genreId) is invalid.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        if let rootViewController = window?.rootViewController {
                            rootViewController.present(alert, animated: true, completion: nil)
                        }
                        return
                    }
            // Create a new product post and add it to the productPosts array
            let newSong = Song(song_id: songId, artist_id: artistId, album_id: albumId, genre_id: genreId, title: songNameText, duration: songDurationId, favourite: songFavBool)
            albumManager.addSong(song: newSong)
            
            let alert = UIAlertController(title: "Song Added Successfully", message: "Press OK to continue", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        } else {
            // Handle case where any required field is empty or not a valid integer
            let alert = UIAlertController(title: "Error", message: "One or more fields are empty or contain invalid values.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // view all songs
    @objc func ViewAllSongsTapped() {
        print("view all songs pressed")
        let songs = albumManager.viewAllSongs()
        
        // Create a new view to display the songs
        let allSongsView = UIView(frame: UIScreen.main.bounds)
        allSongsView.backgroundColor = .systemTeal
        
        if songs.isEmpty {
            // Add a placeholder label if there are no songs
            let label = UILabel(frame: CGRect(x: 100, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width - 40, height: 30))
            label.text = "No songs available"
            label.textColor = .black
            allSongsView.addSubview(label)
        } else {
            // Add a label for each song
            var yOffset: CGFloat = 50.0 // starting y offset
            for song in songs {
                let idLabel = UILabel(frame: CGRect(x: 20, y: yOffset, width: UIScreen.main.bounds.width - 40, height: 30))
                idLabel.text = "Song ID: \(song.song_id)"
                idLabel.textColor = .black
                allSongsView.addSubview(idLabel)
                
                let artistIdLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 30.0, width: UIScreen.main.bounds.width - 40, height: 30))
                artistIdLabel.text = "Artist ID: \(song.artist_id)"
                artistIdLabel.textColor = .black
                allSongsView.addSubview(artistIdLabel)
                
                let albumIdLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 60.0, width: UIScreen.main.bounds.width - 40, height: 30))
                albumIdLabel.text = "Album ID: \(song.album_id)"
                albumIdLabel.textColor = .black
                allSongsView.addSubview(albumIdLabel)
                
                let genreIdLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 90.0, width: UIScreen.main.bounds.width - 40, height: 30))
                genreIdLabel.text = "Genre ID: \(song.genre_id)"
                genreIdLabel.textColor = .black
                allSongsView.addSubview(genreIdLabel)
                
                let songNameLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 120.0, width: UIScreen.main.bounds.width - 40, height: 30))
                songNameLabel.text = "Song Name: \(song.title)"
                songNameLabel.textColor = .black
                allSongsView.addSubview(songNameLabel)
                
                let songFavLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 150.0, width: UIScreen.main.bounds.width - 40, height: 30))
                songFavLabel.text = "Favourite: \(song.favourite)"
                songFavLabel.textColor = .black
                allSongsView.addSubview(songFavLabel)
                
                // Create a background color for each song entry
                let backgroundColor = UIColor(red: CGFloat.random(in: 0.5...1.0), green: CGFloat.random(in: 0.5...1.0), blue: CGFloat.random(in: 0.5...1.0), alpha: 1.0)
                let labelBackgroundView = UIView(frame: CGRect(x: 10, y: yOffset, width: UIScreen.main.bounds.width - 20, height: 180))
                labelBackgroundView.backgroundColor = backgroundColor
                labelBackgroundView.layer.cornerRadius = 10
                allSongsView.insertSubview(labelBackgroundView, at: 0) // Insert at the lowest layer
                
                yOffset += 190.0 // increment y offset for next song entry
            }
        }
        // Add the 'Go Back' button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        allSongsView.addSubview(backButton)
        
        // Add the allSongsView to the window
        window?.addSubview(allSongsView)
    }

    //update songs
    @objc func updateSongTapped() {
        // create new view
        let SongView = UIView(frame: UIScreen.main.bounds)
        SongView.backgroundColor = .white
        
        // Song ID label and editable field
        let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        idLabel.text = "Song ID:"
        SongView.addSubview(idLabel)
        
        SongIdField = UITextField(frame: CGRect(x: 20, y: 130, width: UIScreen.main.bounds.width - 40, height: 30))
        SongIdField.borderStyle = .roundedRect
        // Make it editable as it's used for searching
        SongIdField.isEnabled = true
        SongView.addSubview(SongIdField)
        
        // Song Title label and editable field
        let songNameLabel = UILabel(frame: CGRect(x: 20, y: 170, width: UIScreen.main.bounds.width - 140, height: 30))
        songNameLabel.text = "Song Title:"
        SongView.addSubview(songNameLabel)
        
        SongNameField = UITextField(frame: CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30))
        SongNameField.borderStyle = .roundedRect
        SongView.addSubview(SongNameField)
        
        // Song Duration label and editable field
        let songDurationLabel = UILabel(frame: CGRect(x: 20, y: 240, width: UIScreen.main.bounds.width - 140, height: 30))
        songDurationLabel.text = "Duration (min):"
        SongView.addSubview(songDurationLabel)
        
        SongDurationField = UITextField(frame: CGRect(x: 20, y: 270, width: UIScreen.main.bounds.width - 40, height: 30))
        SongDurationField.borderStyle = .roundedRect
        SongDurationField.keyboardType = .decimalPad // Accept numeric input including decimals
        SongView.addSubview(SongDurationField)
        
        // Song Favorite label and editable field
        let songFavouriteLabel = UILabel(frame: CGRect(x: 20, y: 310, width: UIScreen.main.bounds.width - 140, height: 30))
        songFavouriteLabel.text = "Favourite (true/false):"
        SongView.addSubview(songFavouriteLabel)
        
        SongFavouriteField = UITextField(frame: CGRect(x: 20, y: 340, width: UIScreen.main.bounds.width - 40, height: 30))
        SongFavouriteField.borderStyle = .roundedRect
        SongView.addSubview(SongFavouriteField)
        
        // Update Song button
        let updateSongButton = UIButton(type: .system)
        updateSongButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 110, width: UIScreen.main.bounds.width - 40, height: 30)
        updateSongButton.setTitle("Update Song", for: .normal)
        updateSongButton.setTitleColor(.white, for: .normal)
        updateSongButton.backgroundColor = UIColor.green
        updateSongButton.layer.cornerRadius = 5
        updateSongButton.layer.borderWidth = 1
        updateSongButton.layer.borderColor = UIColor.black.cgColor
        updateSongButton.addTarget(self, action: #selector(UpdateSong), for: .touchUpInside)
        SongView.addSubview(updateSongButton)
        
        // Go Back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 70, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        SongView.addSubview(backButton)
        
        // add the SongView to the window
        window?.addSubview(SongView)
    }

    // The function signature for 'goBack' and 'UpdateSong' should be present elsewhere in your code


    
    //update Song
    @objc func UpdateSong(){
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
            let songIDExists = albumManager.songs.contains { $0.song_id == songId }
            if songIDExists {
                // Check if the song ID is valid
                if !albumManager.songs.contains(where: { $0.song_id == songId }) {
                    let alert = UIAlertController(title: "Error", message: "Song ID \(songId) is invalid.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    if let rootViewController = window?.rootViewController {
                        rootViewController.present(alert, animated: true, completion: nil)
                    }
                    return
                }
              
                // Check if the artist ID is valid
                if !albumManager.artists.contains(where: { $0.id == artistId }) {
                    let alert = UIAlertController(title: "Error", message: "Artist ID \(artistId) is invalid.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    if let rootViewController = window?.rootViewController {
                        rootViewController.present(alert, animated: true, completion: nil)
                    }
                    return
                }
               
                // Check if the album ID is valid
                if !albumManager.albums.contains(where: { $0.album_id == albumId }) {
                    let alert = UIAlertController(title: "Error", message: "Album ID \(albumId) is invalid.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    if let rootViewController = window?.rootViewController {
                        rootViewController.present(alert, animated: true, completion: nil)
                    }
                    return
                }
                
                // Check if the genre ID is valid
                if !albumManager.genres.contains(where: { $0.genre_id == genreId }) {
                    let alert = UIAlertController(title: "Error", message: "Genre ID \(genreId) is invalid.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    if let rootViewController = window?.rootViewController {
                        rootViewController.present(alert, animated: true, completion: nil)
                    }
                    return
                }
               
                // updated a new song and add it to the songs array
                let newSong = Song(song_id: songId, artist_id: artistId, album_id: albumId, genre_id: genreId, title: songNameText, duration: songDurationId, favourite: songFavBool)
                albumManager.updateSong(song: newSong)
                
                let alert = UIAlertController(title: "Artist updated Successfully", message: "Press OK to continue", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
                return
            }
            else{
                // Handle case where product post id is not valid
                let alert = UIAlertController(title: "Error", message: "Song ID does not exist to update.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            // Handle case where any required field is empty or not a valid integer
            let alert = UIAlertController(title: "Error", message: "One or more fields are empty or contain invalid values.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    // Delete Song
        @objc func DeleteSongTapped() {
            // create new view
            let DeleteSong = UIView(frame: UIScreen.main.bounds)
            DeleteSong.backgroundColor = .white
    
            // add subviews for each input field
            let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
            idLabel.text = "Song ID:"
            DeleteSong.addSubview(idLabel)
    
            SongIdField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
            SongIdField.borderStyle = .roundedRect
            SongIdField.keyboardType = .numberPad  // only accept numeric input
            DeleteSong.addSubview(SongIdField)
    
            // add submit button
            let submitButton = UIButton(type: .system)
            submitButton.frame = CGRect(x: 20, y: 150, width: UIScreen.main.bounds.width - 40, height: 30)
            submitButton.setTitle("Delete Song", for: .normal)
            submitButton.setTitleColor(.black, for: .normal)
            submitButton.addTarget(self, action: #selector(deleteSong), for: .touchUpInside)
            submitButton.backgroundColor = UIColor.green
            submitButton.layer.cornerRadius = 5
            submitButton.layer.borderWidth = 1
            submitButton.layer.borderColor = UIColor.black.cgColor
            DeleteSong.addSubview(submitButton)
    
            // add the go back button
            let backButton = UIButton(type: .system)
            backButton.frame = CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30)
            backButton.setTitle("Go Back", for: .normal)
            backButton.setTitleColor(.black, for: .normal)
            backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
            backButton.backgroundColor = UIColor.systemPink
            backButton.layer.cornerRadius = 5
            backButton.layer.borderWidth = 1
            backButton.layer.borderColor = UIColor.black.cgColor
            DeleteSong.addSubview(backButton)
    
            // add the product view to the window
            window?.addSubview(DeleteSong)
        }
    
    @objc func deleteSong(){
        if let songIdText = SongIdField?.text, let songDeleteId = Int(songIdText){
            let songIDExists = albumManager.songs.contains { $0.song_id == songDeleteId }
            if songIDExists {
                // Delete the product post from the productPosts array
                if let songToDelete = albumManager.songs.first(where: { $0.song_id == songDeleteId }) {
                    albumManager.deleteSong(song: songToDelete)
                    print("Song deleted successfully!")
                    // Handle case where product post id is deleted
                    let alert = UIAlertController(title: "Success", message: "Song deleted successfully", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    if let rootViewController = window?.rootViewController {
                        rootViewController.present(alert, animated: true, completion: nil)
                    }
                }
            } else {
                // Handle case where product post id is not valid
                let alert = UIAlertController(title: "Error", message: "Song ID does not exist to delete.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Please enter an ID", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        }
    }


    // All Artist Declarations
    @objc func manageArtistsButtonTapped() {
        // Create a new view to display the options
        let optionsView = UIView(frame: UIScreen.main.bounds)
        optionsView.backgroundColor = .darkGray
        
        // Add a label to display the title
        let titleLabel = UILabel(frame: CGRect(x: 80, y: 50, width: UIScreen.main.bounds.width - 40, height: 30))
        titleLabel.text = "Manage Artists"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        optionsView.addSubview(titleLabel)
        
        // Add a button to add a new artist
        let addButton = UIButton(type: .system)
        addButton.frame = CGRect(x: 20, y: 100, width: UIScreen.main.bounds.width - 40, height: 50)
        addButton.setTitle("Add New Artist", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .systemBlue
        addButton.layer.cornerRadius = 10
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.black.cgColor
        addButton.addTarget(self, action: #selector(addArtistButtonTapped), for: .touchUpInside)
        optionsView.addSubview(addButton)
        
        // Add a button to update an existing artist
        let updateButton = UIButton(type: .system)
        updateButton.frame = CGRect(x: 20, y: 170, width: UIScreen.main.bounds.width - 40, height: 50)
        updateButton.setTitle("Update Artist", for: .normal)
        updateButton.setTitleColor(.white, for: .normal)
        updateButton.backgroundColor = .systemGreen
        updateButton.layer.cornerRadius = 10
        updateButton.layer.borderWidth = 1
        updateButton.layer.borderColor = UIColor.black.cgColor
        updateButton.addTarget(self, action: #selector(updateArtistTapped), for: .touchUpInside)
        optionsView.addSubview(updateButton)
        
      //   Add a button to delete an existing artist
                let deleteButton = UIButton(type: .system)
                deleteButton.frame = CGRect(x: 20, y: 240, width: UIScreen.main.bounds.width - 40, height: 50)
                deleteButton.setTitle("Delete Artist", for: .normal)
                deleteButton.setTitleColor(.white, for: .normal)
                deleteButton.backgroundColor = .systemRed
                deleteButton.layer.cornerRadius = 10
                deleteButton.layer.borderWidth = 1
                deleteButton.layer.borderColor = UIColor.black.cgColor
                deleteButton.addTarget(self, action: #selector(DeleteArtistTapped), for: .touchUpInside)
                optionsView.addSubview(deleteButton)
        
        // Add a button to view all artists
        let viewAllButton = UIButton(type: .system)
        viewAllButton.frame = CGRect(x: 20, y: 310, width: UIScreen.main.bounds.width - 40, height: 50)
        viewAllButton.setTitle("View All Artists", for: .normal)
        viewAllButton.setTitleColor(.white, for: .normal)
        viewAllButton.backgroundColor = .systemOrange
        viewAllButton.layer.cornerRadius = 10
        viewAllButton.layer.borderWidth = 1
        viewAllButton.layer.borderColor = UIColor.black.cgColor
        viewAllButton.addTarget(self, action: #selector(ViewAllArtistTapped), for: .touchUpInside)
        optionsView.addSubview(viewAllButton)
        
        // Add a "Go Back" button to the view
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        optionsView.addSubview(backButton)
        
        // Add the view to the window
        window?.addSubview(optionsView)
    }
    
    @objc func addArtistButtonTapped() {
        // create new view
        let ArtistView = UIView(frame: UIScreen.main.bounds)
        ArtistView.backgroundColor = .white
        
        // add subviews for each input field
        let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        idLabel.text = "ID:"
        ArtistView.addSubview(idLabel)
        
        ArtistIdField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        ArtistIdField.borderStyle = .roundedRect
        ArtistIdField.keyboardType = .numberPad  // only accept numeric input
        ArtistView.addSubview(ArtistIdField)
        
        let ArtistNameLabel = UILabel(frame: CGRect(x: 20, y: 150, width: 100, height: 30))
        ArtistNameLabel.text = "Name:"
        ArtistView.addSubview(ArtistNameLabel)
        
        ArtistNameField = UITextField(frame: CGRect(x: 120, y: 150, width: UIScreen.main.bounds.width - 140, height: 30))
        ArtistNameField.borderStyle = .roundedRect
        ArtistView.addSubview(ArtistNameField)
        
        // add submit button
        let addArtistButton = UIButton(type: .system)
        addArtistButton.frame = CGRect(x: 20, y: 400, width: UIScreen.main.bounds.width - 40, height: 30)
        addArtistButton.setTitle("Add Artist", for: .normal)
        addArtistButton.setTitleColor(.black, for: .normal)
        addArtistButton.addTarget(self, action: #selector(AddArtist), for: .touchUpInside)
        addArtistButton.backgroundColor = UIColor.green
        addArtistButton.layer.cornerRadius = 5
        addArtistButton.layer.borderWidth = 1
        addArtistButton.layer.borderColor = UIColor.black.cgColor
        ArtistView.addSubview(addArtistButton)
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 450, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        ArtistView.addSubview(backButton)
        
        // add the product type view to the window
        window?.addSubview(ArtistView)
    }
    
    @objc func AddArtist() {
        print("Add Artist button pressed")
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
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
                return
            }
            let newArtist = Artist(id: artistId, name: artistName)
            albumManager.addArtist(artist: newArtist)
            let alert = UIAlertController(title: "Artist Added Successfully", message: "Press ok to continue", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        } else {
            // handle case where idField has no text or the text is not a valid integer
            let alert = UIAlertController(title: "Error", message: "Fields are empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func ViewAllArtistTapped() {
        print("view all artists pressed")
        let artists = albumManager.viewAllArtists()
        
        // Create a new view to display the artists
        let allArtistView = UIView(frame: UIScreen.main.bounds)
        allArtistView.backgroundColor = .systemTeal
        
        if artists.isEmpty {
            // Add a placeholder label if there are no artists
            let label = UILabel(frame: CGRect(x: 100, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width - 40, height: 30))
            label.text = "No artists available"
            label.textColor = .black
            allArtistView.addSubview(label)
        } else {
            // Add a label for each product post
            var yOffset: CGFloat = 50.0 // starting y offset
            for artist in artists {
                let idLabel = UILabel(frame: CGRect(x: 20, y: yOffset, width: UIScreen.main.bounds.width - 40, height: 30))
                idLabel.text = "Artist ID: \(artist.id)"
                idLabel.textColor = .black
                allArtistView.addSubview(idLabel)
                
                let artistNameLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 30.0, width: UIScreen.main.bounds.width - 40, height: 30))
                artistNameLabel.text = "Artist Name \(artist.name)"
                artistNameLabel.textColor = .black
                allArtistView.addSubview(artistNameLabel)
                
                
                
                // Create a background color with rounded edges for each label
                let backgroundColor = UIColor(red: CGFloat.random(in: 0.5...1.0), green: CGFloat.random(in: 0.5...1.0), blue: CGFloat.random(in: 0.5...1.0), alpha: 1.0)
                let labelBackgroundView = UIView(frame: CGRect(x: 0, y: yOffset, width: UIScreen.main.bounds.width, height: 210))
                labelBackgroundView.backgroundColor = backgroundColor
                labelBackgroundView.layer.cornerRadius = 10
                allArtistView.insertSubview(labelBackgroundView, belowSubview: idLabel)
                
                yOffset += 230.0 // increment y offset for next label
            }
        }
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        allArtistView.addSubview(backButton)
        // add the product post view to the window
        window?.addSubview(allArtistView)
    }
    
    @objc func updateArtistTapped() {
        // create new view
        let artistUpdateView = UIView(frame: UIScreen.main.bounds)
        artistUpdateView.backgroundColor = .white
        
        // add subviews for each input field
        let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        idLabel.text = "Artist ID:"
        artistUpdateView.addSubview(idLabel)
        
        ArtistIdField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        ArtistIdField.borderStyle = .roundedRect
        ArtistIdField.keyboardType = .numberPad  // only accept numeric input
        artistUpdateView.addSubview(ArtistIdField)
        
        // add subviews for each input field
        let ArtistNameLabel = UILabel(frame: CGRect(x: 20, y: 150, width: 100, height: 30))
        ArtistNameLabel.text = "Artist Name"
        artistUpdateView.addSubview(ArtistNameLabel)
        
        ArtistNameField = UITextField(frame: CGRect(x: 120, y: 150, width: UIScreen.main.bounds.width - 140, height: 30))
        ArtistNameField.borderStyle = .roundedRect
        ArtistNameField.keyboardType = .numberPad  // only accept numeric input
        artistUpdateView.addSubview(ArtistNameField)
        
        
        // add submit button
        let addArtist = UIButton(type: .system)
        addArtist.frame = CGRect(x: 20, y: 450, width: UIScreen.main.bounds.width - 40, height: 30)
        addArtist.setTitle("Update Artist", for: .normal)
        addArtist.setTitleColor(.black, for: .normal)
        addArtist.addTarget(self, action: #selector(updateArtist), for: .touchUpInside)
        addArtist.backgroundColor = UIColor.green
        addArtist.layer.cornerRadius = 5
        addArtist.layer.borderWidth = 1
        addArtist.layer.borderColor = UIColor.black.cgColor
        artistUpdateView.addSubview(addArtist)
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 500, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        artistUpdateView.addSubview(backButton)
        
        // add the product post view to the window
        window?.addSubview(artistUpdateView)
    }
    
    @objc func updateArtist() {
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
                    if let rootViewController = window?.rootViewController {
                        rootViewController.present(alert, animated: true, completion: nil)
                    }
                    return
                }
              
                // Create a new product post and add it to the productPosts array
                let newArtist = Artist(id: artistId, name: artistName)
                albumManager.updateArtist(artist: newArtist)
                
                let alert = UIAlertController(title: "Artist updated Successfully", message: "Press OK to continue", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
                return
            }
            else{
                // Handle case where product post id is not valid
                let alert = UIAlertController(title: "Error", message: "Artist ID does not exist to update.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            // Handle case where any required field is empty or not a valid integer
            let alert = UIAlertController(title: "Error", message: "One or more fields are empty or contain invalid values.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    // Delete Artist
        @objc func DeleteArtistTapped() {
            // create new view
            let DeleteArtist = UIView(frame: UIScreen.main.bounds)
            DeleteArtist.backgroundColor = .white
    
            // add subviews for each input field
            let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
            idLabel.text = "Artist ID:"
            DeleteArtist.addSubview(idLabel)
    
            ArtistIdField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
            ArtistIdField.borderStyle = .roundedRect
            ArtistIdField.keyboardType = .numberPad  // only accept numeric input
            DeleteArtist.addSubview(ArtistIdField)
    
            // add submit button
            let submitButton = UIButton(type: .system)
            submitButton.frame = CGRect(x: 20, y: 150, width: UIScreen.main.bounds.width - 40, height: 30)
            submitButton.setTitle("Delete Artist", for: .normal)
            submitButton.setTitleColor(.black, for: .normal)
            submitButton.addTarget(self, action: #selector(deleteArtist), for: .touchUpInside)
            submitButton.backgroundColor = UIColor.green
            submitButton.layer.cornerRadius = 5
            submitButton.layer.borderWidth = 1
            submitButton.layer.borderColor = UIColor.black.cgColor
            DeleteArtist.addSubview(submitButton)
    
            // add the go back button
            let backButton = UIButton(type: .system)
            backButton.frame = CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30)
            backButton.setTitle("Go Back", for: .normal)
            backButton.setTitleColor(.black, for: .normal)
            backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
            backButton.backgroundColor = UIColor.systemPink
            backButton.layer.cornerRadius = 5
            backButton.layer.borderWidth = 1
            backButton.layer.borderColor = UIColor.black.cgColor
            DeleteArtist.addSubview(backButton)
    
            // add the product view to the window
            window?.addSubview(DeleteArtist)
        }
    
        @objc func deleteArtist(){
            if let artistIdText = ArtistIdField?.text, let artistDeleteId = Int(artistIdText){
                let artistIDExists = albumManager.artists.contains { $0.id == artistDeleteId }
                if artistIDExists {
                    // Delete the product post from the productPosts array
                    if let artistToDelete = albumManager.artists.first(where: { $0.id == artistDeleteId }) {
                        // Check if the artist has associated albums
                                let hasAlbums = albumManager.albums.contains { $0.artist_id == artistDeleteId }
                                if hasAlbums {
                                    let alert = UIAlertController(title: "Error", message: "Artist has one or more albums Can't delete", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                    if let rootViewController = window?.rootViewController {
                                        rootViewController.present(alert, animated: true, completion: nil)
                                    }
                                    return
                                }
                                
                        albumManager.deleteArtist(artist: artistToDelete)
                        print("Artist deleted successfully!")
                        // Handle case where product post id is deleted
                        let alert = UIAlertController(title: "Success", message: "Artist deleted successfully", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        if let rootViewController = window?.rootViewController {
                            rootViewController.present(alert, animated: true, completion: nil)
                        }
                    }
                } else {
                    // Handle case where product post id is not valid
                    let alert = UIAlertController(title: "Error", message: "Artist ID does not exist to delete.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    if let rootViewController = window?.rootViewController {
                        rootViewController.present(alert, animated: true, completion: nil)
                    }
                }
            } else {
                let alert = UIAlertController(title: "Error", message: "Please enter an ID", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
            }
        }
    
    // All Album Functions
    @objc func manageAlbumsButtonTapped()  {
        // Create a new view to display the options
        let optionsView = UIView(frame: UIScreen.main.bounds)
        optionsView.backgroundColor = .darkGray
        
        // Add a label to display the title
        let titleLabel = UILabel(frame: CGRect(x: 80, y: 50, width: UIScreen.main.bounds.width - 40, height: 30))
        titleLabel.text = "Manage Albums"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        optionsView.addSubview(titleLabel)
        
        // Add a button to add a new album
        let addButton = UIButton(type: .system)
        addButton.frame = CGRect(x: 20, y: 100, width: UIScreen.main.bounds.width - 40, height: 50)
        addButton.setTitle("Add New Album", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .systemBlue
        addButton.layer.cornerRadius = 10
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.black.cgColor
        addButton.addTarget(self, action: #selector(addAlbumsButtonTapped), for: .touchUpInside)
        optionsView.addSubview(addButton)
        
        // Add a button to update an existing album
        let updateButton = UIButton(type: .system)
        updateButton.frame = CGRect(x: 20, y: 170, width: UIScreen.main.bounds.width - 40, height: 50)
        updateButton.setTitle("Update Album", for: .normal)
        updateButton.setTitleColor(.white, for: .normal)
        updateButton.backgroundColor = .systemGreen
        updateButton.layer.cornerRadius = 10
        updateButton.layer.borderWidth = 1
        updateButton.layer.borderColor = UIColor.black.cgColor
        updateButton.addTarget(self, action: #selector(updateAlbumTapped), for: .touchUpInside)
        optionsView.addSubview(updateButton)
        
      //   Add a button to delete an existing album
                let deleteButton = UIButton(type: .system)
                deleteButton.frame = CGRect(x: 20, y: 240, width: UIScreen.main.bounds.width - 40, height: 50)
                deleteButton.setTitle("Delete Album", for: .normal)
                deleteButton.setTitleColor(.white, for: .normal)
                deleteButton.backgroundColor = .systemRed
                deleteButton.layer.cornerRadius = 10
                deleteButton.layer.borderWidth = 1
                deleteButton.layer.borderColor = UIColor.black.cgColor
                deleteButton.addTarget(self, action: #selector(deleteAlbumTapped), for: .touchUpInside)
                optionsView.addSubview(deleteButton)
        
        // Add a button to view all albums
        let viewAllButton = UIButton(type: .system)
        viewAllButton.frame = CGRect(x: 20, y: 310, width: UIScreen.main.bounds.width - 40, height: 50)
        viewAllButton.setTitle("View All Albums", for: .normal)
        viewAllButton.setTitleColor(.white, for: .normal)
        viewAllButton.backgroundColor = .systemOrange
        viewAllButton.layer.cornerRadius = 10
        viewAllButton.layer.borderWidth = 1
        viewAllButton.layer.borderColor = UIColor.black.cgColor
        viewAllButton.addTarget(self, action: #selector(viewAllAlbumsButtonTapped), for: .touchUpInside)
        optionsView.addSubview(viewAllButton)
        
        // Add a "Go Back" button to the view
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        optionsView.addSubview(backButton)
        
        // Add the view to the window
        window?.addSubview(optionsView)
    }
    
    @objc func addAlbumsButtonTapped() {
        // create new view
        let albumView = UIView(frame: UIScreen.main.bounds)
        albumView.backgroundColor = .white
        
        // add subviews for each input field
        let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        idLabel.text = "ID:"
        albumView.addSubview(idLabel)
        
        AlbumIdField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        AlbumIdField.borderStyle = .roundedRect
        AlbumIdField.keyboardType = .numberPad  // only accept numeric input
        albumView.addSubview(AlbumIdField)
        
        // add title for album
        let titleLabel = UILabel(frame: CGRect(x: 20, y: 150, width: 100, height: 30))
        titleLabel.text = "Title:"
        albumView.addSubview(titleLabel)
        
        AlbumNameField = UITextField(frame: CGRect(x: 120, y: 150, width: UIScreen.main.bounds.width - 140, height: 30))
        AlbumNameField.borderStyle = .roundedRect
        albumView.addSubview(AlbumNameField)
        
        //add Album Id
        let artistLabel = UILabel(frame: CGRect(x: 20, y: 200, width: 100, height: 30))
        artistLabel.text = "Artist ID:"
        albumView.addSubview(artistLabel)
        
        AlbumArtistIdField = UITextField(frame: CGRect(x: 120, y: 200, width: UIScreen.main.bounds.width - 140, height: 30))
        AlbumArtistIdField.borderStyle = .roundedRect
        AlbumArtistIdField.keyboardType = .numberPad
        albumView.addSubview(AlbumArtistIdField)
        
        
        // add Date
        let AlbumDateLabel = UILabel(frame: CGRect(x: 20, y: 250, width: 100, height: 30))
        AlbumDateLabel.text = "Date:"
        albumView.addSubview(AlbumDateLabel)
        
        AlbumReleaseDateField = UITextField(frame: CGRect(x: 120, y: 250, width: UIScreen.main.bounds.width - 140, height: 30))
        AlbumReleaseDateField.borderStyle = .roundedRect
        AlbumReleaseDateField.placeholder = "yyyy-mm-dd"
        AlbumReleaseDateField.keyboardType = .numberPad  // only accept numeric input
        albumView.addSubview(AlbumReleaseDateField)
        
        //    add submit button
        let addAlbumButton = UIButton(type: .system)
        addAlbumButton.frame = CGRect(x: 20, y: 400, width: UIScreen.main.bounds.width - 40, height: 30)
        addAlbumButton.setTitle("Add Album", for: .normal)
        addAlbumButton.setTitleColor(.black, for: .normal)
        addAlbumButton.addTarget(self, action: #selector(AddAlbum), for: .touchUpInside)
        addAlbumButton.backgroundColor = UIColor.green
        addAlbumButton.layer.cornerRadius = 5
        addAlbumButton.layer.borderWidth = 1
        addAlbumButton.layer.borderColor = UIColor.black.cgColor
        albumView.addSubview(addAlbumButton)
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 450, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        albumView.addSubview(backButton)
        
        // add the product view to the window
        window?.addSubview(albumView)
    }
    
    @objc func AddAlbum()   {
        print("Add Album button pressed")
        //        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let albumIdText = AlbumIdField?.text, let albumId = Int(albumIdText),
           let albumNameText = AlbumNameField?.text, !albumNameText.isEmpty,
           let albumDateText = AlbumReleaseDateField?.text, !albumDateText.isEmpty,
           let artistIdText = AlbumArtistIdField?.text, let artistId = Int(artistIdText){
            
            // Check if the product post already exists
            let albumIDExists = albumManager.albums.contains { $0.album_id == albumId }
            if albumIDExists {
                let alert = UIAlertController(title: "Error", message: "Album with ID \(albumId) already exists.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
                return
            }

            // Check if the company ID is valid
            if !albumManager.artists.contains(where: { $0.id == artistId }) {
                let alert = UIAlertController(title: "Error", message: "Artist ID \(artistId) is invalid.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
                return
            }
            
            dateFormatter.dateFormat = "yyyy-MM-dd" // Replace with your desired date format
            guard let date = dateFormatter.date(from: albumDateText) else {
                let alert = UIAlertController(title: "Error", message: "Invalid Date Format \(String(describing: albumDateText))", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
                return
            }
            // Create a new product post and add it to the productPosts array
            let newAlbum = Album(album_id: albumId ,artist_id:artistId, title: albumNameText,release_date:date)
            albumManager.addAlbum(album: newAlbum)
            
            let alert = UIAlertController(title: "Album Added Successfully", message: "Press OK to continue", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        } else {
            // Handle case where any required field is empty or not a valid integer
            let alert = UIAlertController(title: "Error", message: "One or more fields are empty or contain invalid values.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    @objc func viewAllAlbumsButtonTapped() {
        let albums = albumManager.viewAllAlbums()
        // Create a new view to display the products
        let allAlbumsView = UIView(frame: UIScreen.main.bounds)
        allAlbumsView.backgroundColor = .systemTeal
        
        if albums.isEmpty {
            // Add a placeholder label if there are no products
            let label = UILabel(frame: CGRect(x: 100, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width - 40, height: 30))
            label.text = "No albums available"
            label.textColor = .black
            allAlbumsView.addSubview(label)
        } else {
            // Add a label for each product
            var yOffset: CGFloat = 50.0 // starting y offset
            for album in albums {
                let idLabel = UILabel(frame: CGRect(x: 20, y: yOffset, width: UIScreen.main.bounds.width - 40, height: 30))
                idLabel.text = "ID: \(album.album_id)"
                idLabel.textColor = .black
                allAlbumsView.addSubview(idLabel)
                
                let nameLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 30.0, width: UIScreen.main.bounds.width - 40, height: 30))
                nameLabel.text = "Title: \(album.title)"
                nameLabel.textColor = .black
                allAlbumsView.addSubview(nameLabel)
                
                let artistIdLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 120.0, width: UIScreen.main.bounds.width - 40, height: 30))
                artistIdLabel.text = "Artist Id: \(album.artist_id)"
                artistIdLabel.textColor = .black
                allAlbumsView.addSubview(artistIdLabel)
                
                let releaseDateLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 140.0, width: UIScreen.main.bounds.width - 40, height: 30))
                releaseDateLabel.text = "Release Date: \(album.release_date)"
                releaseDateLabel.textColor = .black
                allAlbumsView.addSubview(releaseDateLabel)
                
                // Create a background color with rounded edges for each label
                let backgroundColor = UIColor(red: CGFloat.random(in: 0.5...1.0), green: CGFloat.random(in: 0.5...1.0), blue: CGFloat.random(in: 0.5...1.0), alpha: 1.0)
                let labelBackgroundView = UIView(frame: CGRect(x: 0, y: yOffset, width: UIScreen.main.bounds.width, height: 180))
                labelBackgroundView.backgroundColor = backgroundColor
                labelBackgroundView.layer.cornerRadius = 10
                allAlbumsView.insertSubview(labelBackgroundView, belowSubview: idLabel)
                
                yOffset += 200.0 // increment y offset for next label
            }
        }
        
        // Add a "Go Back" button to the view
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        allAlbumsView.addSubview(backButton)
        
        // Add the view to the window
        window?.addSubview(allAlbumsView)
    }
    
    @objc func updateAlbumTapped() {
        // create new view
        let albumView = UIView(frame: UIScreen.main.bounds)
        albumView.backgroundColor = .white
        
        // add subviews for each input field
        let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        idLabel.text = "ID:"
        albumView.addSubview(idLabel)
        
        AlbumIdField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        AlbumIdField.borderStyle = .roundedRect
        AlbumIdField.keyboardType = .numberPad  // only accept numeric input
        albumView.addSubview(AlbumIdField)
        
        // add title for album
        let titleLabel = UILabel(frame: CGRect(x: 20, y: 150, width: 100, height: 30))
        titleLabel.text = "Title:"
        albumView.addSubview(titleLabel)
        
        AlbumNameField = UITextField(frame: CGRect(x: 120, y: 150, width: UIScreen.main.bounds.width - 140, height: 30))
        AlbumNameField.borderStyle = .roundedRect
        albumView.addSubview(AlbumNameField)
        
        //add Album Id
        let artistLabel = UILabel(frame: CGRect(x: 20, y: 200, width: 100, height: 30))
        artistLabel.text = "Artist ID:"
        albumView.addSubview(artistLabel)
        
        AlbumArtistIdField = UITextField(frame: CGRect(x: 120, y: 200, width: UIScreen.main.bounds.width - 140, height: 30))
        AlbumArtistIdField.borderStyle = .roundedRect
        AlbumArtistIdField.keyboardType = .numberPad
        albumView.addSubview(AlbumArtistIdField)
        
        
        // add Date
        let AlbumDateLabel = UILabel(frame: CGRect(x: 20, y: 250, width: 100, height: 30))
        AlbumDateLabel.text = "Date:"
        albumView.addSubview(AlbumDateLabel)
        
        AlbumReleaseDateField = UITextField(frame: CGRect(x: 120, y: 250, width: UIScreen.main.bounds.width - 140, height: 30))
        AlbumReleaseDateField.borderStyle = .roundedRect
        AlbumReleaseDateField.placeholder = "yyyy-mm-dd"
        AlbumReleaseDateField.keyboardType = .numberPad  // only accept numeric input
        albumView.addSubview(AlbumReleaseDateField)
        
        //    add submit button
        let addAlbumButton = UIButton(type: .system)
        addAlbumButton.frame = CGRect(x: 20, y: 400, width: UIScreen.main.bounds.width - 40, height: 30)
        addAlbumButton.setTitle("Update Album", for: .normal)
        addAlbumButton.setTitleColor(.black, for: .normal)
        addAlbumButton.addTarget(self, action: #selector(updateAlbum), for: .touchUpInside)
        addAlbumButton.backgroundColor = UIColor.green
        addAlbumButton.layer.cornerRadius = 5
        addAlbumButton.layer.borderWidth = 1
        addAlbumButton.layer.borderColor = UIColor.black.cgColor
        albumView.addSubview(addAlbumButton)
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 450, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        albumView.addSubview(backButton)
        
        // add the product view to the window
        window?.addSubview(albumView)
    }
    // update albums
    @objc func updateAlbum() {
        print("Update Album button pressed")
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let albumIdText = AlbumIdField?.text, let albumId = Int(albumIdText),
           let albumNameText = AlbumNameField?.text, !albumNameText.isEmpty,
           let albumDateText = AlbumReleaseDateField?.text, !albumDateText.isEmpty,
           let artistIdText = AlbumArtistIdField?.text, let artistId = Int(artistIdText) {
            
            // Check if the album exists
            guard let existingAlbum = albumManager.albums.first(where: { $0.album_id == albumId }) else {
                presentAlert(title: "Error", message: "Album ID \(albumId) does not exist.")
                return
            }
            
            // Validate that the entered artist ID matches the existing album's artist ID
            // and confirm that the artist exists
            if artistId != existingAlbum.artist_id || !albumManager.artists.contains(where: { $0.id == artistId }) {
                presentAlert(title: "Error", message: "Invalid Artist ID provided for this album.")
                return
            }
            
            // Validate the date format
            guard let date = dateFormatter.date(from: albumDateText) else {
                presentAlert(title: "Error", message: "Invalid Date Format: \(albumDateText). Use yyyy-MM-dd.")
                return
            }
            
            let updatedAlbum = Album(album_id: albumId, artist_id: artistId, title: albumNameText, release_date: date)
            albumManager.updateAlbum(album: updatedAlbum)
            presentAlert(title: "Success", message: "Album successfully updated.")
        } else {
            presentAlert(title: "Error", message: "Please ensure all fields are filled correctly and artist ID is valid.")
        }
    }


    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        if let rootViewController = window?.rootViewController {
            rootViewController.present(alert, animated: true, completion: nil)
        }
    }


    // Delete Album
        @objc func deleteAlbumTapped() {
            // create new view
            let DeleteAlbum = UIView(frame: UIScreen.main.bounds)
            DeleteAlbum.backgroundColor = .white
    
            // add subviews for each input field
            let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
            idLabel.text = "Album ID:"
            DeleteAlbum.addSubview(idLabel)
    
            AlbumIdField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
            AlbumIdField.borderStyle = .roundedRect
            AlbumIdField.keyboardType = .numberPad  // only accept numeric input
            DeleteAlbum.addSubview(AlbumIdField)
    
            // add submit button
            let submitButton = UIButton(type: .system)
            submitButton.frame = CGRect(x: 20, y: 150, width: UIScreen.main.bounds.width - 40, height: 30)
            submitButton.setTitle("Delete Album", for: .normal)
            submitButton.setTitleColor(.black, for: .normal)
            submitButton.addTarget(self, action: #selector(deleteAlbum), for: .touchUpInside)
            submitButton.backgroundColor = UIColor.green
            submitButton.layer.cornerRadius = 5
            submitButton.layer.borderWidth = 1
            submitButton.layer.borderColor = UIColor.black.cgColor
            DeleteAlbum.addSubview(submitButton)
    
            // add the go back button
            let backButton = UIButton(type: .system)
            backButton.frame = CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30)
            backButton.setTitle("Go Back", for: .normal)
            backButton.setTitleColor(.black, for: .normal)
            backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
            backButton.backgroundColor = UIColor.systemPink
            backButton.layer.cornerRadius = 5
            backButton.layer.borderWidth = 1
            backButton.layer.borderColor = UIColor.black.cgColor
            DeleteAlbum.addSubview(backButton)
    
            // add the product view to the window
            window?.addSubview(DeleteAlbum)
        }
    
        @objc func deleteAlbum(){
            if let albumIdText = AlbumIdField?.text, let albumDeleteId = Int(albumIdText){
                let albumIDExists = albumManager.albums.contains { $0.album_id == albumDeleteId }
                if albumIDExists {
                    // Delete the product post from the productPosts array
                    if let albumToDelete = albumManager.albums.first(where: { $0.album_id == albumDeleteId }) {
                        // Check if the album has associated songs
                                let hasSongs = albumManager.songs.contains { $0.album_id == albumDeleteId }
                                if hasSongs {
                                    let alert = UIAlertController(title: "Error", message: "Album has one or more songs Can't delete .", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                    if let rootViewController = window?.rootViewController {
                                        rootViewController.present(alert, animated: true, completion: nil)
                                    }
                                    return
                                }
                        
                        albumManager.deleteAlbum(album: albumToDelete)
                        print("Album deleted successfully!")
                        // Handle case where product post id is deleted
                        let alert = UIAlertController(title: "Success", message: "Album deleted successfully", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        if let rootViewController = window?.rootViewController {
                            rootViewController.present(alert, animated: true, completion: nil)
                        }
                    }
                } else {
                    // Handle case where product post id is not valid
                    let alert = UIAlertController(title: "Error", message: "Album ID does not exist to delete.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    if let rootViewController = window?.rootViewController {
                        rootViewController.present(alert, animated: true, completion: nil)
                    }
                }
            } else {
                let alert = UIAlertController(title: "Error", message: "Please enter an ID", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
            }
        }
    
    
    // All Genre Declarations
    @objc func manageGenreButtonTapped() {
        // Create a new view to display the options
        let optionsView = UIView(frame: UIScreen.main.bounds)
        optionsView.backgroundColor = .darkGray
        
        // Add a label to display the title
        let titleLabel = UILabel(frame: CGRect(x: 80, y: 50, width: UIScreen.main.bounds.width - 40, height: 30))
        titleLabel.text = "Manage Genres"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        optionsView.addSubview(titleLabel)
        
        // Add a button to add a new artist
        let addButton = UIButton(type: .system)
        addButton.frame = CGRect(x: 20, y: 100, width: UIScreen.main.bounds.width - 40, height: 50)
        addButton.setTitle("Add New Genre", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .systemBlue
        addButton.layer.cornerRadius = 10
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.black.cgColor
        addButton.addTarget(self, action: #selector(addGenreButtonTapped), for: .touchUpInside)
        optionsView.addSubview(addButton)
        
        // Add a button to update an existing artist
        let updateButton = UIButton(type: .system)
        updateButton.frame = CGRect(x: 20, y: 170, width: UIScreen.main.bounds.width - 40, height: 50)
        updateButton.setTitle("Update Genre", for: .normal)
        updateButton.setTitleColor(.white, for: .normal)
        updateButton.backgroundColor = .systemGreen
        updateButton.layer.cornerRadius = 10
        updateButton.layer.borderWidth = 1
        updateButton.layer.borderColor = UIColor.black.cgColor
        updateButton.addTarget(self, action: #selector(updateGenreTapped), for: .touchUpInside)
        optionsView.addSubview(updateButton)
        
      //   Add a button to delete an existing artist
                let deleteButton = UIButton(type: .system)
                deleteButton.frame = CGRect(x: 20, y: 240, width: UIScreen.main.bounds.width - 40, height: 50)
                deleteButton.setTitle("Delete Genre", for: .normal)
                deleteButton.setTitleColor(.white, for: .normal)
                deleteButton.backgroundColor = .systemRed
                deleteButton.layer.cornerRadius = 10
                deleteButton.layer.borderWidth = 1
                deleteButton.layer.borderColor = UIColor.black.cgColor
                deleteButton.addTarget(self, action: #selector(DeleteGenreTapped), for: .touchUpInside)
                optionsView.addSubview(deleteButton)
        
        // Add a button to view all artists
        let viewAllButton = UIButton(type: .system)
        viewAllButton.frame = CGRect(x: 20, y: 310, width: UIScreen.main.bounds.width - 40, height: 50)
        viewAllButton.setTitle("View All Genre", for: .normal)
        viewAllButton.setTitleColor(.white, for: .normal)
        viewAllButton.backgroundColor = .systemOrange
        viewAllButton.layer.cornerRadius = 10
        viewAllButton.layer.borderWidth = 1
        viewAllButton.layer.borderColor = UIColor.black.cgColor
        viewAllButton.addTarget(self, action: #selector(ViewAllGenreTapped), for: .touchUpInside)
        optionsView.addSubview(viewAllButton)
        
        // Add a "Go Back" button to the view
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        optionsView.addSubview(backButton)
        
        // Add the view to the window
        window?.addSubview(optionsView)
    }
//    
    @objc func addGenreButtonTapped() {
         //create new view
        let GenreView = UIView(frame: UIScreen.main.bounds)
        GenreView.backgroundColor = .white
        
        // add subviews for each input field
        let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        idLabel.text = "Genre ID:"
        GenreView.addSubview(idLabel)
        
        GenreIdField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        GenreIdField.borderStyle = .roundedRect
        GenreIdField.keyboardType = .numberPad  // only accept numeric input
        GenreView.addSubview(GenreIdField)
        
        let GenreNameLabel = UILabel(frame: CGRect(x: 20, y: 150, width: 100, height: 30))
        GenreNameLabel.text = "Genre Name:"
        GenreView.addSubview(GenreNameLabel)
        
        GenreNameField = UITextField(frame: CGRect(x: 120, y: 150, width: UIScreen.main.bounds.width - 140, height: 30))
        GenreNameField.borderStyle = .roundedRect
        GenreView.addSubview(GenreNameField)
        
        // add submit button
        let addGenreButton = UIButton(type: .system)
        addGenreButton.frame = CGRect(x: 20, y: 400, width: UIScreen.main.bounds.width - 40, height: 30)
        addGenreButton.setTitle("Add Genre", for: .normal)
        addGenreButton.setTitleColor(.black, for: .normal)
        addGenreButton.addTarget(self, action: #selector(AddGenre), for: .touchUpInside)
        addGenreButton.backgroundColor = UIColor.green
        addGenreButton.layer.cornerRadius = 5
        addGenreButton.layer.borderWidth = 1
        addGenreButton.layer.borderColor = UIColor.black.cgColor
        GenreView.addSubview(addGenreButton)
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 450, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        GenreView.addSubview(backButton)
        
        // add the product type view to the window
        window?.addSubview(GenreView)
    }
//    
    @objc func AddGenre() {
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
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
                return
            }
            let newGenre = Genre(genre_id: genreId, name: genreName)
            albumManager.addGenre(genre: newGenre)
            let alert = UIAlertController(title: "Genre Added Successfully", message: "Press ok to continue", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        } else {
            // handle case where idField has no text or the text is not a valid integer
            let alert = UIAlertController(title: "Error", message: "Fields are empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
//    
    @objc func ViewAllGenreTapped() {
        print("view all genres pressed")
        let genres = albumManager.viewAllGenres()
        
        // Create a new view to display the artists
        let allGenreView = UIView(frame: UIScreen.main.bounds)
        allGenreView.backgroundColor = .systemTeal
        
        if genres.isEmpty {
            // Add a placeholder label if there are no artists
            let label = UILabel(frame: CGRect(x: 100, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width - 40, height: 30))
            label.text = "No genres available"
            label.textColor = .black
            allGenreView.addSubview(label)
        } else {
            // Add a label for each product post
            var yOffset: CGFloat = 50.0 // starting y offset
            for genre in genres {
                let idLabel = UILabel(frame: CGRect(x: 20, y: yOffset, width: UIScreen.main.bounds.width - 40, height: 30))
                idLabel.text = "Genre ID: \(genre.genre_id)"
                idLabel.textColor = .black
                allGenreView.addSubview(idLabel)
                
                let genreNameLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 30.0, width: UIScreen.main.bounds.width - 40, height: 30))
                genreNameLabel.text = "Genre Name \(genre.name)"
                genreNameLabel.textColor = .black
                allGenreView.addSubview(genreNameLabel)
                
                // Create a background color with rounded edges for each label
                let backgroundColor = UIColor(red: CGFloat.random(in: 0.5...1.0), green: CGFloat.random(in: 0.5...1.0), blue: CGFloat.random(in: 0.5...1.0), alpha: 1.0)
                let labelBackgroundView = UIView(frame: CGRect(x: 0, y: yOffset, width: UIScreen.main.bounds.width, height: 210))
                labelBackgroundView.backgroundColor = backgroundColor
                labelBackgroundView.layer.cornerRadius = 10
                allGenreView.insertSubview(labelBackgroundView, belowSubview: idLabel)
    
                yOffset += 230.0 // increment y offset for next label
            }
        }
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        allGenreView.addSubview(backButton)
        // add the product post view to the window
        window?.addSubview(allGenreView)
    }
    
    @objc func updateGenreTapped() {
        // create new view
        let genreUpdateView = UIView(frame: UIScreen.main.bounds)
        genreUpdateView.backgroundColor = .white
        
        // add subviews for each input field
        let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        idLabel.text = "Genre ID:"
        genreUpdateView.addSubview(idLabel)
        
        GenreIdField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        GenreIdField.borderStyle = .roundedRect
        GenreIdField.keyboardType = .numberPad  // only accept numeric input
        genreUpdateView.addSubview(GenreIdField)
        
        // add subviews for each input field
        let GenreNameLabel = UILabel(frame: CGRect(x: 20, y: 150, width: 100, height: 30))
        GenreNameLabel.text = "Genre Name:"
        genreUpdateView.addSubview(GenreNameLabel)
        
        GenreNameField = UITextField(frame: CGRect(x: 120, y: 150, width: UIScreen.main.bounds.width - 140, height: 30))
        GenreNameField.borderStyle = .roundedRect
        GenreNameField.keyboardType = .numberPad  // only accept numeric input
        genreUpdateView.addSubview(GenreNameField)
        
        
        // add submit button
        let addGenre = UIButton(type: .system)
        addGenre.frame = CGRect(x: 20, y: 450, width: UIScreen.main.bounds.width - 40, height: 30)
        addGenre.setTitle("Update Genre", for: .normal)
        addGenre.setTitleColor(.black, for: .normal)
        addGenre.addTarget(self, action: #selector(updateGenre), for: .touchUpInside)
        addGenre.backgroundColor = UIColor.green
        addGenre.layer.cornerRadius = 5
        addGenre.layer.borderWidth = 1
        addGenre.layer.borderColor = UIColor.black.cgColor
        genreUpdateView.addSubview(addGenre)
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 500, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        genreUpdateView.addSubview(backButton)
        
        // add the product post view to the window
        window?.addSubview(genreUpdateView)
    }
    
    @objc func updateGenre() {
        print("Update Genre button pressed")
        //        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let genreIdText = GenreIdField?.text, let genreId = Int(genreIdText),
           let genreName = GenreNameField?.text, !genreName.isEmpty{
            
            // Check if the artist already exists
            let genreIDExists = albumManager.genres.contains { $0.genre_id == genreId }
            if genreIDExists {
                // Check if the product type ID is valid
                if !albumManager.genres.contains(where: { $0.genre_id == genreId }) {
                    let alert = UIAlertController(title: "Error", message: "Genre ID \(genreId) is invalid.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    if let rootViewController = window?.rootViewController {
                        rootViewController.present(alert, animated: true, completion: nil)
                    }
                    return
                }
              
                // Create a new product post and add it to the productPosts array
                let newGenre = Genre(genre_id: genreId, name: genreName)
                albumManager.updateGenre(genre: newGenre)
                
                let alert = UIAlertController(title: "Genre updated Successfully", message: "Press OK to continue", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
                return
            }
            else{
                // Handle case where product post id is not valid
                let alert = UIAlertController(title: "Error", message: "Genre ID does not exist to update.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            // Handle case where any required field is empty or not a valid integer
            let alert = UIAlertController(title: "Error", message: "One or more fields are empty or contain invalid values.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    // Delete Artist
        @objc func DeleteGenreTapped() {
            // create new view
            let DeleteGenre = UIView(frame: UIScreen.main.bounds)
            DeleteGenre.backgroundColor = .white
    
            // add subviews for each input field
            let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
            idLabel.text = "Genre ID:"
            DeleteGenre.addSubview(idLabel)
    
            GenreIdField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
            GenreIdField.borderStyle = .roundedRect
            GenreIdField.keyboardType = .numberPad  // only accept numeric input
            DeleteGenre.addSubview(GenreIdField)
    
            // add submit button
            let submitButton = UIButton(type: .system)
            submitButton.frame = CGRect(x: 20, y: 150, width: UIScreen.main.bounds.width - 40, height: 30)
            submitButton.setTitle("Delete Genre", for: .normal)
            submitButton.setTitleColor(.black, for: .normal)
            submitButton.addTarget(self, action: #selector(deleteGenre), for: .touchUpInside)
            submitButton.backgroundColor = UIColor.green
            submitButton.layer.cornerRadius = 5
            submitButton.layer.borderWidth = 1
            submitButton.layer.borderColor = UIColor.black.cgColor
            DeleteGenre.addSubview(submitButton)
    
            // add the go back button
            let backButton = UIButton(type: .system)
            backButton.frame = CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30)
            backButton.setTitle("Go Back", for: .normal)
            backButton.setTitleColor(.black, for: .normal)
            backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
            backButton.backgroundColor = UIColor.systemPink
            backButton.layer.cornerRadius = 5
            backButton.layer.borderWidth = 1
            backButton.layer.borderColor = UIColor.black.cgColor
            DeleteGenre.addSubview(backButton)
    
            // add the product view to the window
            window?.addSubview(DeleteGenre)
        }
    
        @objc func deleteGenre(){
            if let genreIdText = GenreIdField?.text, let genreDeleteId = Int(genreIdText){
                let genreIDExists = albumManager.genres.contains { $0.genre_id == genreDeleteId }
                if genreIDExists {
                    // Delete the product post from the productPosts array
                    if let genreToDelete = albumManager.genres.first(where: { $0.genre_id == genreDeleteId }) {
                        
                        // Check if the genre is associated with songs
                                let isAssociatedWithSong = albumManager.songs.contains { $0.genre_id == genreDeleteId }
                                if isAssociatedWithSong {
                                    let alert = UIAlertController(title: "Error", message: "Genre is s associated with one or more Song, cannot delete it", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                    if let rootViewController = window?.rootViewController {
                                        rootViewController.present(alert, animated: true, completion: nil)
                                    }
                                    return
                                }
                        
                        albumManager.deleteGenre(genre: genreToDelete)
                        print("Genre deleted successfully!")
                        // Handle case where product post id is deleted
                        let alert = UIAlertController(title: "Success", message: "Genre deleted successfully", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        if let rootViewController = window?.rootViewController {
                            rootViewController.present(alert, animated: true, completion: nil)
                        }
                    }
                } else {
                    // Handle case where product post id is not valid
                    let alert = UIAlertController(title: "Error", message: "Genre ID does not exist to delete.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    if let rootViewController = window?.rootViewController {
                        rootViewController.present(alert, animated: true, completion: nil)
                    }
                }
            } else {
                let alert = UIAlertController(title: "Error", message: "Please enter an ID", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
            }
        }
    
    
    //  Search Declarations
    @objc func searchButtonTapped() {
        // Create a new view to display the options
        let optionsView = UIView(frame: UIScreen.main.bounds)
        optionsView.backgroundColor = .darkGray
        
        // Add a label to display the title
        let titleLabel = UILabel(frame: CGRect(x: 80, y: 50, width: UIScreen.main.bounds.width - 40, height: 30))
        titleLabel.text = "Select Search Type"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        optionsView.addSubview(titleLabel)
        
        // Add a button to add a new product post
        let ArtistSearch = UIButton(type: .system)
        ArtistSearch.frame = CGRect(x: 20, y: 100, width: UIScreen.main.bounds.width - 40, height: 50)
        ArtistSearch.setTitle("Artist Search", for: .normal)
        ArtistSearch.setTitleColor(.white, for: .normal)
        ArtistSearch.backgroundColor = .systemBlue
        ArtistSearch.layer.cornerRadius = 10
        ArtistSearch.layer.borderWidth = 1
        ArtistSearch.layer.borderColor = UIColor.black.cgColor
        ArtistSearch.addTarget(self, action: #selector(SearchArtistTapped), for: .touchUpInside)
        optionsView.addSubview(ArtistSearch)
        
        // Add a button to update an existing product post
        let AlbumSearch = UIButton(type: .system)
        AlbumSearch.frame = CGRect(x: 20, y: 170, width: UIScreen.main.bounds.width - 40, height: 50)
        AlbumSearch.setTitle("Album search", for: .normal)
        AlbumSearch.setTitleColor(.white, for: .normal)
        AlbumSearch.backgroundColor = .systemGreen
        AlbumSearch.layer.cornerRadius = 10
        AlbumSearch.layer.borderWidth = 1
        AlbumSearch.layer.borderColor = UIColor.black.cgColor
        AlbumSearch.addTarget(self, action: #selector(SearchAlbumTapped), for: .touchUpInside)
        optionsView.addSubview(AlbumSearch)
        
        // Add a button to delete an existing product post
        let GenreSearch = UIButton(type: .system)
        GenreSearch.frame = CGRect(x: 20, y: 240, width: UIScreen.main.bounds.width - 40, height: 50)
        GenreSearch.setTitle("Genre Search", for: .normal)
        GenreSearch.setTitleColor(.white, for: .normal)
        GenreSearch.backgroundColor = .systemRed
        GenreSearch.layer.cornerRadius = 10
        GenreSearch.layer.borderWidth = 1
        GenreSearch.layer.borderColor = UIColor.black.cgColor
        GenreSearch.addTarget(self, action: #selector(SearchGenreTapped), for: .touchUpInside)
        optionsView.addSubview(GenreSearch)
        
        // Add a button to view all product posts
        let SongSearch = UIButton(type: .system)
        SongSearch.frame = CGRect(x: 20, y: 310, width: UIScreen.main.bounds.width - 40, height: 50)
        SongSearch.setTitle("Song Search", for: .normal)
        SongSearch.setTitleColor(.white, for: .normal)
        SongSearch.backgroundColor = .systemOrange
        SongSearch.layer.cornerRadius = 10
        SongSearch.layer.borderWidth = 1
        SongSearch.layer.borderColor = UIColor.black.cgColor
        SongSearch.addTarget(self, action: #selector(SearchSongTapped), for: .touchUpInside)
        optionsView.addSubview(SongSearch)
        
      
        // Add a "Go Back" button to the view
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        optionsView.addSubview(backButton)
        
        // Add the view to the window
        window?.addSubview(optionsView)
    }
    //search artist
    @objc func SearchArtistTapped() {
        let artistSearch = UIView(frame: UIScreen.main.bounds)
        artistSearch.backgroundColor = .white
        
        // Corrected from 'idLabel' to 'nameLabel'
        let nameLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        nameLabel.text = "Name:" // This line was attempting to use 'nameLabel' which wasn't defined in your original code.
        artistSearch.addSubview(nameLabel)
        
        // Removed keyboardType setting to accept text input for names
        ArtistSearchField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        ArtistSearchField.borderStyle = .roundedRect
        artistSearch.addSubview(ArtistSearchField)
        
        let submitButton = UIButton(type: .system)
        submitButton.frame = CGRect(x: 20, y: 150, width: UIScreen.main.bounds.width - 40, height: 30)
        submitButton.setTitle("Search Artist", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.addTarget(self, action: #selector(submitArtistSearch), for: .touchUpInside)
        submitButton.backgroundColor = UIColor.green
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        artistSearch.addSubview(submitButton)
        
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        artistSearch.addSubview(backButton)
        
        window?.addSubview(artistSearch)
    }

    @objc func submitArtistSearch() {
        print("submitArtistSearch button pressed")
        guard let nameText = ArtistSearchField?.text, !nameText.isEmpty else {
            // handle case where nameField is empty
            let alert = UIAlertController(title: "Error", message: "Empty Artist Name Field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true)
            }
            return
        }
        
        // Filter artists by name instead of ID
        let matchedArtists = albumManager.artists.filter { $0.name.lowercased().contains(nameText.lowercased()) }
        guard let artist = matchedArtists.first else {
            // handle case where artist with entered name is not found
            let alert = UIAlertController(title: "Error", message: "Artist with name \"\(nameText)\" not found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true)
            }
            return
        }
        
        // Create a new view to display the artist
        let artistView = UIView(frame: UIScreen.main.bounds)
        artistView.backgroundColor = .systemTeal
        
        var yOffset: CGFloat = 50.0 // starting y offset
        // Add labels for the artist
        let idLabel = UILabel(frame: CGRect(x: 20, y: yOffset, width: UIScreen.main.bounds.width - 40, height: 30))
        idLabel.text = "Artist ID: \(artist.id)"
        idLabel.textColor = .black
        artistView.addSubview(idLabel)
        yOffset += 40 // Increment yOffset for next label
        
        let artistNameLabel = UILabel(frame: CGRect(x: 20, y: yOffset, width: UIScreen.main.bounds.width - 40, height: 30))
        artistNameLabel.text = "Artist Name: \(artist.name)"
        artistNameLabel.textColor = .black
        artistView.addSubview(artistNameLabel)
        // yOffset += 40 // Adjust yOffset as needed for additional content
        
        
        // Create a background color with rounded edges for each label
        let backgroundColor = UIColor(red: CGFloat.random(in: 0.5...1.0), green: CGFloat.random(in: 0.5...1.0), blue: CGFloat.random(in: 0.5...1.0), alpha: 1.0)
        let labelBackgroundView = UIView(frame: CGRect(x: 0, y: yOffset, width: UIScreen.main.bounds.width, height: 220))
        labelBackgroundView.backgroundColor = backgroundColor
        labelBackgroundView.layer.cornerRadius = 10
        artistView.insertSubview(labelBackgroundView, belowSubview: idLabel)
        
        yOffset += 220 // increment y offset for next label
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        artistView.addSubview(backButton)
        
        window?.addSubview(artistView)
    }
    
    
    //search album by name
    @objc func SearchAlbumTapped() {
        // create new view
        let albumSearch = UIView(frame: UIScreen.main.bounds)
        albumSearch.backgroundColor = .white
        
        // Modify here to search by name instead of ID
        let nameLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        nameLabel.text = "Name:"
        albumSearch.addSubview(nameLabel)
        
        AlbumSearchField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        AlbumSearchField.borderStyle = .roundedRect
        albumSearch.addSubview(AlbumSearchField)
        
        // Add submit button
        let submitButton = UIButton(type: .system)
        submitButton.frame = CGRect(x: 20, y: 150, width: UIScreen.main.bounds.width - 40, height: 30)
        submitButton.setTitle("Search Album", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.addTarget(self, action: #selector(submitAlbumSearch), for: .touchUpInside)
        submitButton.backgroundColor = UIColor.green
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        albumSearch.addSubview(submitButton)
        
        // Add go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        albumSearch.addSubview(backButton)
        
        window?.addSubview(albumSearch)
    }
    
    @objc func submitAlbumSearch() {
        print("submitAlbumSearch button pressed")
        guard let nameText = AlbumSearchField?.text, !nameText.isEmpty else {
            // handle case where nameField has no text
            let alert = UIAlertController(title: "Error", message: "Empty Album Name Field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        // Filter albums by name
        let matchedAlbums = albumManager.albums.filter { $0.title.lowercased().contains(nameText.lowercased()) }
        guard let album = matchedAlbums.first else {
            // handle case where album with entered name is not found
            let alert = UIAlertController(title: "Error", message: "Album with this name not found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        // Create a new view to display the album details
        let albumView = UIView(frame: UIScreen.main.bounds)
        albumView.backgroundColor = .systemTeal
        
        var yOffset: CGFloat = 50.0 // starting y offset
        
        // Add labels for the album details
        let idLabel = UILabel(frame: CGRect(x: 20, y: 50, width: UIScreen.main.bounds.width - 40, height: 30))
        idLabel.text = "Album ID: \(album.album_id)"
        idLabel.textColor = .black
        albumView.addSubview(idLabel)
        
        let AlbumNameLabel = UILabel(frame: CGRect(x: 20, y: 80, width: UIScreen.main.bounds.width - 40, height: 30))
        AlbumNameLabel.text = "Album Name: \(album.title)"
        AlbumNameLabel.textColor = .black
        albumView.addSubview(AlbumNameLabel)
        
        let ArtistIdLabel = UILabel(frame: CGRect(x: 20, y: 110, width: UIScreen.main.bounds.width - 40, height: 30))
        ArtistIdLabel.text = "Artist Id: \(album.artist_id)"
        ArtistIdLabel.textColor = .black
        albumView.addSubview(ArtistIdLabel)
        
        let AlbumDateLabel = UILabel(frame: CGRect(x: 20, y: 140, width: UIScreen.main.bounds.width - 40, height: 30))
        AlbumDateLabel.text = "Album Date: \(album.release_date)"
        AlbumDateLabel.textColor = .black
        albumView.addSubview(AlbumDateLabel)
        
        // Create a background color with rounded edges for each label
        let backgroundColor = UIColor(red: CGFloat.random(in: 0.5...1.0), green: CGFloat.random(in: 0.5...1.0), blue: CGFloat.random(in: 0.5...1.0), alpha: 1.0)
        let labelBackgroundView = UIView(frame: CGRect(x: 0, y: yOffset, width: UIScreen.main.bounds.width, height: 220))
        labelBackgroundView.backgroundColor = backgroundColor
        labelBackgroundView.layer.cornerRadius = 10
        albumView.insertSubview(labelBackgroundView, belowSubview: idLabel)
        
        yOffset += 220 // increment y offset for next label
        
        // Add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        albumView.addSubview(backButton)
        
        window?.addSubview(albumView)
    }

    
    // Search Genre
    @objc func SearchGenreTapped() {
        // create new view
        let genreSearch = UIView(frame: UIScreen.main.bounds)
        genreSearch.backgroundColor = .white
        
        // add subviews for each input field
        let nameLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        nameLabel.text = "Name:"
        genreSearch.addSubview(nameLabel)
        
        GenreSearchField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        GenreSearchField.borderStyle = .roundedRect
        genreSearch.addSubview(GenreSearchField)
        
        // add submit button
        let submitButton = UIButton(type: .system)
        submitButton.frame = CGRect(x: 20, y: 150, width: UIScreen.main.bounds.width - 40, height: 30)
        submitButton.setTitle("Search Genre", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.addTarget(self, action: #selector(submitGenreSearch), for: .touchUpInside)
        submitButton.backgroundColor = UIColor.green
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        genreSearch.addSubview(submitButton)
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        genreSearch.addSubview(backButton)
        
        // add the product view to the window
        window?.addSubview(genreSearch)
    }

    @objc func submitGenreSearch() {
        print("submitGenreSearch button pressed")
        guard let nameText = GenreSearchField?.text, !nameText.isEmpty else {
            // handle case where name field is empty
            let alert = UIAlertController(title: "Error", message: "Empty Genre Name Field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        let matchedGenres = albumManager.genres.filter { $0.name.lowercased() == nameText.lowercased() }
        guard let genre = matchedGenres.first else {
            // handle case where genre with entered name is not found
            let alert = UIAlertController(title: "Error", message: "Genre with this name not found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        // Create a new view to display the genre
        let genreView = UIView(frame: UIScreen.main.bounds)
        genreView.backgroundColor = .systemTeal
        
        var yOffset: CGFloat = 50.0 // starting y offset
        // Add labels for the genre
        let idLabel = UILabel(frame: CGRect(x: 20, y: 50, width: UIScreen.main.bounds.width - 40, height: 30))
        idLabel.text = "Genre ID: \(genre.genre_id)"
        idLabel.textColor = .black
        genreView.addSubview(idLabel)
        
        let GenreNameLabel = UILabel(frame: CGRect(x: 20, y: 80, width: UIScreen.main.bounds.width - 40, height: 30))
        GenreNameLabel.text = "Genre Name: \(genre.name)"
        GenreNameLabel.textColor = .black
        genreView.addSubview(GenreNameLabel)
        
        
        // Create a background color with rounded edges for each label
        let backgroundColor = UIColor(red: CGFloat.random(in: 0.5...1.0), green: CGFloat.random(in: 0.5...1.0), blue: CGFloat.random(in: 0.5...1.0), alpha: 1.0)
        let labelBackgroundView = UIView(frame: CGRect(x: 0, y: yOffset, width: UIScreen.main.bounds.width, height: 220))
        labelBackgroundView.backgroundColor = backgroundColor
        labelBackgroundView.layer.cornerRadius = 10
        genreView.insertSubview(labelBackgroundView, belowSubview: idLabel)
        
        yOffset += 220 // increment y offset for next label
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        genreView.addSubview(backButton)
        
        window?.addSubview(genreView)
    }
    
    // Search Song
    @objc func SearchSongTapped() {
        // create new view
        let songSearch = UIView(frame: UIScreen.main.bounds)
        songSearch.backgroundColor = .white
        
        // add subviews for each input field
        let nameLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        nameLabel.text = "Name:"
        songSearch.addSubview(nameLabel)
        
        SongSearchField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        SongSearchField.borderStyle = .roundedRect
        songSearch.addSubview(SongSearchField)
        
        // add submit button
        let submitButton = UIButton(type: .system)
        submitButton.frame = CGRect(x: 20, y: 150, width: UIScreen.main.bounds.width - 40, height: 30)
        submitButton.setTitle("Search Song", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.addTarget(self, action: #selector(submitSongSearch), for: .touchUpInside)
        submitButton.backgroundColor = UIColor.green
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        songSearch.addSubview(submitButton)
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        songSearch.addSubview(backButton)
        
        // add the product view to the window
        window?.addSubview(songSearch)
    }

    @objc func submitSongSearch() {
        print("submitSongSearch button pressed")
        guard let nameText = SongSearchField?.text, !nameText.isEmpty else {
            // handle case where name field is empty
            let alert = UIAlertController(title: "Error", message: "Empty Song Name Field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        let matchedSongs = albumManager.songs.filter { $0.title.lowercased() == nameText.lowercased() }
        guard let song = matchedSongs.first else {
            // handle case where song with entered name is not found
            let alert = UIAlertController(title: "Error", message: "Song with this name not found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        // Create a new view to display the song
        let songView = UIView(frame: UIScreen.main.bounds)
        songView.backgroundColor = .systemTeal
        
        var yOffset: CGFloat = 50.0 // starting y offset
        
        // Add labels for the song
        let idLabel = UILabel(frame: CGRect(x: 20, y: 50, width: UIScreen.main.bounds.width - 40, height: 30))
        idLabel.text = "Song ID: \(song.song_id)"
        idLabel.textColor = .black
        songView.addSubview(idLabel)
        
        let SongNameLabel = UILabel(frame: CGRect(x: 20, y: 80, width: UIScreen.main.bounds.width - 40, height: 30))
        SongNameLabel.text = "Song Name: \(song.title)"
        SongNameLabel.textColor = .black
        songView.addSubview(SongNameLabel)
        
        let ArtistIdLabel = UILabel(frame: CGRect(x: 20, y: 110, width: UIScreen.main.bounds.width - 40, height: 30))
        ArtistIdLabel.text = "Artist Id: \(song.artist_id)"
        ArtistIdLabel.textColor = .black
        songView.addSubview(ArtistIdLabel)
        
        let AlbumIdLabel = UILabel(frame: CGRect(x: 20, y: 140, width: UIScreen.main.bounds.width - 40, height: 30))
        AlbumIdLabel.text = "Album Id: \(song.album_id)"
        AlbumIdLabel.textColor = .black
        songView.addSubview(AlbumIdLabel)
        
        let GenreIdLabel = UILabel(frame: CGRect(x: 20, y: 170, width: UIScreen.main.bounds.width - 40, height: 30))
        GenreIdLabel.text = "Genre Id: \(song.genre_id)"
        GenreIdLabel.textColor = .black
        songView.addSubview(GenreIdLabel)
        
        let SongDurationLabel = UILabel(frame: CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30))
        SongDurationLabel.text = "Song Duration: \(song.duration)"
        SongDurationLabel.textColor = .black
        songView.addSubview(SongDurationLabel)
        
        let FavSongLabel = UILabel(frame: CGRect(x: 20, y: 230, width: UIScreen.main.bounds.width - 40, height: 30))
        FavSongLabel.text = "Favourite Song: \(song.favourite)"
        songView.addSubview(FavSongLabel)
        
        // Create a background color with rounded edges for each label
        let backgroundColor = UIColor(red: CGFloat.random(in: 0.5...1.0), green: CGFloat.random(in: 0.5...1.0), blue: CGFloat.random(in: 0.5...1.0), alpha: 1.0)
        let labelBackgroundView = UIView(frame: CGRect(x: 0, y: yOffset, width: UIScreen.main.bounds.width, height: 220))
        labelBackgroundView.backgroundColor = backgroundColor
        labelBackgroundView.layer.cornerRadius = 10
        songView.insertSubview(labelBackgroundView, belowSubview: idLabel)
        
        yOffset += 220 // increment y offset for next label
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        songView.addSubview(backButton)
        
        window?.addSubview(songView)
    }


    
    
    
    // Go back Functions
    @objc func goBack() {
        // remove the product view or product type view from the window
        if let backButton = window?.subviews.last {
            backButton.removeFromSuperview()
        }
    }
    
    

    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

