//
//  DeviceListVC.swift
//  MedicineBox
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 jxm. All rights reserved.
//  设备列表

import UIKit

class DeviceListVC: ViewController,UITableViewDelegate,UITableViewDataSource {

    var isSend = false
    
//    var isFirst = false
    override func viewDidLoad() {
        super.viewDidLoad()
         
        sm.sendCmd(CMD04_GetAllDeviceList())
        
        for box in sm.medicineBoxs {
            
            let m = box as! MedicineBox
            let medicines = m.list as [MedicineInfo]
            for medicine in medicines{
                if medicine.name == "" || medicine.name == nil{
                    continue
                }
                
                //检测是否过期 防止修改错误
                if medicine.validityPeriod.contains("(药品即将过期)"){
                    let dateStr = medicine.validityPeriod!
                    let newStr = dateStr.substring(from: dateStr.index(dateStr.startIndex, offsetBy: 8))
                    medicine.validityPeriod = newStr
                    
                    let cmd = CMD9F_EditMedicine(modifyType: 0, info: medicine)
                    sm.sendCmd(cmd)
                }
                
                
                if UtilSw.isOverDate(dateStr: medicine.validityPeriod){
                    
                    //okAction: #selector(self.toEdit),
                    let alertView = MyAlertView(title: "提示", message: "药品(\(medicine.name!))即将过期",  handler: {
                        (info) in
                        
                        
                        weak var weakSelf = self
                        let editVC:EditMedicineInfoVC = weakSelf!.storyboard!.instantiateViewController(withIdentifier: "editMedicineInfo") as! EditMedicineInfoVC
                        var medicineInfo:MedicineInfo?
                        for box in weakSelf!.sm.medicineBoxs{
                            let b = box as! MedicineBox
                            for medicine in b.list{
                                let m = medicine
                                if m.name == info{
                                    medicineInfo = m
                                    break
                                }
                            }
                        }
                        
                        editVC.medicine = medicineInfo
                        weakSelf!.navigationController?.pushViewController(editVC, animated: true)
                        
                        
                    })
                    alertView.info = medicine.name
                    alertView.show(controller: self)
                }
                //检测是否数量不足
                if UtilSw.isNoEnoughMedicine(medicine: medicine){
                    
                    let alertView = MyAlertView(title: "提示", message: "药品(\(medicine.name!))数量不足" , handler: {
                        (info) in
                        
                        weak var weakSelf = self
                        let editVC:EditMedicineInfoVC = weakSelf!.storyboard!.instantiateViewController(withIdentifier: "editMedicineInfo") as! EditMedicineInfoVC
                        editVC.medicine = medicine
                        weakSelf!.navigationController?.pushViewController(editVC, animated: true)
                        
                    })
                    alertView.info = medicine.name
                    alertView.show(controller: self)
                }
            }
        }
        
    }
    @IBOutlet weak var myTableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        myTableView.reloadData()
        
        
        
    }
    
    func toEdit(){
        print("dfsadff")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "mboxvc") as! MBoxManageVC
        //vc.datas = medicines
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        let views = UIApplication.shared.keyWindow?.subviews
        for i in 0..<views!.count{
            if views![i].tag == 10001{
                views![i].removeFromSuperview()
                break
            }
        }
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.title = "健康中心"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sm.medicineBoxs.count + 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 198.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         var cell:BoxTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "MBCell") as? BoxTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("BoxTableViewCell", owner: self, options: nil)![0] as? BoxTableViewCell
        }
        
        let row = indexPath.row
        if row ==  sm.medicineBoxs.count{
            cell?.initViewSetting(row == 0,isAdd: true, pVC: self ,mbox:nil)
        }else{
            cell?.initViewSetting(false,isAdd: false, pVC: self,mbox:sm.medicineBoxs.object(at: row) as? MedicineBox)
        }
        return cell!
    }
//    override func receiveAllDevice(_ obj: Notification) {
//        super.receiveAllDevice(obj)
//        myTableView.reloadData()
//    }
    
    override func receiveLater(_ cmdCode: Int, cmd: ServerCommand) {
        if (cmdCode == 0xB0 || cmdCode == 0xAE || cmdCode == 0xBB || cmdCode == 0xA0 || cmdCode == 0x0D || cmdCode == 0x05 || cmdCode == 0x09 || cmdCode == 0xC1){
             myTableView.reloadData()
        }
        
        
        
    }
}
