//
//  TextViewController.swift
//  Notes
//
//  Created by Caleb Danielsen on 17/08/2021.
//

import UIKit

class TextViewController: UIViewController {

    @IBOutlet var text: UITextView!
    
    var selectedNote: UITextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        text.delegate = self
        
        text.textColor = .placeholderText
        text.becomeFirstResponder()
    }
    
    
}

extension TextViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        text.text = ""
        
    }
    
}
