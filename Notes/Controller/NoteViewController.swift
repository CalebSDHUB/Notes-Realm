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

class NoteViewController: UICollectionViewController {
    
    var selectedFolder: String?
    
    var notes = [UITextView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes"
        
//        test()
    }
    
    func test() {
        
        for _ in 0..<10 {
            notes.append(UITextView())
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        collectionView.reloadData()
    }

    @IBAction func addNote(_ sender: UIBarButtonItem) {
        notes.append(UITextView())
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
}
