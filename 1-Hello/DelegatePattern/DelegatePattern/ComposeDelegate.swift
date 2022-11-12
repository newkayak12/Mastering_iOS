import UIKit

protocol ComposeDelegate {
    func composer(_ vc: UIViewController, didInput value: String?) // 값 입력
    func composerDidCancel(_ vc: UIViewController) // 값 입력없이 취소
}
