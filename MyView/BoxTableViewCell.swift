//
//  BoxTableViewCell.swift
//  MedicineBox
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 jxm. All rights reserved.
// 药盒子列表中的item

import UIKit

class BoxTableViewCell: UITableViewCell {

    @IBOutlet weak var imgHead: UIImageView!
    ///角标
    @IBOutlet weak var tfMBoxM: UITextField!
    @IBOutlet weak var tfBoxR: UITextField!
    @IBOutlet weak var tfTime: UITextField!
    
    @IBOutlet weak var viewMBox: UIView!
    @IBOutlet weak var viewAddMBox: UIView!
    @IBOutlet weak var lbAddTalk: UILabel!
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbOnline: UILabel!
    var medicineBox:MedicineBox?
    var pationInfo:PationInfo?
    
    var parentVC:UIViewController?
    
    @IBAction func ActionsBtn(_ sender: UIButton) {
        SessionManger.share().currentDid = medicineBox?.macId
        switch sender.tag {
        case 0:
            let vc = parentVC?.storyboard?.instantiateViewController(withIdentifier: "mboxvc")
            parentVC?.navigationController?.pushViewController(vc!, animated: true)
            break
        case 1:
            let vc = parentVC?.storyboard?.instantiateViewController(withIdentifier: "eatDrugRecord")
            parentVC?.navigationController?.pushViewController(vc!, animated: true)
            break
        case 2:
            let vc = parentVC?.storyboard?.instantiateViewController(withIdentifier: "eDrug")
            parentVC?.navigationController?.pushViewController(vc!, animated: true)
            break
        case 4:
            let vc = parentVC?.storyboard?.instantiateViewController(withIdentifier: "personInfo")
            parentVC?.navigationController?.pushViewController(vc!, animated: true)
            break
        case 3:
            let vc = parentVC?.storyboard?.instantiateViewController(withIdentifier: "deviceInfo")
            parentVC?.navigationController?.pushViewController(vc!, animated: true)
            
            break
        default:
            break
        }
       
    }
    
    @IBAction func ActionAddMBox(_ sender: AnyObject) {
        let vc = parentVC?.storyboard?.instantiateViewController(withIdentifier: "config")
       parentVC?.navigationController?.pushViewController(vc!, animated: true)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func initViewSetting(_ isFirst:Bool,isAdd:Bool,pVC:UIViewController,mbox:MedicineBox?){
        lbAddTalk.isHidden = !isFirst
        viewMBox.isHidden = isAdd
        viewAddMBox.isHidden = !isAdd
        parentVC = pVC
        if mbox != nil {
            pationInfo = getPationInfo(mbox!.macId)
        }
//        if()
        medicineBox = mbox;
        
        initView()
    }
    
    func getPationInfo(_ macId:String) -> PationInfo? {
        let sm = SessionManger.share()
        return sm?.pationInfos.object(forKey: macId) as? PationInfo
    }
    func initView(){
        if medicineBox == nil{
            return;
        }
        if pationInfo != nil && pationInfo!.name != nil && !pationInfo!.name.isEmpty{
            lbName.text = pationInfo?.name
        }else{
            lbName.text = "新设备";
        }
       
        var count = 0;
        var timeCount = 0
        for info in medicineBox!.list  {
            if !info.isEdited {
                count += 1
            }else{
                if info.scheme == nil || info.scheme.schemeList == nil || info.scheme.schemeList.count == 0 {
                    timeCount += 1
                }
            }
            
        }
        tfMBoxM.isHidden = count == 0
        tfMBoxM.text = "\(count)"
        
        tfTime.isHidden = timeCount == 0
        tfTime.text = "\(timeCount)"
        let sm = SessionManger.share()!
        
        if((sm.onlineMacString) != nil){
            let online = sm.onlineMacString.contains(medicineBox!.macId)
            lbOnline.text = "\(online ? "在线":"离线")"
        }
       
        let img = sm.pationImages.object(forKey: medicineBox!.macId) as? UIImage
        if img != nil {
             ImageUtils.showPhoto(with: img, andUIImageView: imgHead)
        }else{
            imgHead.image = UIImage(named: "默认头像.png")
        }
       
        
    }
    
  
}
