//
//  RecordTableViewCell.swift
//  MedicineBox
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 jxm. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    
    @IBOutlet weak var drugName: UILabel!
    
    @IBOutlet weak var lbTime: UILabel!
    
    @IBOutlet weak var lbState: UILabel!
    
    @IBOutlet weak var imgUp: UIImageView!
    
    @IBOutlet weak var imgDown: UIImageView!
    
    let strs = ["未用药","按时用药","非按时用药","未用药","非按时用药"]
    let imgNames = ["没有取药","按时取药","延时取药","没有取药","延时取药"]
    
    var mRecord:MedicationRecord?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    ///MARK:-val -1,0,1,2
//    func setViewHeadOrEnd(val:Int){
//        imgDown.hidden = val == -1 || (val == 2)
//        imgUp.hidden = val == 1 || (val == 2)
//        
//    }
//    
    func initView(_ pos:Int,sum:Int,record:MedicationRecord){
        mRecord = record
        imgUp.isHidden = (pos == sum - 1)
        imgDown.isHidden = pos == 0
        
        //服药情况，未取出0，按时取出1，延时取出2，提前取出3
        imgIcon.image = UIImage(named: imgNames[Int(record.situation)])
        lbState.text = strs[Int(record.situation)]
        drugName.text = record.name
        if record.takingTime.characters.count >= 10 {
            lbTime.text = record.takingTime.substring(10, length: 5);
        }
        
    }
}
