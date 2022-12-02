//
//  CustomHeaderView.swift
//  TableView
//
//  Created by Sang Hyeon kim on 2022/12/02.
//  Copyright © 2022 Keun young Kim. All rights reserved.
//

import UIKit

class CustomHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var customBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        countLabel.text = "0"
        countLabel.layer.cornerRadius = 30
        countLabel.clipsToBounds = true
        
        backgroundView = customBackgroundView
    }
}
