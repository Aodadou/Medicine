import UIKit
let mainTintColor = UIColor(red: 57/255.0, green: 161/255.0, blue: 232/255.0, alpha: 1)
let selectTfColor = UIColor(red: 162/255.0, green: 162/255.0, blue: 162/255.0, alpha: 1)
let noSelectTfColor = UIColor(red: 210/255.0, green: 210/255.0, blue: 210/255.0, alpha: 1)
let backColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1)
class ImageSelect_Delegate: NSObject,ImageSelectViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var selectBlock:((_ image:UIImage) -> Void)?
    var currentVC:UIViewController?
    var cropImageView:KICropImageView?
    
    override init() {
        super.init()
    }
    
    func openCamera(_ view: ImageSelectView) {
        
        //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
        var sourceType = UIImagePickerControllerSourceType.camera
        
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            sourceType = UIImagePickerControllerSourceType.photoLibrary
        }
        let picker = UIImagePickerController()
        picker.delegate = self
        //picker.allowsEditing = true//设置可编辑
        
        picker.sourceType = sourceType
        
        self.currentVC = self.getVC(view)
        
        self.getVC(view)!.present(picker, animated: true, completion: nil)//进入照相界面
    }
    
    func openPhoto(_ view: ImageSelectView) {
        
        let pickerImage = UIImagePickerController()
        
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            
            pickerImage.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            pickerImage.mediaTypes = UIImagePickerController.availableMediaTypes(for: pickerImage.sourceType)!
        }
        pickerImage.delegate = self
        //pickerImage.allowsEditing = true
        self.currentVC = self.getVC(view)
        
        self.getVC(view)!.present(pickerImage, animated: true, completion: nil)
    }
    
    func dismiss(_ view: ImageSelectView) {
        
        self.getVC(view)?.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 10, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            
            view.transform = CGAffineTransform(translationX: 0, y: 0)
            
            let coverView = self.getVC(view)!.value(forKey: "coverView") as? UIView
            if let _ = coverView{
                coverView?.removeFromSuperview()
            }
            (UIApplication.shared.delegate as! AppDelegate).dismissMask()

            }) { (bool) -> Void in
                self.getVC(view)?.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
                view.removeFromSuperview()
        }
        
        
        
    }
    //获取当前显示VC
    func getVC(_ view:UIView) -> UIViewController?{
        var target:AnyObject? = view
        while(target != nil){
            target = target!.next
            if target is UIViewController{
                return target as? UIViewController
            }
        }
        return nil
    }
    
    //选择之后所得照片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let selectImg = info[UIImagePickerControllerOriginalImage] as! UIImage//  UIImagePickerControllerEditedImage
        let scaleImage = UIImage.scale(selectImg, toScale: 0.3)
        
//        var data:NSData?// = UIImageJPEGRepresentation(selectImg, 0.3)
//        
//        if (UIImagePNGRepresentation(scaleImage) == nil) {
//            //将图片转换为JPG格式的二进制数据
//            data = UIImageJPEGRepresentation(scaleImage, 1);
//        } else {
//            //将图片转换为PNG格式的二进制数据
//            data = UIImagePNGRepresentation(scaleImage);
//        }
//        
//        let rect = CGRectMake(0, 64, screenWidth, screenHeight - 64)
//        self.cropImageView = KICropImageView(frame: rect)
//        let image = UIImage(data: data!)
//        self.cropImageView!.setImage(image)
//        self.cropImageView!.backgroundColor = backColor
//        self.cropImageView!.setCropSize(CGSizeMake(screenWidth - 6, screenWidth * (0.55)))
//        
//        let nav = UINavigationBar(frame: CGRectMake(0,0,screenWidth,64))
//        nav.backgroundColor = mainTintColor
//        
//        let labelX = (screenWidth - 100) / 2
//        let label_title = UILabel(frame: CGRectMake(labelX,26,100,30))
//        label_title.font = UIFont.systemFontOfSize(18)
//        label_title.textColor = UIColor.whiteColor()
//        label_title.text = "图片剪切"
//        label_title.numberOfLines = 0
//        label_title.textAlignment = NSTextAlignment.Center
//        
//        let btn_cancel = UIButton(frame: CGRectMake(5,screenHeight - 50,screenWidth / 2 - 7,45))
//        let btn_sure  = UIButton(frame: CGRectMake(screenWidth / 2 + 2,screenHeight - 50,screenWidth / 2 - 5,45))
//        btn_cancel.backgroundColor = mainTintColor
//        btn_cancel.setTitle("取消", forState: UIControlState.Normal)
//        btn_cancel.addTarget(self, action: "cancel", forControlEvents: UIControlEvents.TouchUpInside)
//        btn_cancel.layer.cornerRadius = 5
//        btn_sure.backgroundColor = mainTintColor//UIColor.blackColor()
//        btn_sure.setTitle("选择", forState: UIControlState.Normal)
//        btn_sure.addTarget(self, action: "sure", forControlEvents: UIControlEvents.TouchUpInside)
//        btn_sure.layer.cornerRadius = 5
//        let view = UIView(frame: mainWindow!.frame)
//        view.tag = 1113
//        
//        view.addSubview(self.cropImageView!)
//        view.addSubview(nav)
//        view.addSubview(label_title)
//        view.addSubview(btn_cancel)
//        view.addSubview(btn_sure)
//        
//        MyGlobalMethod.addImageCutView(view)
        
    }
    
    func cancel(){
//        MyGlobalMethod.removeImageCutView()
    }
    
    func sure(){
        let selectImg = self.cropImageView!.cropImage()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "SelectImage"), object: selectImg)
//        MyGlobalMethod.removeImageCutView()
//
    }
    
    //取消
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) { () -> Void in
            
        }
    }
    
}
