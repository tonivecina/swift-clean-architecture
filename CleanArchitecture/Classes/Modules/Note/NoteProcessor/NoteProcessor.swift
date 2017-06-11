//
//  NoteProcessor.swift
//  CleanArchitecture
//
//  Created by Toni Vecina on 6/11/17.
//  Copyright © 2017 Toni Vecina. All rights reserved.
//

import Foundation

class NoteProcessor {

    weak fileprivate var view: NoteViewController?

    lazy fileprivate var dataManager = NoteDataManager()

    var routes: NoteRoutes!

    var noteEditingDelegate: NoteEditingProcess!

    init(view: NoteViewController?, noteEditingDelegate: NoteEditingProcess) {
        self.view = view
        self.routes = NoteRoutes(view: self.view, processor: self)
        self.noteEditingDelegate = noteEditingDelegate
    }
}

extension NoteProcessor {

    func viewDidLoad() {}
}

extension NoteProcessor {

    func saveNote() {

        guard let title = view?.noteTitle, title.characters.count > 0 else {
            return
        }

        do {

            let content = view?.noteContent

            guard let note = view?.note else {
                let note = try dataManager.save(title: title, content: content)

                return routes.dismiss(note: note)
            }

            let noteStored = try dataManager.save(note, title: title, content: content)
            routes.dismiss(note: noteStored)

        } catch {
            return
        }
    }
}
