//
//  NoteViewController+UITextViews.swift
//  CleanArchitecture
//
//  Created by Toni Vecina on 6/11/17.
//  Copyright © 2017 Toni Vecina. All rights reserved.
//

import UIKit

extension NoteViewController: UITextViewDelegate {

    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }

    func textViewDidBeginEditing(_ textView: UITextView) {

        if textView.text == NoteModule.Placeholder.content {
            textView.text = nil
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {

        if textView.text.isEmpty {
            textView.text = NoteModule.Placeholder.content
            textView.textColor = .lightGray
        }
    }
    
}
