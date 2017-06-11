//
//  NoteDataManager.swift
//  CleanArchitecture
//
//  Created by Toni Vecina on 6/11/17.
//  Copyright © 2017 Toni Vecina. All rights reserved.
//

import Foundation

class NoteDataManager {

    lazy fileprivate var noteCoreDataStorage = NoteCoreDataStorage()

}

extension NoteDataManager {

    func save(title: String, content: String?) throws -> Note {
        return try noteCoreDataStorage.insert(title: title, content: content)
    }

    func save(_ note: Note, title: String, content: String?) throws -> Note {
        return try noteCoreDataStorage.save(note, title: title, content: content)
    }

}
