//
//  Mastering iOS
//  Copyright (c) KxCoding <help@kxcoding.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import UIKit

class StatusBarViewController: UIViewController {
    
    var hidden = false
    override var prefersStatusBarHidden: Bool{
        return hidden
    }
    
    @IBAction func toggleVisibility(_ sender: Any) {
        hidden.toggle()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    var style = UIStatusBarStyle.default
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return style
    }
    @IBAction func toggleStyle(_ sender: Any) {
        style = style == .default ? .lightContent : style == .lightContent ? .darkContent : .default
        setNeedsStatusBarAppearanceUpdate()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}




extension StatusBarViewController {
    @IBAction func unwindToHere(_ sender: UIStoryboardSegue) {
        
    }
}













