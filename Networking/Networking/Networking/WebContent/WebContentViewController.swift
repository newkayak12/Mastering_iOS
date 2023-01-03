import UIKit
import WebKit

class WebContentViewController: UIViewController {
   
   @IBOutlet weak var urlField: UITextField!
   @IBOutlet weak var webView: WKWebView!
   
   @IBAction func goBack(_ sender: Any) {
      // Code Input Point #3
       if webView.canGoBack {
           webView.goBack()
       }
      // Code Input Point #3
   }
   
   @IBAction func reload(_ sender: Any) {
      // Code Input Point #5
       webView.reload()
      // Code Input Point #5
   }
   
   @IBAction func goForward(_ sender: Any) {
      // Code Input Point #4
       if webView.canGoForward {
           webView.goForward()
       }
      // Code Input Point #4
   }
   
   func go(to urlStr: String) {
      // Code Input Point #2
       guard let url = URL(string: urlStr) else {
           fatalError("Invalid URL")
       }
       let request = URLRequest(url: url)
       webView.load(request)
      // Code Input Point #2
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      navigationItem.largeTitleDisplayMode = .never
      webView.navigationDelegate = self
      // Code Input Point #1
       urlField.text = "https://www.apple.co.kr"
      // Code Input Point #1
   }
}

extension WebContentViewController: UITextFieldDelegate {
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      guard let str = textField.text else { return true }
      go(to: str)
      textField.resignFirstResponder()
      return true
   }
}

extension WebContentViewController: WKNavigationDelegate {
   func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
      print(error)
   }
}
