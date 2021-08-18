//
//  TextViewController.swift
//  Notes
//
//  Created by Caleb Danielsen on 13/08/2021.
//
// IB Modifications:
//
// ContentView:
// 1. User interaction enabled is disabled
// 2. Multi touch is disabled

import UIKit
import CoreData

class NoteViewController: UICollectionViewController {
    
    var notes = [Note]()
    
    // Will be invoked when the Category is being initiated. So the value is stored ASAP.
    var selectedFolder: Folder? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = selectedFolder?.name
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        collectionView.reloadData()
    }

    @IBAction func addNote(_ sender: UIBarButtonItem) {
        
        let newNote = Note(context: Constants.context)
        newNote.parentFolder = selectedFolder
        notes.append(newNote)
        saveItems()
        performSegue(withIdentifier: Constants.noteSegueIdentifier, sender: self)
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        notes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.noteCellIdentifier, for: indexPath) as? NoteCell else { fatalError("Unable to deque PersonCell") }
        
        cell.backgroundColor = .blue
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.noteSegueIdentifier, sender: self)
    }

    // Prepare data before the user is being directed by segue.

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let segueDestination = segue.destination as! TextViewController
        
        // If the IB Button is used the indexPath is empty because no reference is chosen.
        if let indexPath = collectionView.indexPathsForSelectedItems {
            if indexPath.isEmpty {
                segueDestination.selectedNote = notes.first
            } else {
                segueDestination.selectedNote = notes[indexPath.first!.item]
            }
        }
    }
    
    func saveItems() {

        do {
            try Constants.context.save()
        } catch {
            print("Error saving context: \(error)")
        }

        collectionView.reloadData()
    }

    func loadItems() {
        
        let request: NSFetchRequest<Note> = Note.fetchRequest()

        request.predicate = NSPredicate(format: "parentFolder.name MATCHES %@", selectedFolder!.name!)
        
//        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        do {
            notes = try Constants.context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }

    }
    
    
}
