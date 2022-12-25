import UIKit

/**
     NSLayoutContstraint
     NSLayoutAnchor
     VisualFormatLanguage
 */
class BasicsViewController: UIViewController {
    
    var redView: UIView!
    var greenView: UIView!
    var blueView: UIView!
    var yellowView: UIView!
    var titleLabel: UILabel!
    var grayView: UIView!

    fileprivate func addRedView() {
        redView = UIView(frame: .zero)
        redView.backgroundColor = .systemRed
        redView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(redView)
        
        guard let redView = redView else {return }
        let leadingConstraint = NSLayoutConstraint(item: redView, attribute: .leading, relatedBy: .equal, toItem: view.layoutMarginsGuide, attribute: .leading, multiplier: 1.0, constant: 0)
        leadingConstraint.isActive = true
        
        let topConstraint = redView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        topConstraint.isActive = true
        
        let widthConstraint = NSLayoutConstraint(item: redView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100)
        widthConstraint.isActive = true
        
        let heightConstraint = redView.heightAnchor.constraint(equalToConstant: 100)
        heightConstraint.isActive = true
    }
    fileprivate func addGreenView() {
        greenView = UIView(frame: .zero)
        greenView.backgroundColor = .systemGreen
        greenView.translatesAutoresizingMaskIntoConstraints = false
        view .addSubview(greenView)
        guard let greenView = greenView else {return}
        
        let views: [String: Any] = ["greenView": greenView]
        
        var format = "V:|-[greenView(100)]"//v vertical, | superview
        let verticalConstraint = NSLayoutConstraint.constraints(withVisualFormat: format, metrics: nil, views: views)
        NSLayoutConstraint.activate(verticalConstraint)
        
        format = "[greenView(100)]-|"
        let horzConstraint = NSLayoutConstraint.constraints(withVisualFormat: format, metrics: nil, views: views)
        NSLayoutConstraint.activate(horzConstraint)
    }
    fileprivate func addBlueView(){
        blueView = UIView(frame: .zero)
        blueView.backgroundColor = .systemBlue
        blueView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blueView)
        
        guard let blueView = blueView else {return}
        let views: [String:Any] = ["blueView":blueView]
        var const = NSLayoutConstraint.constraints(withVisualFormat: "V:[blueView(100)]-|", metrics: nil, views: views)
        NSLayoutConstraint.activate(const)
        const = NSLayoutConstraint.constraints(withVisualFormat: "|-[blueView(100)]", metrics: nil, views: views)
        NSLayoutConstraint.activate(const)
        
    }
    fileprivate func addYellowView(){
        yellowView = UIView(frame: .zero)
        yellowView.backgroundColor = .systemYellow
        yellowView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(yellowView)
        
        yellowView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        yellowView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        yellowView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        yellowView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
    }
    fileprivate func addLabel(){
        titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "iOS 16.2"
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        view.addSubview(titleLabel)
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    fileprivate func addBar(){
        grayView = UIView(frame: .zero)
        grayView.translatesAutoresizingMaskIntoConstraints = false
        grayView.backgroundColor = .systemGray3
        view.addSubview(grayView)
        
        grayView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        grayView.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1.0).isActive = true
        
//        grayView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
//        grayView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        grayView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        grayView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addRedView()
        addGreenView()
        addBlueView()
        addYellowView()
        addLabel()
        addBar()
        
        
        
    }
}
