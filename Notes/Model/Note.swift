//
//  Note.swift
//  Notes
//
//  Created by Caleb Danielsen on 16/08/2021.
//

import UIKit

class Note: NSObject {
    var name: String
    var image: UIImage
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
}
