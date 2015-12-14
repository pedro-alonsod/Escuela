//
//  TabBarTareasTableViewCell.swift
//  Escuela
//
//  Created by Pedro Alonso on 10/12/15.
//  Copyright © 2015 Pedro. All rights reserved.
//

import UIKit

class TabBarTareasTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var avatarAlumno: UIImageView!
    @IBOutlet weak var materiaLabel: UILabel!
    @IBOutlet weak var fechaLabel: UILabel!
    @IBOutlet weak var tareaDescripcionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
