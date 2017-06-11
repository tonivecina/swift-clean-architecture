//
//  HomeViewController.swift
//  CleanArchitecture
//
//  Created by Toni Vecina on 6/11/17.
//  Copyright © 2017 Toni Vecina. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak fileprivate var notesTableView: UITableView!

    var processor: HomeProcessor!
    var notes = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()

        notesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        notesTableView.dataSource = self
        notesTableView.delegate = self

        processor.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension HomeViewController {

    func reloadData() {
        notesTableView.reloadData()
    }

    func addNote(_ note: Note) {
        notes.insert(note, at: 0)
        reloadData()
    }

    func setNote(_ note: Note, at index: Int) {
        notes[index] = note
        reloadData()
    }
}
