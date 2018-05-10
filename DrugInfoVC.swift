//
//  DrugInfoVC.swift
//  MedicineBox
//
//  Created by apple on 16/9/8.
//  Copyright © 2016年 jxm. All rights reserved.
//

import UIKit

class DrugInfoVC: ViewController,ASIHTTPRequestDelegate {

    var info:MedicineInfo?
    var alertInfo: UIAlertView?
    override func viewDidLoad() {
        super.viewDidLoad()
        info = infoQR
        ASIHTTPHelper.requestDataByGET(fromURL: info!.imgUrl, andDelegate: self)
        
       lbName.text = info?.name
        lbInfo.text = info?.drugDescription
        
    }
    @IBAction func ActionBack(_ sender: AnyObject) {
        backVC()
    }
    
    
    @IBOutlet weak var imgHead: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbInfo: UILabel!
    
    func showInfo(_ tag:Int) -> Void {
        var title = ""
        var msg = ""
        if tag == 0 {
            title = "药品信息"
            msg=info!.drugDescription
        }else{
            title = "说明书"
            msg=info!.message
            
        }
        print(msg)
        
        if alertInfo == nil {
            alertInfo = UIAlertView.init(title: title, message: msg, delegate: self, cancelButtonTitle: "确定")
        }else{
            alertInfo?.title = title
            alertInfo?.message = msg
        }
       
        //alertInfo?.frame = CGRectMake( CGRectGetMidX(alertInfo!.frame), CGRectGetMidY(alertInfo!.frame), CGRectGetWidth(alertInfo!.frame), 320)
        alertInfo?.show()
    }
    @IBAction func ActionShow(_ sender: UIButton) {
        showInfo(sender.tag)
    }

    @IBAction func ActionOK(_ sender: AnyObject) {
        let vs = self.navigationController!.viewControllers
        for v in vs {
            if v.isKind(of: EditMedicineInfoVC.self) {
                self.navigationController?.popToViewController(v, animated: true)
            }
        }
    }
    func requestFinished(_ request: ASIHTTPRequest!) {
        let data = request.responseData()
        let img = UIImage.init(data: data!)
        imgHead.image = img
    }
}
