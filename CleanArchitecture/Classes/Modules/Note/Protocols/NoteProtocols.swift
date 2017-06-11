//
//  NoteProtocols.swift
//  CleanArchitecture
//
//  Created by Toni Vecina on 6/11/17.
//  Copyright © 2017 Toni Vecina. All rights reserved.
//

protocol NoteEditingProcess {
    func noteEditingCanceled()
    func noteEditingSuccess(note: Note)
}
