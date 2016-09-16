//
//  AddNoteViewControllerDelegate.swift
//  Hackathon02
//
//  Created by Charlotte Abrams on 9/16/16.
//  Copyright © 2016 Evan Callia. All rights reserved.
//

import UIKit

protocol AddNoteViewControllerDelegate: class {
    func addNoteViewController(controller: AddNoteViewController, didFinishAddingNote item: String, note: String)
    
}