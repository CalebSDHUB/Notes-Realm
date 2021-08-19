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
import RealmSwift

class NoteViewController: UICollectionViewController {
    
    let realm = try! Realm()
    
    var resultNotes: Results<Note>!
    
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { resultNotes.count }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.noteCellIdentifier, for: indexPath) as? NoteCell else { fatalError("Unable to deque PersonCell") }

        cell.textView.text = resultNotes[indexPath.item].text
        
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

    func loadItems() {
        resultNotes = selectedFolder?.notes.sorted(byKeyPath: "date", ascending: true)
        collectionView.reloadData()
    }
}

extension NoteViewController: Task {

    // Adding text to CoreData and saving it.
    func createText(text: String) {
        
        if let currentCategory = selectedFolder {
            do {
                try realm.write {
                    let newNote = Note()
                    newNote.text = text
                    newNote.date = Date()
                    currentCategory.notes.append(newNote)
                }
            } catch {
                print("Error saving a new note: \(error)")
            }
        }
        collectionView.reloadData()
    }

    // Updating text to CoreData and saving it.
    func updateText(text: String) {
        
        do {
            try realm.write {
                resultNotes[index].text = text
            }
        } catch {
            print("Error updating a new note: \(error)")
        }
        collectionView.reloadData()
    }

    // Reading test and return it.
    func readText() -> String { resultNotes[index].text!}

    // Deleting text to CoreData and saving it.
    func deleteText() {
        do {
            try realm.write {
                realm.delete(resultNotes[index])
            }
        } catch {
            print("Error updating a new note: \(error)")
        }
        collectionView.reloadData()
    }
}
