//
//  ColorCollectionVIewCell.swift
//  CollectionView
//
//  Created by Sang Hyeon kim on 2022/12/03.
//  Copyright © 2022 Keun young Kim. All rights reserved.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var hexLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib() //viewDidLoad같은 느낌
        colorView.layer.cornerRadius = colorView.bounds.width / 2
    }
}
