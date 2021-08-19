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
    
    var index: Int = 0
    
    // Will be invoked when the Category is being initiated. So the value is stored ASAP.
    var selectedFolder: Folder? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = selectedFolder?.name
    }
    
    override func viewDidDisappear(_ animated: Bool) { collectionView.reloadData() }

    @IBAction func addNote(_ sender: UIBarButtonItem) { performSegue(withIdentifier: Constants.noteSegueIdentifier, sender: self) }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { notes.count }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.noteCellIdentifier, for: indexPath) as? NoteCell else { fatalError("Unable to deque PersonCell") }

        cell.textView.text = notes[indexPath.item].text
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.noteSegueIdentifier, sender: self)
    }

    // Prepare data before the user is being directed by segue.

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let segueDestination = segue.destination as! TextViewController
        
        // If the IB add Button is used, the indexPath is empty because there is no indexPath.
        if let indexPath = collectionView.indexPathsForSelectedItems {
            if indexPath.isEmpty {
                segueDestination.isNew = true
            } else {
                index = indexPath.first!.item
                segueDestination.isNew = false
            }
        }
        segueDestination.delegate = self
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
        
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        do {
            notes = try Constants.context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}

extension NoteViewController: Task {
    
    // Adding text to CoreData and saving it.
    func createText(text: String) {
        let newNote = Note(context: Constants.context)
        newNote.parentFolder = selectedFolder
        newNote.text = text
        newNote.date = Date()
        notes.append(newNote)
        saveItems()
    }
    
    // Updating text to CoreData and saving it.
    func updateText(text: String) {
        notes[index].text = text
        saveItems()
    }
    
    // Reading test and return it.
    func readText() -> String { notes[index].text!}
    
    // Deleting text to CoreData and saving it.
    func deleteText() {
        Constants.context.delete(notes[index])
        notes.remove(at: index)
        saveItems()
    }
}
