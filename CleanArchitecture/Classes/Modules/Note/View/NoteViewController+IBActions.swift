//
//  NoteViewController+IBActions.swift
//  CleanArchitecture
//
//  Created by Toni Vecina on 6/11/17.
//  Copyright © 2017 Toni Vecina. All rights reserved.
//

import UIKit

extension NoteViewController {

    @IBAction private func pressCancel(_ sender: UIButton) {
        processor.routes.dismiss()
    }

    @IBAction private func pressSave(_ sender: UIButton) {
        processor.saveNote()
    }
}
