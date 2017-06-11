//
//  HomeRoutes.swift
//  CleanArchitecture
//
//  Created by Toni Vecina on 6/11/17.
//  Copyright © 2017 Toni Vecina. All rights reserved.
//

import Foundation

class HomeRoutes {

    weak var view: HomeViewController?

    init(view: HomeViewController?) {
        self.view = view
    }
}

extension HomeRoutes {

    func presentNoteModule(note: Note?, delegate: NoteEditingProcess) {
        let noteView = NoteModule.view(note: note, editingDelegate: delegate)
        view?.present(noteView, animated: true, completion: nil)
    }
    
}
