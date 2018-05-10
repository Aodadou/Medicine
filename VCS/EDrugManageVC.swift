//
//  EDrugManageVC.swift
//  MedicineBox
//
//  Created by apple on 16/7/28.
//  Copyright © 2016年 jxm. All rights reserved.
//  吃药提醒

import UIKit

class EDrugManageVC: ViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBAction func ActionBack(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        var image = UIImage(named:"默认头像")
        let img = sm.pationImages.object(forKey: sm.currentDid)
        if img != nil{
            image = img as? UIImage
        }
        self.addRightBarButton(withFirstImage: image, action: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initData()
    }
    var mInfos:[MedicineInfo] = [MedicineInfo]()
    
    
    
    func initData() -> Void {
        
        if(!self.checkCurDeviceIsExist()){
            return;
        }
        mInfos.removeAll()
        for mInfo in sm.getCurrentDevice().list {
            if mInfo.isEdited {
                mInfos.append(mInfo)
            }
        }
        myTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mInfos.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 198.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         var cell:EatDrugTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "eatDrug") as? EatDrugTableViewCell
        if cell == nil {
            cell = Bundle.main.loadNibNamed("EatDrugTableViewCell", owner: self, options: nil)![0] as? EatDrugTableViewCell
        }
        let row = indexPath.row
        cell?.initViewSetting(mInfos[row], pVC: self)
        return cell!
    }
    override func receiveAllDevice(_ obj: Notification) {
        super.receiveAllDevice(obj)
        initData()
    }
    
    
    override func receiveLater(_ cmdCode: Int, cmd: ServerCommand) {
        if (cmdCode == 0xB0 || cmdCode == 0xAE || cmdCode == 0xBB || cmdCode == 0xA0 || cmdCode == 0x0D ){
            initData()
        }
        
    }
    
}
