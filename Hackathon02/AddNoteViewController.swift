//
//  AddNoteViewController.swift
//  Hackathon02
//
//  Created by Charlotte Abrams on 9/16/16.
//  Copyright © 2016 Evan Callia. All rights reserved.
//

import Foundation
import UIKit

class AddNoteViewController: UIViewController{
    var cancelButtonDelegate: CancelButtonDelegate?
    var delegate: AddNoteViewControllerDelegate?
    
    @IBOutlet weak var noteInputText: UITextField!
    @IBOutlet weak var itemInputText: UITextField!
    @IBAction func DoneButtonPressed(sender: UIBarButtonItem) {
        delegate?.addNoteViewController(self, didFinishAddingNote: itemInputText.text!, note: noteInputText.text!)
    }
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
}