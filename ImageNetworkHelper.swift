//
//  ImageNetworkHelper.swift
//  MedicineBox
//
//  Created by apple on 16/8/13.
//  Copyright © 2016年 jxm. All rights reserved.
//

import UIKit
//#define URL_GET_DPHOTO(IMAGE_SERVER,TOKEN) [NSString stringWithFormat:@"http://%@/getDeviceImage?token=%@",IMAGE_SERVER,TOKEN]
//
//#define URL_UP_DPHOTO(IMAGE_SERVER,TOKEN) [NSString stringWithFormat:@"http://%@/upDeviceImage?token=%@",IMAGE_SERVER,TOKEN]
//
//#define URL_GET_UPHOTO(IMAGE_SERVER,TOKEN) [NSString stringWithFormat:@"http://%@/getUserImage?token=%@",IMAGE_SERVER,TOKEN]
//
//#define URL_UP_UPHOTO(IMAGE_SERVER,TOKEN) [NSString stringWithFormat:@"http://%@/upUserImage?token=%@",IMAGE_SERVER,TOKEN]
//
//#define TOKEN_DEVICE(name,pwd,mac) [NSString stringWithFormat:@"name=%@&pwd=%@&appId=24&deviceSn=%@",name,pwd,mac]
//#define TOKEN_USER(name,pwd) [NSString stringWithFormat:@"name=%@&pwd=%@&appId=24",name,pwd]
class ImageNetworkHelper: NSObject {

    class func  URL_GET_DPHOTO(_ IMAGE_SERVER:String,TOKEN:String)->String{
        return "http://\(IMAGE_SERVER)/getDeviceImage?token=\(TOKEN)"
    }
    
    class func  URL_UP_DPHOTO(_ IMAGE_SERVER:String,TOKEN:String)->String{
        return "http://\(IMAGE_SERVER)/upDeviceImage?token=\(TOKEN)"
    }
    
    
    class func  URL_GET_UPHOTO(_ IMAGE_SERVER:String,TOKEN:String)->String{
        return "http://\(IMAGE_SERVER)/getUserImage?token=\(TOKEN)"
    }
    class func  URL_UP_UPHOTO(_ IMAGE_SERVER:String,TOKEN:String)->String{
        return "http://\(IMAGE_SERVER)/upUserImage?token=\(TOKEN)"
    }
    
    
    class func  TOKEN_DEVICE(_ name:String,pwd:String,mac:String,appid:Int)->String{
        return ThreeDES.encrypt(withDefautKey: "name=\(name)&pwd=\(pwd)&appId=\(appid)&deviceSn=\(mac)")
    }
    
    class func  TOKEN_USER(_ name:String,pwd:String,appid:Int)->String{
        return ThreeDES.encrypt(withDefautKey: "name=\(name)&pwd=\(pwd)&appId=\(appid)")
    }
    
}
