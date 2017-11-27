//
//  AplayTableViewCell.swift
//  MiniChallenge5
//
//  Created by Osniel Lopes Teixeira on 26/11/2017.
//  Copyright © 2017 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class AplayTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
