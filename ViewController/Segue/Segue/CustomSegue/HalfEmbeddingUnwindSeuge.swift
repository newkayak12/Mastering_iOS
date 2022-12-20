//
//  HalfEmbeddingUnwindSeuge.swift
//  Segue
//
//  Created by Sang Hyeon kim on 2022/12/20.
//  Copyright © 2022 Keun young Kim. All rights reserved.
//

import UIKit

class HalfEmbeddingUnwindSeuge: UIStoryboardSegue {

    override func perform() {
        var frame = source.view.frame
        frame = frame.offsetBy(dx: 0, dy: frame.height)
        
        UIView.animate(withDuration: 0.3) {
            self.source.view.frame = frame
            self.source.view.alpha = 0.0
        } completion: { finished in
            self.source.view.removeFromSuperview()
            self.source.removeFromParentViewController()
        }

    }
}
