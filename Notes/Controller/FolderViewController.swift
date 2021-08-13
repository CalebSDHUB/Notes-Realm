//
//  ViewController.swift
//  Notes
//
//  Created by Caleb Danielsen on 13/08/2021.
//
// Task:
// 2. add components to the Notes hardcoded.
// 4. add components to the Notes by button and an alert controller
//

import UIKit

// FolderViewController is responsible for adding new folders to the main screen and directing user to selected folder.

class FolderViewController: UITableViewController {
    
    var folders: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    // This tableView( ... numberOfRowsInSection) and tableView( ... cellForRowAt) is responsible for updating the TableView with the attach array and selected cell.
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        folders.count
    }
    
    // Read the comment for the function just above.
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "folderCell", for: indexPath)
        
        cell.textLabel?.text = folders[indexPath.row]
        
        return cell
    }
    
    // Directs the user to the next screen.
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "folderToText", sender: self)
    }
    
    // Prepare data before the user is being directed by segue.

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueDestination = segue.destination as! NoteViewController

        if let indexPath = tableView.indexPathForSelectedRow {

            segueDestination.selectedFolder = folders[indexPath.row]

        }
    }
    
    // Add a new folder to the repository.
    
    @IBAction func addFolder(_ sender: UIBarButtonItem) {
        
        var folderName = UITextField()
        
        let ac = UIAlertController(title: "Add Folder", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default) { [self] _ in
            folders.append(folderName.text!)
            tableView.reloadData()
        })
        ac.addTextField { (textInput) in
            folderName = textInput
            textInput.placeholder = "Folder name"
        }
        
        present(ac, animated: true)
    }
    
}

