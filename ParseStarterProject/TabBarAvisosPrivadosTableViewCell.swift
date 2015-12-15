//
//  TabBarAvisosPrivadosTableViewCell.swift
//  Escuela
//
//  Created by Pedro Alonso on 14/12/15.
//  Copyright © 2015 Pedro. All rights reserved.
//

import UIKit

class TabBarAvisosPrivadosTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var someImg: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
