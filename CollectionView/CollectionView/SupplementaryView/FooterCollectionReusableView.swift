//
//  FooterCollectionReusableView.swift
//  CollectionView
//
//  Created by Sang Hyeon kim on 2022/12/03.
//  Copyright © 2022 Keun young Kim. All rights reserved.
//

import UIKit

class FooterCollectionReusableView: UICollectionReusableView {
    var sectionFooterLabel: UILabel!
    private func setup() {
        let lbl = UILabel(frame: .zero)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.preferredFont(forTextStyle: .headline)
        addSubview(lbl)
        
        lbl.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1.0).isActive = true
        lbl.trailingAnchor.constraint(equalToSystemSpacingAfter: trailingAnchor, multiplier: 1.0).isActive = true
        lbl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        sectionFooterLabel = lbl
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
