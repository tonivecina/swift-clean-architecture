//
//  HomeModule.swift
//  CleanArchitecture
//
//  Created by Toni Vecina on 6/11/17.
//  Copyright © 2017 Toni Vecina. All rights reserved.
//

import Foundation

class HomeModule {

    class var view: HomeViewController {
        let view = HomeViewController(nibName: "HomeViewController", bundle: nil)
        view.processor = HomeProcessor(view: view)

        return view
    }
}
