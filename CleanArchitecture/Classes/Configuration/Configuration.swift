//
//  Configuration.swift
//  CleanArchitecture
//
//  Created by Toni Vecina on 6/11/17.
//  Copyright © 2017 Toni Vecina. All rights reserved.
//

import Foundation

class Configuration {

    static let get = Configuration()

    var session = UUID() {
        didSet {
            debugPrint("Session \(session.uuidString) initialized.")
        }
    }

    private init() {}
}
