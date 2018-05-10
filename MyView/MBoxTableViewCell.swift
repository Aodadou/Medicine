//
//  MBoxTableViewCell.swift
//  MedicineBox
//
//  Created by apple on 16/7/28.
//  Copyright © 2016年 jxm. All rights reserved.
// 药箱管理中的item

import UIKit

class MBoxTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var mInfo:MedicineInfo?
//    var vc:UIViewController?
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var lbName: UIButton!
    @IBOutlet weak var lbWarn: UILabel!
    
    @IBAction func Action(_ sender: AnyObject) {
//        let editVC:EditMedicineInfoVC = vc!.storyboard!.instantiateViewController(withIdentifier: "editMedicineInfo") as! EditMedicineInfoVC
//        editVC.medicine = mInfo
//        vc?.navigationController?.pushViewController(editVC, animated: true)
    }
    
    func initView(_ medicine:MedicineInfo){
//        vc = pvc
        mInfo = medicine
        if mInfo!.isEdited {
            lbName.setImage(nil, for: UIControlState())
            lbName.setTitle(mInfo!.name, for: UIControlState())
        }else{
            lbName.setImage(UIImage(named: "没有编辑提示小红点.png"), for: UIControlState())
            lbName.setTitle(" 未编辑的新药品", for: UIControlState())
        }
        
        if !mInfo!.isEdited{
            return
        }
        
        var isNotEnough = false
        var isOverDate = false
        let times = medicine.times
        let dos = medicine.dosage
        let total = (medicine.currentCount == nil) ? 0:Int(medicine.currentCount)
        let validityDate = medicine.validityPeriod
        
        var info = "("
        if total! < (2 * times * dos) || total! == 0{
            info += "药品数量不足"
            isNotEnough = true
        }
        if UtilSw.isOverDate(dateStr: validityDate!){
            isOverDate = true
            if info.contains("药品数量不足"){
                info += "，药品即将过期"
            }else{
                info += "药品即将过期"
            }
        }
        info += ")"
        
        if isNotEnough || isOverDate{
            self.lbWarn.isHidden = false
            self.btnRight.isHidden = true
            self.lbWarn.text = info
        }else{
            self.lbWarn.isHidden = true
            self.btnRight.isHidden = false
        }
        
    }
}
