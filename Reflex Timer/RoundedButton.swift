
//
//  Rounded Button.swift
//  Reflex Timer
//
//  Created by Henry Goodwin on 23/06/2016.
//  Copyright © 2016 Henry Goodwin. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        
    }
}
