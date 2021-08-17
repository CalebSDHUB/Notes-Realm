//
//  TextViewController.swift
//  Notes
//
//  Created by Caleb Danielsen on 13/08/2021.
//

import UIKit

class NoteViewController: UICollectionViewController {
    
    var selectedFolder: String?
    
    var notes = [UITextView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes"
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        notes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.noteCellIdentifier, for: indexPath) as? NoteCell else { fatalError("Unable to deque PersonCell") }
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}
