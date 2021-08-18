//
//  ViewController.swift
//  Notes
//
//  Created by Caleb Danielsen on 13/08/2021.
//
// Task:
//

import UIKit
import CoreData

// FolderViewController is responsible for adding new folders to the main screen and directing user to selected folder.

class FolderViewController: UITableViewController {
    
    var folders = [Folder]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Folders"
        loadItems()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }

    // This tableView( ... numberOfRowsInSection) and tableView( ... cellForRowAt) is responsible for updating the TableView with the attach array and selected cell.

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        folders.count
    }

    // Read the comment for the function just above.

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.folderCellIdentifier, for: indexPath)

        cell.textLabel?.text = folders[indexPath.row].name

        return cell
    }

    // Directs the user to the next screen.

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.folderSegueIdentifier, sender: self)
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
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(UIAlertAction(title: "Ok", style: .default) { [self] _ in
            
            let newFolder = Folder(context: Constants.context)
            newFolder.name = folderName.text!
            folders.append(newFolder)
            
            saveItems()
        })
        ac.addTextField { (textInput) in
            folderName = textInput
            textInput.placeholder = "Folder name"
        }

        present(ac, animated: true)
    }
    
    func saveItems() {

        do {
            try Constants.context.save()
        } catch {
            print("Error saving context: \(error)")
        }

        tableView.reloadData()
    }

    func loadItems() {
        let request: NSFetchRequest<Folder> = Folder.fetchRequest()

        do {
            folders = try Constants.context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }

    }
    
}

