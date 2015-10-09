//
//  HomeCell.swift
//  Get_Pizza
//
//  Created by Jonathan Green on 10/8/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
    
    @IBOutlet weak var applePayBtn: ZFRippleButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applePayBtn.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
