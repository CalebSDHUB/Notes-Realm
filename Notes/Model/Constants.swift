//
//  Contanst.swift
//  Notes
//
//  Created by Caleb Danielsen on 13/08/2021.
//

import UIKit

struct Constants {
    static let folderCellIdentifier = "folderCell"
    static let folderSegueIdentifier = "foldersToNotes"
    static let noteCellIdentifier = "noteCell"
    static let noteSegueIdentifier = "NotesToText"
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}
