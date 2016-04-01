//
//  PrivadosTableViewCell.swift
//  ParseStarterProject-Swift
//
//  Created by Pedro Alonso on 03/11/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class PrivadosTableViewCell: UITableViewCell {

    @IBOutlet weak var tituloPrivadosCell: UILabel!
    @IBOutlet weak var mensajePrivadosCell: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
