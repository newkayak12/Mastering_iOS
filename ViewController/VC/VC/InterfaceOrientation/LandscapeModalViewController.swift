import UIKit
import AVFoundation

class LandscapeModalViewController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    
    
    @IBOutlet weak var playerView: PlayerView!
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return .landscapeLeft
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .all
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        //회전이벤트시 여기 호출됨
        //size, dark, light mode 등이 변해야함
        //ipad는 size가 회전해도 바뀌지 않음
        //그래서 rootViewframe으로 파악하는 것이 좋음
        print(newCollection.verticalSizeClass.description)
        switch newCollection.verticalSizeClass {
            case .regular:
                closeButton.backgroundColor = UIColor.systemRed.withAlphaComponent(0.5)
            default:
                closeButton.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        //rootView frame 업데이트 되기 직전에 실행
        if size.height > size.width {
            closeButton.backgroundColor = UIColor.systemRed.withAlphaComponent(0.5)
        } else {
            closeButton.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.5)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = Bundle.main.url(forResource: "video", withExtension: "mp4") else { return }
        let player = AVPlayer(url: url)
        playerView.player = player
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        playerView.player?.play()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        playerView.player?.pause()
    }
}




extension UIUserInterfaceSizeClass {
    var description: String {
        switch self {
        case .compact:
            return "Compact"
        case .regular:
            return "Regular"
        default:
            return "Unspecified"
        }
    }
}
















