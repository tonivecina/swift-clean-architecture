//
//  NoteCoreDataManager.swift
//  CleanArchitecture
//
//  Created by Toni Vecina on 6/11/17.
//  Copyright © 2017 Toni Vecina. All rights reserved.
//

import Foundation

class NoteCoreDataStorage {

    fileprivate lazy var coreDataStorage = CoreDataStorage()

    fileprivate func save() throws {
        try coreDataStorage.save()
    }
    
}

extension NoteCoreDataStorage {

    func getAll() throws -> [Note] {
        return try coreDataStorage.fetchResults(Note.self) as [Note]
    }

    func insert(title: String, content: String?) throws -> Note {
        let now = Date()

        let note = try coreDataStorage.newEntity(Note.self) as Note
        note.title = title
        note.content = content
        note.createdAt = now
        note.modifiedAt = now

        try coreDataStorage.save()

        return note
    }

    func save(_ note: Note, title: String, content: String?) throws -> Note {
        note.title = title
        note.content = content
        note.modifiedAt = Date()

        try coreDataStorage.save()

        return note
    }

}
