import UIKit

class CustomDrawingView: UIView {
    let starImg = UIImage(systemName: "star")
    let bellImg = UIImage(systemName: "bell")
    let umbrellaImg = UIImage(systemName: "umbrella")
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        //라이프 사이클 동안 반복해서 호출된다.
        //여기에서 이미지뷰를 생성하고 addSubview로 추가하면 view를 그릴 때마다
        //새로운 이미지가 추가된다.
        //UIImage가 제공하는 메소드로 직접 그려야한다.
        starImg?.draw(at: CGPoint(x: 0, y: 0))
        bellImg?.draw(in: CGRect(x: 0, y: 80, width: 100, height: 100))
        umbrellaImg?.drawAsPattern(in: rect)//이미지 크기가 프레임보다 작으면 패턴 형태로 그림
        
    }
}



class CustomImageDrawingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
