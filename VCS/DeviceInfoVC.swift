//
//  DeviceInfoVC.swift
//  MedicineBox
//
//  Created by jxm on 2017/5/14.
//  Copyright © 2017年 jxm. All rights reserved.
//

import UIKit

class DeviceInfoVC: ViewController {
    
    
    var isFirst = true
    @IBAction func btn_back(_ sender: AnyObject) {
        backVC()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        lbMac.text = sm.currentDid.substring(2, end: 13);
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        if isFirst {
            isFirst = false
            self.sm.sendCmd(CMDBE_DetectFirmwareVersion.init(macId: sm.getCurrentDevice().macId.substring(2, end:13)))
        }
    }
    @IBOutlet weak var lbMac: UILabel!
    @IBOutlet weak var lbVersion: UILabel!
    
    
    @IBAction func ActionDelete(_ sender: Any) {
        
        
        let online = sm.onlineMacString.contains(sm.currentDid)
        
        if(!online){
            
            Util.toast("设备不在线，无法删除。");
            
            return;
        }
        let alertController = UIAlertController(title: "删除之后将清除所有相关记录", message: "是否删除设备?", preferredStyle: .alert)
        
        //[UIAlertController alertControllerWithTitle:@"是否删除设备？" message:@"删除之后将清除所有相关记录" preferredStyle:UIAlertControllerStyleAlert]           ;
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { Void in
//            self.dismiss(animated: true, completion: nil)
        }
        let okAction = UIAlertAction(title: "删除", style: .default) { Void in
//            self.sm.sendCmd(CMD10_DelDevice(devid: self.sm.getCurrentDevice().macId))
            self.sm.sendCmd(CMDC0_DeleteMedicineBox.init(macId: self.sm.getCurrentDevice().macId))
            
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
      self.present(alertController, animated: true, completion: nil)
    }
    override func receiveLater(_ cmdCode: Int, cmd: ServerCommand) {
        if(cmdCode == 0x11){
            let cmd11 = cmd as! CMD11_ServerDelDeviceResult
            if(cmd11.device.id == sm.currentDid){
                self.navigationController?.popViewController(animated: true)
            }
            sm.sendCmd(CMDA1_GetAllMedicineBox())
        }else  if(cmdCode == 0xC1){
            let cmdC1 = cmd as! CMDC1_ServerMedicineBoxDeleteResult
            if(cmdC1.macAddr == sm.currentDid){
                self.navigationController?.popViewController(animated: true)
            }
            sm.sendCmd(CMDA1_GetAllMedicineBox())
        }else if(cmdCode == 0xBF){
            let cmdBF = cmd as! CMDBF_ServerFirmwareVersionResult
            let versionInfo = cmdBF.firmwareVersion
            lbVersion.text = "\(versionInfo!.firmwareVersion.substring(2, length: 1))\(versionInfo!.firmwareVersion.substring(0, length: 1))"
        }
    }
}
