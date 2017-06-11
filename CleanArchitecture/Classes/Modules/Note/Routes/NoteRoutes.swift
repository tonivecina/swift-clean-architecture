//
//  NoteRoutes.swift
//  CleanArchitecture
//
//  Created by Toni Vecina on 6/11/17.
//  Copyright © 2017 Toni Vecina. All rights reserved.
//

import Foundation

class NoteRoutes {

    weak fileprivate var view: NoteViewController?
    fileprivate var processor: NoteProcessor

    init(view: NoteViewController?, processor: NoteProcessor) {
        self.view = view
        self.processor = processor
    }
}

extension NoteRoutes {

    func dismiss() {
        processor.noteEditingDelegate.noteEditingCanceled()
        view?.dismiss(animated: true, completion: nil)
    }

    func dismiss(note: Note) {
        processor.noteEditingDelegate.noteEditingSuccess(note: note)
        view?.dismiss(animated: true, completion: nil)
    }
}
