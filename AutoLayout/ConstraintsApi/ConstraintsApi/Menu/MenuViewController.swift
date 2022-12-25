import UIKit

class MenuViewController: UIViewController {

    
    var leftCenterXConstraint: NSLayoutConstraint!
    var leftEqualWidthConstraint: NSLayoutConstraint!
    var rightCenterXConstraint: NSLayoutConstraint!
    var rightEqualWidthConstraint: NSLayoutConstraint!
    
    var leftLabel: UILabel!
    var rightLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let header = UIView(frame: .zero)
        // MARK: - IMPORTANT
        header.translatesAutoresizingMaskIntoConstraints = false


        view.addSubview(header)
        header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        header.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        header.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        header.heightAnchor.constraint(equalToConstant: 80).isActive = true

        
        let leftButton = UIButton(frame: .zero)
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.setTitle(nil, for: .normal)
        leftButton.addTarget(self, action: #selector(selectLeftButton(_:)), for: .touchUpInside)
        header.addSubview(leftButton)
        leftButton.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        leftButton.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        leftButton.leadingAnchor.constraint(equalTo: header.leadingAnchor).isActive = true
        
        let rightButton = UIButton(frame: .zero)
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.setTitle(nil, for: .normal)
        rightButton.addTarget(self, action: #selector(selectRightButton(_:)), for: .touchUpInside)
        header.addSubview(rightButton)
        rightButton.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        rightButton.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        rightButton.trailingAnchor.constraint(equalTo: header.trailingAnchor).isActive = true
        
        
        leftButton.trailingAnchor.constraint(equalTo: rightButton.leadingAnchor).isActive = true
        rightButton.widthAnchor.constraint(equalTo: leftButton.widthAnchor).isActive = true
        
       
        
        [("의류", leftButton), ("생활가전", rightButton)].forEach { item in
            let lbl = UILabel(frame: .zero)
            lbl.text = item.0
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.font = UIFont.preferredFont(forTextStyle: .title2)
            lbl.setContentHuggingPriority(.required, for: .horizontal)
            lbl.setContentCompressionResistancePriority(.required, for: .horizontal)
            header.addSubview(lbl)
            lbl.centerXAnchor.constraint(equalTo: item.1.centerXAnchor).isActive = true
            lbl.centerYAnchor.constraint(equalTo: item.1.centerYAnchor).isActive = true
            
            if item.0 == "의류" {
                leftLabel = lbl
            } else{
                rightLabel = lbl
            }
                
        }
        
        
        let mover = UIView(frame: .zero)
        mover.translatesAutoresizingMaskIntoConstraints = false
        mover.backgroundColor = .systemGray3
        header.addSubview(mover)
        mover.heightAnchor.constraint(equalToConstant: 10).isActive = true
        mover.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        
        leftCenterXConstraint = mover.centerXAnchor.constraint(equalTo: leftButton.centerXAnchor)
        leftCenterXConstraint.isActive = true
        leftEqualWidthConstraint = mover.widthAnchor.constraint(equalTo: leftLabel.widthAnchor)
        leftEqualWidthConstraint.isActive = true
        
        
        rightCenterXConstraint = mover.centerXAnchor.constraint(equalTo: rightButton.centerXAnchor)
        rightCenterXConstraint.isActive = false
        rightEqualWidthConstraint = mover.widthAnchor.constraint(equalTo: rightLabel.widthAnchor)
        rightEqualWidthConstraint.isActive = false
    }
    
    
    @objc func selectLeftButton(_ sender: Any){
        rightCenterXConstraint.isActive = false
        rightEqualWidthConstraint.isActive = false
        leftCenterXConstraint.isActive = true
        leftEqualWidthConstraint.isActive = true
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    @objc func selectRightButton(_ sender: Any){
        leftCenterXConstraint.isActive = false
        leftEqualWidthConstraint.isActive = false
        rightCenterXConstraint.isActive = true
        rightEqualWidthConstraint.isActive = true
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
