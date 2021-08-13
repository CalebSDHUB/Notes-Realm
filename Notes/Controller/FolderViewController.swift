//
//  ViewController.swift
//  Notes
//
//  Created by Caleb Danielsen on 13/08/2021.
//
// Task:
// 1. add components to the Folders hardcoded.
// 2. add components to the Notes hardcoded.
// 3. add components to the Folders by button and an alert controller
// 4. add components to the Notes by button and an alert controller
//

import UIKit

class FolderViewController: UITableViewController {
    
    let folders = ["Personal", "Work", "Hoppy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        folders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "folderCell", for: indexPath)
        
        cell.textLabel?.text = folders[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "folderToText", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueDestination = segue.destination as! NoteViewController

        if let indexPath = tableView.indexPathForSelectedRow {

            segueDestination.selectedFolder = folders[indexPath.row]

        }
    }


}

