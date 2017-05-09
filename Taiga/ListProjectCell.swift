//
//  ListProjectCell.swift
//  Taiga
//
//  Created by Quang Dat on 5/4/17.
//  Copyright © 2017 Quang Dat. All rights reserved.
//

import UIKit

class ListProjectCell: UITableViewCell {

    @IBOutlet weak var lblAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblAuthor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
