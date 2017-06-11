//
//  NoteViewController.swift
//  CleanArchitecture
//
//  Created by Toni Vecina on 6/11/17.
//  Copyright © 2017 Toni Vecina. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {

    @IBOutlet weak fileprivate var titleTextField: UITextField!
    @IBOutlet weak fileprivate var contentTextView: UITextView!

    var note: Note?
    var processor: NoteProcessor!

    var isNoteEditing: Bool {
        return note != nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        processor.viewDidLoad()

        titleTextField.text = note?.title
        titleTextField.delegate = self

        contentTextView.text = note?.content
        contentTextView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        view.endEditing(true)
    }

}

extension NoteViewController {

    var noteTitle: String? {
        return titleTextField.text
    }

    var noteContent: String? {
        let text = contentTextView.text

        guard text != NoteModule.Placeholder.content else {
            return nil
        }

        return text
    }
}
