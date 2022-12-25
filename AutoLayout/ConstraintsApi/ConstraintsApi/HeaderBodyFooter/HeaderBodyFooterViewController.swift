import UIKit

class HeaderBodyFooterViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let header = UIView(frame: .zero)
        header.translatesAutoresizingMaskIntoConstraints = false
        header.backgroundColor = .systemRed
        
        view.addSubview(header)
        header.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        header.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        header.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        header.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        let footer = UIView(frame: .zero)
        footer.translatesAutoresizingMaskIntoConstraints = false
        footer.backgroundColor = .systemBlue
        
        view.addSubview(footer)
        footer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        footer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        footer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        footer.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        
        let body = UIView(frame: .zero)
        body.translatesAutoresizingMaskIntoConstraints = false
        body.backgroundColor = .systemYellow
        view.addSubview(body)
        body.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        body.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        body.topAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        body.bottomAnchor.constraint(equalTo: footer.topAnchor).isActive = true
    }
}
