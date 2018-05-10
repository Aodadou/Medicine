//
//  MBoxManageVC.swift
//  MedicineBox
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 jxm. All rights reserved.
// 药品管理

import UIKit

class MBoxManageVC: ViewController,UITableViewDataSource,UITableViewDelegate {

    
    
    var datas = [MedicineInfo]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var image = UIImage(named:"默认头像")
        let img = sm.pationImages.object(forKey: sm.currentDid)
        if img != nil{
            image = img as? UIImage
        }
        self.addRightBarButton(withFirstImage: image, action: nil)
    }

    func reloadData(){
        if (!self.checkCurDeviceIsExist()){
            return;
        }
        datas = [] + sm.getCurrentDevice().list
        var length = datas.count
        
        
//        var temp = [MedicineInfo]()
//        for i in 0 ..< length{
//            var isRepeat = false
//
//            if i == length - 1{
//                break
//            }
//            for j in (i+1) ..< length{
//                if datas[i].rfid == datas[j].rfid{
//                    isRepeat = true
//                    break
//                }
//            }
//            if !isRepeat{
//                temp.append(datas[i])
//            }
//        }
        
        
        var i = 0
        for _ in 0 ..< length {
            if(!datas[i].isEdited){
                let data = datas[i]
                datas.remove(at: i)
                datas.append(data)
                length -= 1
                continue
            }
            i += 1
        }
        
        myTableView.reloadData()
       
    }
    @IBOutlet weak var myTableView: UITableView!
    
    @IBAction func ActionBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadData()
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let alert = UIAlertController.init(title: "提示", message: "删除该药品？", preferredStyle: .alert)
        
        let okAtion = UIAlertAction.init(title: "删除", style: .default) { Void in
            
            let cmd9d = CMD9D_DeleteMedicine.init()
            cmd9d.macId = self.sm.currentDid
            cmd9d.rfid = self.datas[indexPath.row].rfid
            
            self.sm.sendCmd(cmd9d)
        }
        
        let cancelAtion = UIAlertAction.init(title: "取消", style: .cancel, handler: nil);

        alert.addAction(okAtion)
        alert.addAction(cancelAtion)
        self.present(alert, animated: true, completion: nil)
//        alert.show(self, sender: tableView)
        
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editVC:EditMedicineInfoVC = self.storyboard!.instantiateViewController(withIdentifier: "editMedicineInfo") as! EditMedicineInfoVC
        editVC.medicine = datas[indexPath.row]
        self.navigationController?.pushViewController(editVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:MBoxTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "mbox") as? MBoxTableViewCell
        
        if cell == nil {
            cell = Bundle.main.loadNibNamed("MBoxTableViewCell", owner: self, options: nil)![0] as? MBoxTableViewCell
        }
        cell?.selectionStyle = .none
        let row = indexPath.row
        cell?.initView(datas[row] )
        return cell!
    }
    
    
    
    override func receiveAllDevice(_ obj: Notification) {
        super.receiveAllDevice(obj)
        self.reloadData()
        
    }
    override func receiveLater(_ cmdCode: Int, cmd: ServerCommand) {
        if (cmdCode == 0xB0 || cmdCode == 0xAE || cmdCode == 0xBB || cmdCode == 0xA0 || cmdCode == 0x0D || cmdCode == 0x0A2){
            self.reloadData()
        }
        
        if(cmdCode == 0x9E){
            Util.toast("删除成功", with: UIColor.green)
            sm.sendCmd(CMDA1_GetAllMedicineBox.init());
        }
        if(cmdCode == 0xC1){
            checkCurDeviceIsExist()
        }
    }
//    override func receiveCMDAfter(_ obj: Notification) {
//        myTableView.reloadData()
//        
//    }
    
    
    
    
    
    
}
