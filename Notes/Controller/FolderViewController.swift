//
//  ViewController.swift
//  Notes
//
//  Created by Caleb Danielsen on 13/08/2021.
//

import UIKit
import RealmSwift

// FolderViewController is responsible for adding new folders to the main screen and directing user to selected folder.

class FolderViewController: UITableViewController {
    
    let realm = try! Realm()
    
    // We are unwrapping the optional in order to crack the program with purpose.
    var resultFolders: Results<Folder>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Folders"
        
        load()
    }
    
    // This tableView( ... numberOfRowsInSection) and tableView( ... cellForRowAt) is responsible for updating the TableView with the attach array and selected cell.
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        resultFolders.count
    }
    
    // Read the comment for the function just above.
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.folderCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = resultFolders[indexPath.row].name
        
        return cell
    }
    
    // Directs the user to the next screen.
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { performSegue(withIdentifier: Constants.folderSegueIdentifier, sender: self) }
    
    // Prepare data before the user is being directed by segue.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueDestination = segue.destination as! NoteViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            segueDestination.selectedFolder = resultFolders[indexPath.row]
        }
    }
    
    // Add a new folder to the repository.
    
    @IBAction func addFolder(_ sender: UIBarButtonItem) {
        
        var folderName = UITextField()
        
        let ac = UIAlertController(title: "Add Folder", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Ok", style: .default) { [self] _ in
            
            let newFolder = Folder()
            newFolder.name = folderName.text!
            save(newFolder)
        })
        ac.addTextField { (textInput) in
            folderName = textInput
            textInput.placeholder = "Folder name"
        }
        
        present(ac, animated: true)
    }
    
    func save(_ folder: Folder) {
        
        do {
            try realm.write {
                realm.add(folder)
            }
        } catch {
            print("Error saving context: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func load() {
        resultFolders = realm.objects(Folder.self)
        tableView.reloadData()
    }
    
}
