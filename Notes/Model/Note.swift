//
//  Note.swift
//  Notes
//
//  Created by Caleb Danielsen on 19/08/2021.
//

import RealmSwift

class Note: Object {
    @objc dynamic var text: String?
    @objc dynamic var date: Date?
    // Auto-updating container
    var parentCategory = LinkingObjects(fromType: Folder.self, property: "notes")

}
