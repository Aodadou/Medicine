import UIKit


class TokenSocket:NSObject,AsyncSocketDelegate{
    
    var data:Data?
    
    override init() {
        super.init()
        
    }
    
    convenience init(data:Data) {
        self.init()
        self.data = data
    }
    
    
    var tcpSocket:AsyncSocket?
    
    
    
//    func connectAndSend(){
//        self.tcpSocket = AsyncSocket(delegate: self)
//        
//        do{
//            try self.tcpSocket!.connect(toHost: HOST, onPort: UInt16(PUSHPORT))
//        }catch{
//            
//            GlobalMethod.toast("出错了")
//            
//        }
//        
//        
//    }
    
    func colse(){
        self.tcpSocket?.disconnect()
    }
    
    
    func onSocket(_ sock: AsyncSocket!, didConnectToHost host: String!, port: UInt16) {
        
        print("===========socket已连接=============")
        //timeout设为-1为永不超时
        //发送完有代理触发didWriteDataWithTag
        if data != nil{
            self.tcpSocket?.write(data, withTimeout: -1, tag: 0)
        }
        
    }
    
    func onSocket(_ sock: AsyncSocket!, didWriteDataWithTag tag: Int) {
        print("===========socket已发送=============")
        self.colse()
    }
    
    func onSocket(_ sock: AsyncSocket!, didRead data: Data!, withTag tag: Int) {
        
        print("===========socket已接收=============")
        
    }
    
    
    //MARK:服务端的方法，接收tcp连接
    func onSocket(_ sock: AsyncSocket!, didAcceptNewSocket newSocket: AsyncSocket!) {
        
    }
}
