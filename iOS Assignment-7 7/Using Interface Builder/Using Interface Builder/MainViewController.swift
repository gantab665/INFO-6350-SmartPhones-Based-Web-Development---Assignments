//
//  MainViewController.swift
//  Interface Builder
//  Created by Jerry Reddy on 29/02/24.

//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ManageGenresButtonTapped(_ sender: UIButton) {
        let vc = ManageGenresViewController(nibName: "ManageGenresView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func ManageArtistsButtonTapped(_ sender: UIButton) {
        let vc = ManageArtistsViewController(nibName: "ManageArtistsView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func ManageAlbumsButtonTapped(_ sender: UIButton) {
        let vc = ManageAlbumsViewController(nibName: "ManageAlbumsView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func ManageSongsButtonTapped(_ sender: UIButton) {
        let vc = ManageSongsViewController(nibName: "ManageSongsView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func ManageSearchButtonTapped(_ sender: UIButton) {
        let vc = SearchViewController(nibName: "SearchView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
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
