//
//  HalfEmbeddingSegue.swift
//  Segue
//
//  Created by Sang Hyeon kim on 2022/12/20.
//  Copyright © 2022 Keun young Kim. All rights reserved.
//

import UIKit

class HalfEmbeddingSegue: UIStoryboardSegue {
    override init(identifier: String?, source: UIViewController, destination: UIViewController) {
        super.init(identifier: identifier, source: source, destination: destination)
    }
    override func perform() {
        var frame = source.view.bounds
        frame.origin.y = frame.height
        frame.size.height = frame.height / 2
        
        source.view.addSubview(destination.view)
        destination.view.frame = frame
        destination.view.alpha = 0.0
        
        source.addChildViewController(destination)
        
        frame.origin.y  = source.view.bounds.height / 2
        UIView.animate(withDuration: 0.3) {
            self.destination.view.frame = frame
            self.destination.view.alpha = 1.0
        }
    }
    
}
