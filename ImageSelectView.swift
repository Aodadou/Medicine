import UIKit


@objc protocol ImageSelectViewDelegate{
    func openCamera(_ view:ImageSelectView)
    func openPhoto(_ view:ImageSelectView)
    func dismiss(_ view:ImageSelectView)
}

class ImageSelectView: UIView {
    var delegate:ImageSelectViewDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        UIControlState()
        
        self.backgroundColor = UIColor.white
        
        let btnWidth = self.frame.width * (578/750)
        let btnHeight = btnWidth * (94/578)
        let hSpace = (self.frame.width - btnWidth) / 2
        let vSpace = (self.frame.height - 3 * btnHeight) / 4

        let btn_camera = UIButton(frame: CGRect(x: hSpace,y: vSpace, width: btnWidth, height: btnHeight))
        btn_camera.addTarget(self, action: #selector(ImageSelectView.openCamera), for: UIControlEvents.touchUpInside)
        btn_camera.setTitle("相机", for: UIControlState())
        btn_camera.backgroundColor = UIColor.clear
        btn_camera.layer.cornerRadius = 5
        btn_camera.setTitleColor(UIColor.gray, for: UIControlState())
        btn_camera.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        btn_camera.setBackgroundImage(UIImage(named: "相机按钮"), for: UIControlState())
        btn_camera.setBackgroundImage(UIImage(named: "相机按钮按下"), for: UIControlState.highlighted)
        
        let btn_photo = UIButton(frame: CGRect(x: hSpace, y: btnHeight + 2 * vSpace, width: btnWidth, height: btnHeight))
        btn_photo.addTarget(self, action: #selector(ImageSelectView.openPhoto), for: UIControlEvents.touchUpInside)
        btn_photo.setTitle("相册", for: UIControlState())
        btn_photo.backgroundColor = UIColor.clear
        btn_photo.layer.cornerRadius = 5
        btn_photo.setTitleColor(UIColor.gray, for: UIControlState())
        btn_photo.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        btn_photo.setBackgroundImage(UIImage(named:"相机按钮"), for: UIControlState())
        btn_photo.setBackgroundImage(UIImage(named:"相机按钮按下"), for: UIControlState.highlighted)
        
        let btn_dismiss = UIButton(frame: CGRect(x: hSpace, y: 3 * vSpace + 2 * btnHeight, width: btnWidth, height: btnHeight))
        btn_dismiss.backgroundColor = UIColor.clear
        btn_dismiss.setTitle("取消", for: UIControlState())
        btn_dismiss.addTarget(self, action: #selector(ImageSelectView.dismissView), for: UIControlEvents.touchUpInside)
        btn_dismiss.layer.cornerRadius = 5
        btn_dismiss.setTitleColor(UIColor.gray, for: UIControlState())
        btn_dismiss.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        btn_dismiss.setBackgroundImage(UIImage(named:"相机按钮"), for: UIControlState())
        btn_dismiss.setBackgroundImage(UIImage(named:"相机按钮按下"), for: UIControlState.highlighted)
        
        self.addSubview(btn_camera)
        self.addSubview(btn_photo)
        self.addSubview(btn_dismiss)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func openCamera(){
        self.delegate?.openCamera(self)
    }
    
    func openPhoto(){
        self.delegate?.openPhoto(self)
    }
    
    func dismissView(){
        self.delegate?.dismiss(self)
    }

}
