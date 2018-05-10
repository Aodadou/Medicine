//
//  ViewController.swift
//  MedicineBox
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 jxm. All rights reserved.
// 
//  所有viewcontroler的基类 －－ 
//  mainView是用来自适应屏幕分辨率

import UIKit

class ViewController: UIViewController,UIGestureRecognizerDelegate,UIAlertViewDelegate{

    var sm:SessionManger = SessionManger.share()
    @IBOutlet weak var mainView: UIView!///主要布局部分
    @IBOutlet weak var btnRight: UIButton!///显示小头像用
    
    var alert:UIAlertView?///对话框
    ///标记是否启用左滑返回
    var flagAutoPop = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().barTintColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(receiveFF(_:)), name: NSNotification.Name(rawValue: NTF_REC_FF), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(receiveCMD(_:)), name: NSNotification.Name(rawValue: "kReceiveCMD"), object: nil)
        
//         NotificationCenter.default.addObserver(self, selector: #selector(receiveCMDAfter(_:)), name: NSNotification.Name(rawValue: NTF_REC_CMDA), object: nil)
          NotificationCenter.default.addObserver(self, selector: #selector(receiveAllDevice(_:)), name: NSNotification.Name(rawValue: "getAllDevice"), object: nil)
        
        
        if #available(iOS 11, *){
            
            if btnRight != nil{
                //btnRight.isHidden = true
                
                //ImageUtils.setViewShapeCircle(btnRight);
                let img = sm.pationImages.object(forKey: sm.currentDid)
                btnRight.setImage(img as? UIImage, for: .disabled)
                btnRight.setImage(img as? UIImage, for: .highlighted)
                btnRight.setImage(img as? UIImage, for: .selected)
                btnRight.setImage(img as? UIImage, for: .normal)
            }
            
            
            
        }else{
            
            if btnRight != nil {
                ImageUtils.setViewShapeCircle(btnRight);
                let img = sm.pationImages.object(forKey: sm.currentDid)
                btnRight.imageView!.contentMode = .scaleAspectFill
                btnRight.setImage(img as? UIImage, for: .disabled)
                btnRight.setImage(img as? UIImage, for: .highlighted)
                btnRight.setImage(img as? UIImage, for: .selected)
                btnRight.setImage(img as? UIImage, for: .normal)
            }
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
//    func receiveCMDAfter(_ obj:Notification){
//        
//        
//    }
    
    func receiveLater(_ cmdCode:Int ,cmd:ServerCommand) -> Void {
        
    }
    
    func receiveCMD(_ obj:Notification){
        let cmd:ServerCommand = obj.object as! ServerCommand
        if cmd.getNo() == CMD03_ServerLoginRespond.commandConst() {
            GlobalMethod.closePressDialog()
            
        }
        receiveLater(Int(cmd.getNo()), cmd: cmd)
    }
    func receiveFF(_ obj:Notification){
        GlobalMethod.closePressDialog()
        let info = (obj.object as AnyObject).object(forKey: "info") as? String
        Util.toast(info)
    }
    func receiveAllDevice(_ obj:Notification) -> Void {
        GlobalMethod.closePressDialog()
       
    }
    
    
    func getDrugTimeScheme(_ macId:String,rfid:String) -> (DrugTimeScheme?,MedicineInfo?)? {
        for i in  0..<sm.medicineBoxs.count{
            let box = sm.medicineBoxs.object(at: i);
            if (box as AnyObject).macId!.contains(macId) {
                for drugInfo in (box as! MedicineBox).list! {
                    if drugInfo.rfid.contains(rfid) {
                        return (drugInfo.scheme,drugInfo)
                    }
                }
            }
        }
        return nil
    }
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.navigationController!.interactivePopGestureRecognizer!.delegate = self
        if (self.navigationController != nil && self.navigationController!.viewControllers.count == 1 && !flagAutoPop) {
            self.navigationController!.interactivePopGestureRecognizer!.isEnabled = false;
        }else{
              self.navigationController!.interactivePopGestureRecognizer!.isEnabled = true;
        }
       
        
        
    }
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        
    }
    
    
    func manualExitLogin() -> Void {
        UserDefaults.standard.set(false, forKey: "remember")
        UserDefaults.standard.set("", forKey: "password")
        UserDefaults.standard.synchronize()
        sm.isLogin = false
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    func backVC() -> Void {
        self.navigationController?.popViewController(animated: true)
    }
    func nextVC(_ ide:String) -> Void {
        let v = (self.storyboard?.instantiateViewController(withIdentifier: ide))
        if v == nil {
            print("error!! viewcontroller is null! id:\(ide)")
            return
        }
        self.navigationController?.pushViewController(v!, animated: true)
    }
    
    func checkCurDeviceIsExist() -> Bool {
        if sm.getCurrentDevice() == nil {
            Util.toast("设备已被删除");
            self.navigationController?.popViewController(animated: true);
            return false;
        }
        return true;
    }
    
}

