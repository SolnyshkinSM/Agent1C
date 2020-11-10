//
//  ClientTableViewCell.swift
//  Agent1C
//
//  Created by Administrator on 06.11.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import UIKit

class ClientTableViewCell: UITableViewCell {

    @IBOutlet var imageClient: UIImageView!
    @IBOutlet var nameClient: UILabel!
    @IBOutlet var innClient: UILabel!
    @IBOutlet var cppClient: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
