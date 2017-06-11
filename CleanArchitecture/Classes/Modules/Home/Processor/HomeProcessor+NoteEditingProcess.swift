//
//  HomeProcessor+NoteEditingProcess.swift
//  CleanArchitecture
//
//  Created by Toni Vecina on 6/11/17.
//  Copyright © 2017 Toni Vecina. All rights reserved.
//

extension HomeProcessor: NoteEditingProcess {

    func noteEditingCanceled() {}

    func noteEditingSuccess(note: Note) {

        guard let index = view?.notes.index(where: { (noteInArray) -> Bool in
            noteInArray.objectID == note.objectID
        }) else {
            view?.addNote(note)

            return
        }

        view?.setNote(note, at: index.hashValue)
    }
}
