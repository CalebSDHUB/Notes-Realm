//
//  TextViewController.swift
//  Notes
//
//  Created by Caleb Danielsen on 17/08/2021.
//

import UIKit
import CoreData

class TextViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    
    var selectedNote: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard var text = selectedNote?.text else { fatalError("Error: Note empty") }
        text = textView.text
        print("Prepare works!")
    }
}


