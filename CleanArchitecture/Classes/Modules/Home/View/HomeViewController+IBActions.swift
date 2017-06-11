//
//  HomeViewController+IBActions.swift
//  CleanArchitecture
//
//  Created by Toni Vecina on 6/11/17.
//  Copyright © 2017 Toni Vecina. All rights reserved.
//

import UIKit

extension HomeViewController {

    @IBAction private func pressAdd(_ sender: UIButton) {
        processor.routes.presentNoteModule(note: nil, delegate: processor)
    }
}
