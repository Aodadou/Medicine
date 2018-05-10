//
//  ScanQRCodeVC.swift
//  MedicineBox
//
//  Created by apple on 16/8/16.
//  Copyright © 2016年 jxm. All rights reserved.
//

import UIKit
import AVFoundation

var infoQR:MedicineInfo?
class ScanQRCodeVC: ViewController,AVCaptureMetadataOutputObjectsDelegate,UINavigationBarDelegate {
    
    var place:String?//房间信息
    var groupId:String?
    var scanValue:String?
    
    var device:AVCaptureDevice?
    var input:AVCaptureDeviceInput?
    var output:AVCaptureMetadataOutput?
    var session:AVCaptureSession?
    var preview:AVCaptureVideoPreviewLayer?
    var qrScanView:QRScanView!
    var scan:Bool?
    
    var btnInfo:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightItemButtom = UIBarButtonItem(title: "手动输入", style: .plain, target: self, action: #selector(ScanQRCodeVC.inputInHand))
        self.navigationItem.rightBarButtonItem = rightItemButtom
        
//
        
        let barItem = UIBarButtonItem(title: "  ", style: UIBarButtonItemStyle.plain, target: nil, action: #selector(ScanQRCodeVC.back))
       // barItem.tintColor = UIColor.redColor()
        self.navigationItem.backBarButtonItem = barItem
       // self.navigationItem.backBarButtonItem?.title = " "
         //self.navigationItem.backBarButtonItem!.setBackgroundImage(UIImage(named: "返回ICON"), forState: .Normal, barMetrics: .Default)
//        let rightBarItem = UIBarButtonItem(title: "手动输入", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(rightButton))
//        
//        self.navigationItem.rightBarButtonItem = rightBarItem

//        let rightBarItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(back))
//        rightBarItem.setBackgroundImage(UIImage(named: "返回ICON"), forState: .Normal, barMetrics: .Default)
//         rightBarItem.setBackgroundImage(UIImage(named: "返回ICON按下"), forState: .Highlighted, barMetrics: .Default)
//        self.navigationItem.rightBarButtonItem = rightBarItem
        
        
        self.title = "扫描条形码"
        self.view.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 0.0)
        qrScanView =  {
            let arr = Bundle.main.loadNibNamed("QRScan1", owner: nil, options: nil)! as NSArray
            return arr[0] as! QRScanView
        }()
        qrScanView.frame = CGRect(x: 0, y: 64, width: screenWidth, height: screenHeight)
        self.view.addSubview(qrScanView!)
        self.avcInit()
        
        let btnW = screenWidth * (490 / 750.0)
        let btnX = (screenWidth - btnW) / 2
        let btnY:CGFloat = 100
        let btnH = btnW * 0.17
        btnInfo = UIButton(frame: CGRect(x: btnX,y: btnY,width: btnW,height: btnH))
        btnInfo?.layer.cornerRadius = 15
        btnInfo?.setTitle("请扫描药品上的条形码", for: UIControlState())
        btnInfo?.setTitleColor(UIColor.white, for: UIControlState())
        btnInfo?.layer.borderWidth = 3
        btnInfo?.layer.borderColor = UIColor.white.cgColor
        btnInfo?.layer.backgroundColor = UIColor.black.cgColor
        self.view.addSubview(btnInfo!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let _  = scan{
            if scan! {
                let val:Bool = (session?.isRunning)!
                if !val {
                    session?.startRunning()
                    qrScanView.startMove()
                }
            }
        }
        
    }
    
    func inputInHand(){
        
        let inputDrugInHandVC = InputDrugInHandVC()
        self.navigationController?.pushViewController(inputDrugInHandVC, animated: true)
        
    }
    
    func rightButton() -> Void {
        
    }
    
    func avcInit(){
        device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do{
            input  =  try AVCaptureDeviceInput(device: device)
        } catch _ as NSError {
            GlobalMethod.toast("您的手机没有摄像头或者此应用没有摄像头使用权限")
            return
        }
        
        output = AVCaptureMetadataOutput.init()
        
        output!.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        session = AVCaptureSession.init()
        
        session!.sessionPreset = AVCaptureSessionPresetHigh
        
        if session!.canAddInput(input) {
            session!.addInput(input)
        }
        
        if session!.canAddOutput(output) {
            session!.addOutput(output)
        }
        
        output!.metadataObjectTypes = [AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]//[AVMetadataObjectTypeQRCode]
        
        let temp = qrScanView?.calcScanAreaFrameParHeight(screenHeight)
        
        output!.rectOfInterest = temp!
        
        preview = AVCaptureVideoPreviewLayer.init(session: session)
        
        preview!.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        preview!.frame = self.view.layer.bounds
        
        self.view.layer.insertSublayer(preview!, at: 0)
        
        // Start
        session!.startRunning()
        qrScanView!.startMove()
        scan = true;
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        if metadataObjects.count > 0 {
            
            qrScanView!.stopMove()
            session!.stopRunning()
            
            let meatadataObject:AVMetadataMachineReadableCodeObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            
            scanValue = meatadataObject.stringValue;
            
//            let stringValue = scanValue!.componentsSeparatedByString("-")[0]
            
            sm.sendCmd(CMDBC_QueryDrugInfoByBarCode(barcode: scanValue))
            
            //GlobalMethod.toast("\(stringValue)")
        }
    }
    override func receiveFF(_ obj: Notification) {
        
        let code = Int((obj.object! as AnyObject).object(forKey: "code") as! String)
        if code == 62 {
            let alert = UIAlertView(title: "未发现该药品的信息", message: nil, delegate: self, cancelButtonTitle: "确定")
            alert.tag = 10
            alert.show()
        }else{
            super.receiveFF(obj)
        }
        
    }
    override func receiveLater(_ cmdCode: Int, cmd: ServerCommand) {
       super.receiveLater(cmdCode, cmd: cmd)
        if cmdCode == 0xBD {
            let cmdbd = cmd as! CMDBD_ServerReturnMedicineInfo
            infoQR = cmdbd.info
//            self.backVC()
//            self.nextVC("scanRS")
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "scanRS")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    override func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if alertView.tag == 10 {
            restart()
        }
    }
    func viewdismiss() {
        
    }
    
    func restart(){
        
        // Start
        session!.startRunning()
        qrScanView!.startMove()
        scan = true;
    }
    
    func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit{
        self.qrScanView = nil
        print("二维码界面销毁了")
    }
}
