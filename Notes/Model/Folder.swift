//
//  Folder.swift
//  Notes
//
//  Created by Caleb Danielsen on 19/08/2021.
//

import RealmSwift

class Folder: Object {
    @objc dynamic var name: String?
    // One to many relationship
    let notes = List<Note>()
}
