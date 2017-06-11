//
//  HomeProcessor.swift
//  CleanArchitecture
//
//  Created by Toni Vecina on 6/11/17.
//  Copyright © 2017 Toni Vecina. All rights reserved.
//

import Foundation

class HomeProcessor {

    weak var view: HomeViewController?
    lazy fileprivate var dataManager = HomeDataManager()

    var routes: HomeRoutes!

    init(view: HomeViewController?) {
        self.view = view
        self.routes = HomeRoutes(view: self.view)
    }

}

extension HomeProcessor {

    func viewDidLoad() {
        view?.notes = dataManager.getNotes()
        view?.reloadData()
    }
    
}
