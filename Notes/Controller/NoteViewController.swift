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
        
        test()
    }
    
    func test() {
        
        for _ in 0..<10 {
            notes.append(UITextView())
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        notes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.noteCellIdentifier, for: indexPath) as? NoteCell else { fatalError("Unable to deque PersonCell") }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.noteSegueIdentifier, sender: self)
    }

    // Prepare data before the user is being directed by segue.

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        let segueDestination = segue.destination as! TextViewController

        if let indexPath = collectionView.indexPathsForSelectedItems {

            segueDestination.selectedFolder = notes[indexPath[0].item]
        }
    }
}
