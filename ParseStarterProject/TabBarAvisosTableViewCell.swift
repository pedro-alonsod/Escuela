//
//  TabBarAvisosTableViewCell.swift
//  Escuela
//
//  Created by Pedro Alonso on 14/12/15.
//  Copyright © 2015 Pedro. All rights reserved.
//

import UIKit

class TabBarAvisosTableViewCell: UITableViewCell {

    @IBOutlet weak var titleAvisosCell: UILabel!
    @IBOutlet weak var detailAvisosCell: UILabel!
    @IBOutlet weak var avatarAvisosProfessor: UIImageView!
    
    @IBOutlet weak var maestroLabel: UILabel!
    @IBOutlet weak var grupoLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
