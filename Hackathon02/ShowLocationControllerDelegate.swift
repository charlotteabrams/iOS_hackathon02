//
//  ShowLocationControllerDelegate.swift
//  Hackathon02
//
//  Created by Charlotte Abrams on 9/16/16.
//  Copyright © 2016 Evan Callia. All rights reserved.
//

import Foundation
import UIKit

protocol ShowLocationControllerDelegate: class {
    func showLocationController(controller: ShowLocationController, didFinishAddingNote note: Note)
}
