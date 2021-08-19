//
//  TextViewController.swift
//  Notes
//
//  Created by Caleb Danielsen on 17/08/2021.
//

import UIKit

class TextViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    
    var isNew = false
    var isDeleting = false
    var delegate: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !isNew {
            textView.text = delegate?.readText()
        } else {
            navigationItem.rightBarButtonItem = nil
        }
        navigationController?.navigationBar.prefersLargeTitles = false
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func trash(_ sender: UIBarButtonItem) {
        isDeleting = true
        if !isNew { delegate?.deleteText() }
        navigationController?.popViewController(animated: true)
    }
}

// This is really just three "if" conditions compressed into one single nested ternary operation.
extension TextViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) { isDeleting ? isDeleting = false : ( isNew ? ( textView.text.isEmpty ? () : delegate?.createText(text: textView.text) ) : delegate?.updateText(text: textView.text) ) }
}

protocol Task {
    func createText(text: String)
    func updateText(text: String)
    func readText() -> String
    func deleteText()
}


