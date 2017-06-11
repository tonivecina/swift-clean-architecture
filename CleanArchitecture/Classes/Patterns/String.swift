//
//  String.swift
//  CleanArchitecture
//
//  Created by Toni Vecina on 6/11/17.
//  Copyright © 2017 Toni Vecina. All rights reserved.
//

import Foundation

extension String {

    static func fromDate(_ date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format

        return formatter.string(from: date)
    }
}
