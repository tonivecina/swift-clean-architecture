//
//  NoteModule.swift
//  CleanArchitecture
//
//  Created by Toni Vecina on 6/11/17.
//  Copyright © 2017 Toni Vecina. All rights reserved.
//

import Foundation

class NoteModule {

    class func view(note: Note?, editingDelegate: NoteEditingProcess) -> NoteViewController {
        let view = NoteViewController(nibName: "NoteViewController", bundle: nil)
        view.note = note
        view.processor = NoteProcessor(view: view, noteEditingDelegate: editingDelegate)
        
        return view
    }


    enum Placeholder {
        static let title = "Insert title here"
        static let content = "Insert description here"
    }
}
