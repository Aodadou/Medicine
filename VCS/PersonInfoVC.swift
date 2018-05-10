//
//  PersonInfoVC.swift
//  MedicineBox
//
//  Created by apple on 16/8/3.
//  Copyright © 2016年 jxm. All rights reserved.
//

import UIKit

class PersonInfoVC: ViewController {
    
    @IBAction func ActionBack(_ sender: AnyObject) {
        
    }
    
    
    
    @IBOutlet weak var btnGirl: UIButton!
    @IBOutlet weak var btnMan: UIButton!
    @IBOutlet weak var btnName: UIButton!
    @IBOutlet weak var btnHead: UIButton!
    @IBOutlet weak var btnBirth: UIButton!
    @IBOutlet weak var btnKeeper: UIButton!
    @IBOutlet weak var btnTreat: UIButton!
    @IBOutlet weak var btnOther: UIButton!
    
    var dialog:UIAlertView?
    var imagePicker:UIImagePickerController?
    var actionSheet:UIActionSheet?
    weak var selectedImage:UIImage?
    
    @IBAction func ActionByTag(_ sender: UIButton) {
        let tag:Int = sender.tag
        if tag == 1 {///HEAD
            
        }else if tag == 2 {///NAME
            
        }else if tag == 3 {///MAN
            
        }else if tag == 4 {///GIRL
            
        }else if tag == 5 {///BIRTH
            
        }else if tag == 6 {///LOCATION
            
        }else if tag == 7 {//OTHER
            
        }else if tag == 8 {///TREAT
            
        }else if tag == 9 {///KEEPER
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        UIImage 
        
    }

    override func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        
    }
}
