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
        text.becomeFirstResponder()
    }
    
    
}
