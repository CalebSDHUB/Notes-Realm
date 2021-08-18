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
    
    var isNewText = false
    
    var selectedNote: Note?
    
    var delegate: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = false
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension TextViewController: UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) { isNewText ? delegate?.addText(text: textView.text) : delegate?.updateText(text: textView.text) }
}

protocol Task {
    func addText(text: String)
    func updateText(text: String)
}


