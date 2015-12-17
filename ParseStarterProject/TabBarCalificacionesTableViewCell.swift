//
//  TabBarCalificacionesTableViewCell.swift
//  Escuela
//
//  Created by Pedro Alonso on 16/12/15.
//  Copyright © 2015 Pedro. All rights reserved.
//

import UIKit

class TabBarCalificacionesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var materiaLabel: UILabel!
    @IBOutlet weak var mensajeLabel: UILabel!
    @IBOutlet weak var calificacionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
