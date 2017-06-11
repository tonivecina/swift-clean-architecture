//
//  HomeDataManager.swift
//  CleanArchitecture
//
//  Created by Toni Vecina on 6/11/17.
//  Copyright © 2017 Toni Vecina. All rights reserved.
//

import Foundation

class HomeDataManager {
    lazy fileprivate var notes = [Note]()
    lazy fileprivate var noteCoreDataStorage = NoteCoreDataStorage()
}

extension HomeDataManager {

    func getNotes() -> [Note] {
        do {
            notes = try noteCoreDataStorage.getAll()

        } catch {
            notes = []
        }

        return notes
    }

}
