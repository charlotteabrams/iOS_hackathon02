//
//  MapViewControllerDelegate.swift
//  Hackathon02
//
//  Created by Charlotte Abrams on 9/16/16.
//  Copyright © 2016 Evan Callia. All rights reserved.
//

import Foundation
import UIKit

protocol MapViewControllerDelegate: class {
    func mapViewController(controller: UIViewController, didPressAddButton location: Location)
}