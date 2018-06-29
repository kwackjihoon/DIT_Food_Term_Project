//
//  FoodTableViewCell.swift
//  Test
//
//  Created by D7703_27 on 2018. 6. 22..
//  Copyright © 2018년 kwackjihoon. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var collage: UILabel!
    @IBOutlet weak var tel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        icon.layer.cornerRadius = icon.frame.width / 8.0
        icon.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
