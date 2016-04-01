//
//  CalificacionesTableViewCell.swift
//  ParseStarterProject-Swift
//
//  Created by Pedro Alonso on 29/10/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class CalificacionesTableViewCell: UITableViewCell {

    @IBOutlet weak var examenOTareaLabel: UILabel!
    @IBOutlet weak var nombreAlumnoLabel: UILabel!
    @IBOutlet weak var calificacionIconImage: UIImageView!
    @IBOutlet weak var messageCalificaciones: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
