

import UIKit
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
class QRScanView: UIView {

    var moveTimer:Timer?

    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var mIM: UIImageView!
    
    func startMove(){
        moveTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(QRScanView.MoveImView), userInfo: nil, repeats: true)
    }
    
    func stopMove(){
        moveTimer?.invalidate();
    }
    
    func calcScanAreaFrameParHeight(_ pHeight:CGFloat) -> CGRect {
        let screenWidth = UIScreen.main.bounds.size.width
        let xFrame = self.view.frame
        let x = (xFrame.origin.x / 320) * screenWidth
        let y = (xFrame.origin.y / 568) * screenHeight
        let width = (xFrame.size.width / 320) * screenWidth
        let height = (xFrame.size.height / 568) * screenHeight
        let ph = pHeight - 64
        
//        let view1 = UIView(frame: xFrame)
//        view1.backgroundColor = UIColor.greenColor()
//        self.addSubview(view1)
//        view1.alpha = 0.3
//        
//        let view = UIView(frame: CGRectMake(x,y,width,height))
//        self.addSubview(view)
//        view.backgroundColor = UIColor.redColor()
//        view.alpha = 0.3
        
        let rect = CGRect( x: y / ph, y: x / screenWidth, width: height / ph, height: width / screenWidth)
        return rect

    }
    
    func MoveImView(){
        mIM.frame = CGRect(x: mIM.frame.origin.x, y: mIM.frame.origin.y + 1, width: mIM.frame.size.width, height: mIM.frame.size.height)
        
        if (mIM.frame.origin.y >= (view.frame.size.height - 2)) {
            mIM.frame = CGRect(x: mIM.frame.origin.x, y: 0, width: mIM.frame.size.width, height: mIM.frame.size.height)
        }
    }
    
    deinit{
        self.moveTimer?.invalidate()
        print("二维码销毁了")
    }
}
