//
//  main.swift
//  DigitalMusicApplication
//
//  Created by Jerry Reddy on 13/02/24.
//

import Foundation

// Extension for String to read input from console
extension String {
    static func readFromConsole() -> String? {
        return readLine()
    }
}

// User struct to store user information
struct User {
    let email: String
    let password: String
}

// Playlist struct to store playlist information
struct Playlist {
    var name: String
    var songs: [Song]
}

// Song struct to store song information
struct Song {
    var title: String // Title might always be required
    var genre: String? // Now optional, can be nil if deleted
    var favorite: Bool // Assuming favorite status is always specified for simplicity
    var duration: Float? // Now optional, can be nil if deleted
    var uploadedDate: Date? // Now optional, can be nil if deleted
}

// Function to check if an email is from northeastern.edu domain
func isValidNortheasternEmail(_ email: String) -> Bool {
    return email.hasSuffix("@northeastern.edu")
}
// Function to check if a string contains at least one special character
func containsSpecialCharacter(_ string: String) -> Bool {
    let specialCharacterSet = CharacterSet(charactersIn: "!@#$%^&*()-_=+[]{}|;:'\",.<>/?`~")
    return string.rangeOfCharacter(from: specialCharacterSet) != nil
}


// Digital application class
class DigitalApp {
    var users: [User] = []
    var playlists: [Playlist] = []

    // DateFormatter instance
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    // Function to add users
    func addUser(email: String, password: String) {
        let user = User(email: email, password: password)
        users.append(user)
    }
    
    // Function to check user credentials
    func login(email: String, password: String) -> Bool {
        for user in users {
            if user.email == email && user.password == password {
                return true
            }
        }
        return false
    }
    
    // Function to run the application with improved sign-up and login flow
    func run() {
        print("Welcome to the Digital Music Application!")
        var keepRunning = true
        
        while keepRunning {
            print("Do you have an account? (yes/no):")
            if let decision = String.readFromConsole()?.lowercased(), decision == "yes" {
                loginProcess()
            } else {
                var signUpSuccess = false
                while !signUpSuccess {
                    signUpSuccess = signUpProcess()
                    if !signUpSuccess {
                        print("Would you like to try signing up again? (yes/no):")
                        if let tryAgainDecision = String.readFromConsole()?.lowercased(), tryAgainDecision != "yes" {
                            break // Exit the sign-up loop if user doesn't want to try again
                        }
                    }
                }
                if !signUpSuccess {
                    print("Proceeding without signing up. You can view playlists but cannot create or modify them.")
                    // Assume a guest mode here or re-prompt for sign-up/login as needed
                }
            }
            
            if users.isEmpty {
                print("No registered users. Exiting the application.")
                keepRunning = false
            } else {
                mainMenu()
            }
            
            print("Do you want to continue using the application? (yes/no):")
            let decision = String.readFromConsole()?.lowercased()
            if decision != "yes" {
                keepRunning = false
                print("Exiting the Digital Music Application. Goodbye!")
            }
        }
    }

    // Modified signUpProcess to return a Bool indicating success or failure
    func signUpProcess() -> Bool {
        print("Please sign up to start using the application.")
        var isValidEmail = false
        var isValidPassword = false
        
        while !isValidEmail {
            print("Enter your email (must be a @northeastern.edu email):")
            guard let email = String.readFromConsole(), isValidNortheasternEmail(email) else {
                print("Invalid email. Please ensure it is a @northeastern.edu email.")
                continue
            }
            isValidEmail = true
            
            while !isValidPassword {
                print("Enter your password (must contain at least one special character):")
                guard let password = String.readFromConsole(), containsSpecialCharacter(password) else {
                    print("Invalid password. Please ensure it contains at least one special character.")
                    continue
                }
                isValidPassword = true
                
                addUser(email: email, password: password)
                print("User registered successfully.")
                return true
            }
        }
        return false
    }



    
    // Login process
    func loginProcess() {
        print("\nPlease log in to continue.")

        var isLoggedIn = false
        while !isLoggedIn {
            print("Enter your email:")
            guard let loginEmail = String.readFromConsole(), !loginEmail.isEmpty else {
                print("Invalid email.")
                continue
            }
            print("Enter your password:")
            guard let loginPassword = String.readFromConsole(), !loginPassword.isEmpty else {
                print("Invalid password.")
                continue
            }
            
            isLoggedIn = login(email: loginEmail, password: loginPassword)
            
            if isLoggedIn {
                print("Login successful!")
            } else {
                print("Invalid email or password. Please try again.")
            }
        }
    }
    
    // Main menu
    func mainMenu() {
        var isRunning = true
        while isRunning {
            print("\nSelect an option:")
            print("1. Display Playlists")
            print("2. Create a Playlist")
            print("3. Update a Playlist")
            print("4. Delete a Playlist")
            print("5. Manage Playlist")
            print("6. Logout")
            guard let choice = String.readFromConsole(), let option = Int(choice) else {
                print("Invalid input. Please enter a number.")
                continue
            }
            switch option {
            case 1:
                displayPlaylists()
            case 2:
                createPlaylist()
            case 3:
                updatePlaylist()
            case 4:
                deletePlaylist()
            case 5:
                managePlaylist()
            case 6:
                isRunning = false
                print("Logged out successfully.")
            default:
                print("Invalid option.")
            }
        }
    }
    
    // Function to display playlists
    func displayPlaylists() {
            if playlists.isEmpty {
                print("\nNo playlists available.")
            } else {
                for (index, playlist) in playlists.enumerated() {
                    print("\n\(index + 1). \(playlist.name) - \(playlist.songs.count) songs")
                    displaySongsForPlaylist(playlist: playlist)
                }
            }
        }

        // New helper function to display songs for a selected playlist
        func displaySongsForPlaylist(playlist: Playlist) {
            let songsToShow = playlist.songs.prefix(2) // Ensure we show up to the first 2 songs
            if songsToShow.isEmpty {
                print("  No songs in this playlist.")
            } else {
                for song in songsToShow {
                    let songDetails = "  Title: \(song.title), Genre: \(song.genre ?? "N/A"), Favorite: \(song.favorite ? "Yes" : "No"), Duration: \(String(format: "%.2f", song.duration ?? 0)) seconds, Uploaded Date: \(song.uploadedDate != nil ? dateFormatter.string(from: song.uploadedDate!) : "N/A")"
                    print(songDetails)
                }
            }
        }


    
    // Function to create a playlist
    func createPlaylist() {
        print("\nEnter playlist name:")
        guard let playlistName = String.readFromConsole(), !playlistName.isEmpty else {
            print("Invalid playlist name.")
            return
        }
        let playlist = Playlist(name: playlistName, songs: [])
        playlists.append(playlist)
        print("Playlist '\(playlistName)' created successfully!")
    }
    
    // Function to update a playlist
    func updatePlaylist() {
        if playlists.isEmpty {
            print("No playlists available. Please create a playlist first.")
            return
        }
        displayPlaylists()
        print("\nEnter the number of the playlist you want to update:")
        guard let indexStr = String.readFromConsole(), let index = Int(indexStr), index > 0 && index <= playlists.count else {
            print("Invalid playlist number.")
            return
        }
        let playlistIndex = index - 1
        print("Enter new playlist name:")
        guard let newPlaylistName = String.readFromConsole(), !newPlaylistName.isEmpty else {
            print("Invalid playlist name.")
            return
        }
        playlists[playlistIndex].name = newPlaylistName
        print("Playlist updated successfully!")
    }
    
    // Function to delete a playlist
    func deletePlaylist() {
        if playlists.isEmpty {
            print("No playlists available. Please create a playlist first.")
            return
        }
        displayPlaylists()
        print("\nEnter the number of the playlist you want to delete:")
        guard let indexStr = String.readFromConsole(), let index = Int(indexStr), index > 0 && index <= playlists.count else {
            print("Invalid playlist number.")
            return
        }
        let playlistIndex = index - 1
        if !playlists[playlistIndex].songs.isEmpty {
            print("Cannot delete the playlist as it contains songs. Remove songs first.")
        } else {
            let playlistName = playlists[playlistIndex].name
            playlists.remove(at: playlistIndex)
            print("Playlist '\(playlistName)' deleted successfully!")
        }
    }
    
    // Function to manage playlist
    func managePlaylist() {
        if playlists.isEmpty {
            print("No playlists available to manage. Please create a playlist first.")
            return
        }
        displayPlaylists()
        print("\nEnter the number of the playlist you want to manage:")
        guard let indexStr = String.readFromConsole(), let index = Int(indexStr), index > 0 && index <= playlists.count else {
            print("Invalid playlist number.")
            return
        }
        let playlistIndex = index - 1
        
        var isManaging = true
        while isManaging {
            if playlists[playlistIndex].songs.count < 2 {
                print("This playlist has fewer than 2 songs. You need to add more songs to enrich your playlist.")
                for _ in 0..<(2 - playlists[playlistIndex].songs.count) {
                    addSong(toPlaylist: playlistIndex)
                }
                print("\nAdded necessary songs. You currently have \(playlists[playlistIndex].songs.count) song(s) in this playlist.")
            }

            print("\nSelect an option for Playlist '\(playlists[playlistIndex].name)':")
            print("1. Display Songs")
            print("2. Add a Song")
            print("3. Update a Song")
            print("4. Delete a Song")
            print("5. Back to Main Menu")
            guard let choice = String.readFromConsole(), let option = Int(choice) else {
                print("Invalid input. Please enter a number.")
                continue
            }
            switch option {
            case 1:
                displaySongs(inPlaylist: playlistIndex)
            case 2:
                addSong(toPlaylist: playlistIndex)
            case 3:
                updateSong(inPlaylist: playlistIndex)
            case 4:
                deleteSong(fromPlaylist: playlistIndex)
            case 5:
                isManaging = false
            default:
                print("Invalid option.")
            }
        }
    }

    // Function to display songs in a playlist
    func displaySongs(inPlaylist playlistIndex: Int) {
        let playlist = playlists[playlistIndex]
        if playlist.songs.isEmpty {
            print("\nNo songs in Playlist '\(playlist.name)'.")
        } else {
            print("\nSongs in Playlist '\(playlist.name)':")
            for (index, song) in playlist.songs.enumerated() {
                var details = ["\(index + 1)."]
                
                let isTitleUnknown = song.title.lowercased() == "unknown"
                let isGenreReset = song.genre == nil || song.genre?.lowercased() == "unknown"
                let isDurationReset = song.duration == nil
                let isUploadedDateReset = song.uploadedDate == nil
                let isFavoriteReset = !song.favorite // Assuming reset means not favorite
                
                // Check if all fields are in their reset state
                if isTitleUnknown && isGenreReset && isDurationReset && isUploadedDateReset && isFavoriteReset {
                    details.append(" Song information reset")
                } else {
                    // Append details conditionally
                    if !isTitleUnknown {
                        details.append(song.title)
                    }
                    if let genre = song.genre, !isGenreReset {
                        details.append("- \(genre)")
                    }
                    if let duration = song.duration {
                        details.append("- \(duration) seconds")
                    }
                    if let uploadedDate = song.uploadedDate {
                        let dateString = dateFormatter.string(from: uploadedDate)
                        details.append("- Uploaded on \(dateString)")
                    }
                    if song.favorite {
                        details.append("(Favorite)")
                    }
                }
                
                print(details.joined(separator: " "))
            }
        }
    }



    
    // Function to add a song to a playlist
    func addSong(toPlaylist playlistIndex: Int) {
        print("\nEnter song title:")
        guard let title = String.readFromConsole(), !title.isEmpty else {
            print("Invalid title.")
            return
        }
        print("Enter genre (or 'Unknown' if not specified):")
        let genre = String.readFromConsole() ?? "Unknown"
        print("Is this song a favorite? (true/false):")
        guard let favoriteStr = String.readFromConsole(), let favorite = Bool(favoriteStr) else {
            print("Invalid input for favorite. Assuming false.")
            return
        }
        print("Enter duration (in seconds):")
        guard let durationStr = String.readFromConsole(), let duration = Float(durationStr) else {
            print("Invalid duration. Assuming 0.")
            return
        }
        print("Enter uploaded date (YYYY-MM-DD):")
        guard let dateString = String.readFromConsole(), let uploadedDate = dateFormatter.date(from: dateString) else {
            print("Invalid date format. Assuming current date.")
            return
        }
        let song = Song(title: title, genre: genre, favorite: favorite, duration: duration, uploadedDate: uploadedDate)
        playlists[playlistIndex].songs.append(song)
        print("Song '\(title)' added to the playlist.")
    }
    
    // Function to update a song in a playlist
    // Function to update a song in a playlist - Enhanced for clearer handling of information updates
    // Function enhanced to select a song and display detailed information
        func selectAndDisplaySongDetails(fromPlaylist playlistIndex: Int) {
            print("Select a song to view details:")
            displaySongs(inPlaylist: playlistIndex)
            guard let songIndex = Int(String.readFromConsole() ?? ""), songIndex > 0, songIndex <= playlists[playlistIndex].songs.count else {
                print("Invalid song selection.")
                return
            }
            let song = playlists[playlistIndex].songs[songIndex - 1]
            print("Song Details:\nTitle: \(song.title)\nGenre: \(song.genre ?? "N/A")\nFavorite: \(song.favorite)\nDuration: \(song.duration ?? 0) seconds\nUploaded Date: \(dateFormatter.string(from: song.uploadedDate ?? Date()))")
        }

        // Enhanced function to update any information of the song
        // Now allows deleting (resetting) specific information
        func updateSong(inPlaylist playlistIndex: Int) {
            displaySongs(inPlaylist: playlistIndex)
            print("Select a song to update:")
            guard let songIndex = Int(String.readFromConsole() ?? ""), songIndex > 0, songIndex <= playlists[playlistIndex].songs.count else {
                print("Invalid song selection.")
                return
            }
            let selectedSongIndex = songIndex - 1
            var song = playlists[playlistIndex].songs[selectedSongIndex]

            print("Updating song: \(song.title). Enter new details or press enter to skip.")

            // Update Title
            print("Title (\(song.title)): ")
            if let titleInput = String.readFromConsole(), !titleInput.isEmpty {
                song.title = titleInput
            }

            // Update Genre
            print("Genre (\(song.genre ?? "N/A")): (Enter 'none' to remove)")
            let genreInput = String.readFromConsole()
            if genreInput?.lowercased() == "none" {
                song.genre = nil
            } else if let genre = genreInput, !genre.isEmpty {
                song.genre = genre
            }

            // Update Favorite
            print("Favorite (\(song.favorite ? "Yes" : "No")): (true/false)")
            if let favoriteInput = String.readFromConsole(), let favorite = Bool(favoriteInput) {
                song.favorite = favorite
            }

            // Update Duration
            print("Duration (\(String(describing: song.duration))): (Enter 'none' to remove)")
            let durationInput = String.readFromConsole()
            if durationInput?.lowercased() == "none" {
                song.duration = nil
            } else if let duration = Float(durationInput ?? ""), !durationInput!.isEmpty {
                song.duration = duration
            }

            // Update Uploaded Date
            print("Uploaded Date (\(dateFormatter.string(from: song.uploadedDate ?? Date()))): (YYYY-MM-DD or 'none' to remove)")
            let dateInput = String.readFromConsole()
            if dateInput?.lowercased() == "none" {
                song.uploadedDate = nil
            } else if let dateStr = dateInput, let date = dateFormatter.date(from: dateStr) {
                song.uploadedDate = date
            }

            playlists[playlistIndex].songs[selectedSongIndex] = song
            print("Song updated successfully.")
        }


    // Function to delete a song from a playlist
    func deleteSong(fromPlaylist playlistIndex: Int) {
        displaySongs(inPlaylist: playlistIndex)
        if playlists[playlistIndex].songs.isEmpty {
            print("No songs available to delete.")
            return
        }
        print("\nEnter the number of the song you want to delete:")
        guard let indexStr = String.readFromConsole(), let index = Int(indexStr), index > 0 && index <= playlists[playlistIndex].songs.count else {
            print("Invalid song number.")
            return
        }
        let songIndex = index - 1
        let song = playlists[playlistIndex].songs[songIndex]
        if song.favorite {
            print("Cannot delete a favorite song.")
        } else {
            playlists[playlistIndex].songs.remove(at: songIndex)
            print("Song '\(song.title)' deleted successfully!")
        }
    }
}


// Main function to run the digital application
func main() {
    let digitalApp = DigitalApp()
    digitalApp.run()
}

// Call the main function to start the application
main()
