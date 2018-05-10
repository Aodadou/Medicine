//
//  UtilSw.swift
//  MedicineBox
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 jxm. All rights reserved.
//

import UIKit

let d = Date()
let zone = TimeZone(secondsFromGMT: +28800)
let time = zone!.secondsFromGMT(for: d)
let now = d.addingTimeInterval(TimeInterval(time))

extension String {
    func substring(_ start:Int,end:Int)->String{
        let index = self.characters.index(self.startIndex, offsetBy: start)
        let endIndex = self.characters.index(self.startIndex, offsetBy: end+1)
        
        return self.substring(with: Range<Index>(index..<endIndex))
    }
    
    func substring(_ start:Int,length:Int)->String{
        let index = self.characters.index(self.startIndex, offsetBy: start)
        let endIndex = self.characters.index(self.startIndex, offsetBy: start+length+1)
        
        return self.substring(with: Range<Index>(index..<endIndex))
    }
}


class UtilSw: NSObject {
    ///MARK:HH:mm 转化为分钟数
    class func travelTime(_ time:SchemeTime?)->Int{
        
        if time != nil {
            return time!.hour*60 + time!.minute
        }
        return 0
    }
    
    ///MARK:对HH:mm数组排序
    class func sortStrTime(_ array:[SchemeTime])->[SchemeTime]{
        if array.count == 1 {
            return array;
        }
        var temp:[SchemeTime] = Array.init(repeating: SchemeTime(hour: 0, minute: 0), count: array.count)
        for a in array {
            var pos = 0
            for b in array {
                let a1 = travelTime(a)
                let b2 = travelTime(b)
                if a1 > b2 {
                    pos = pos + 1
                }else{
                    
                }
            }
            temp[pos] = a
        }
        
        
        return temp
    }
    
    
    /// 根据父视图实际大小和子视图的尺寸比例来计算子视图在父视图中的frame
    ///
    /// :param:diction ＝ 0剧中，1左中，2右中，3上中 ，4下中
    /// :return: CGRect
    class func calcViewRectInParent(_ parent:UIView, subView:UIView,diction:Int) -> CGRect{
        let height = subView.frame.size.height
        let width = subView.frame.size.width
        let oH = parent.frame.size.height
        let oW = parent.frame.size.width
        let rate:CGFloat = height / width
        var rH:CGFloat = 0.0
        var rW:CGFloat = 0.0
        
        if oH > rate * oW {
            rW = oW
            rH = rate * oW
        }else{
            rW = oH / rate
            rH = oH
        }
        if diction == 1 {//左中
            return CGRect(x: 0, y: (oH - rH) / 2, width: rW,height: rH)
        }else  if diction == 2 {//右中
            return CGRect(x: (oW - rW), y: (oH - rH) / 2, width: rW,height: rH)
        }else  if diction == 3 {//上中
            return CGRect(x: (oW - rW) / 2, y: 0, width: rW,height: rH)
        }else  if diction == 4 {//下中
            return CGRect(x: (oW - rW) / 2, y: (oH - rH), width: rW,height: rH)
        }else{//剧中
            return CGRect(x: (oW - rW) / 2, y: (oH - rH) / 2, width: rW,height: rH)
        }
    }
    
//    //从沙盒中通过Id取得图片
//    +(UIImage*)readImageFromSandBoxByDeviceId:(NSString*)did{
//    if (nil == did) {
//    return nil;
//    }
//    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *filePath = [[path objectAtIndex:0] stringByAppendingPathComponent:did ];
//    NSData *data = [NSData dataWithContentsOfFile:filePath];
//    UIImage *tempImage;
//    
//    tempImage = [UIImage imageWithData:data scale:200];
//    
//    if (tempImage == nil) {
//    tempImage = [UIImage imageNamed:@"默认头像.png"];
//    }
//    return  tempImage;
//    }

    
    class func readImageFromSandBoxByDeviceId(_ did:String) -> UIImage {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let filePath = path[0]
        let data = try? Data(contentsOf: URL(fileURLWithPath: filePath+"/"+did))
        if data == nil {
             return UIImage.init(named:"默认头像.png" )!
        }
        var img = UIImage.init(data: data!)
        if img == nil {
            img = UIImage.init(named:"默认头像.png" )
        }
        return img!
    }
    
    class func saveImageToDocument(_ image:UIImage, imageName:String){
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let filePath = path[0] + ("/"+imageName)
        do {
        try UIImagePNGRepresentation(image)!.write(to: URL(fileURLWithPath: filePath), options: .atomicWrite)
        }catch{
            
        }
        
    }
    
//    +(void)saveImageToDocument:(UIImage *)image imageName:(NSString *)imageName
//    {
//    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    NSString *filePath = [[paths objectAtIndex:0]stringByAppendingPathComponent:[NSString stringWithFormat:imageName,nil]];  // 保存文件的名称
//    [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
//    }
    
    static func isOverDate(dateStr:String) -> Bool{
        
        if dateStr.isEmpty {
            return false
        }
        
        if dateStr.contains("(药品即将过期)"){
            let newStr = dateStr.substring(from: dateStr.index(dateStr.startIndex, offsetBy: 8))
            print(newStr)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let endDate = dateFormatter.date(from: dateStr)
        let beginDate = Date()
        
        let gregorian = NSCalendar(calendarIdentifier: .gregorian)
        var result = gregorian?.components(.day, from: beginDate, to: endDate!, options: NSCalendar.Options(rawValue: 0))
        if result!.day! < 30{
            return true
        }
        
        return false
        
    }
    
    static func isNoEnoughMedicine(medicine:MedicineInfo) -> Bool{
        let dos = Int(medicine.dosage)
        let times = Int(medicine.times)
        let sum = Int(medicine.currentCount)
        if (sum! < 2 * (dos * times)){
            return true
        }
        return false
    }
    
    enum AlertViewType {
        case overDate
        case noEnough
    }
    
    static func createAlert(medicine:MedicineInfo,alertType:AlertViewType,handler:((UIAlertAction) -> Void)? = nil) -> UIAlertController{
        var alert:UIAlertController?
        if alertType == .overDate {
            alert = UIAlertController(title: "提示", message: "药品\(medicine.name!)数量不足", preferredStyle: .alert)
        }else if alertType == .noEnough{
            alert = UIAlertController(title: "提示", message: "药品\(medicine.name!)即将过期", preferredStyle: .alert)
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "去编辑", style: .default, handler: handler)
        alert!.addAction(cancelAction)
        alert!.addAction(okAction)
        
        
        return alert!
    }
    
//    static func createAlertView(medicine:MedicineInfo) -> MyAlertView{
//
//    }
    

}
