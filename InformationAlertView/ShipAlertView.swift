//
//  ShipAlertView.swift
//  ShipInfomation
//
//  Created by ApinunWewillapp03 on 4/22/2560 BE.
//  Copyright © 2560 smb. All rights reserved.
//

import UIKit

protocol AlertShowDelegate{
    func onActionForAlertOK()
    func onActionButtonRight()
    func onActionBtnLeft()
}

enum TYPE_ALERT : Int{
    case TYPE_ALERT_OK = 0
    case TYPE_ALERT_YES_NO = 1
}

@IBDesignable
class ShipAlertView : UIView{
    @IBOutlet weak var view : UIView!
    var typeAlert : TYPE_ALERT! = TYPE_ALERT.TYPE_ALERT_YES_NO
    @IBOutlet weak var btnRight: UIButton!
    @IBOutlet weak var btnLeft: UIButton!
    @IBOutlet weak var btnCenter: UIButton!
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var viewLineCenter : UIView!
    var delegate : AlertShowDelegate! = nil
    var onAlertOK : ()->Void = { }
    var onAlertRight : ()->Void = { }
    var onAlertLeft : ()->Void = { }
    static var shipAlertView : ShipAlertView! = nil
    
    static func onShowAlertOk(target:Any?,title:String,message:String,btnOKTitle:String,onActionOK:@escaping ()->Void){
        if let controller = target as? UIViewController{
            let screenSize: CGRect! = UIScreen.main.bounds
            let x = (screenSize.width - 300) / 2
            let y = (screenSize.height - 200) / 2
            let frameSize = CGRect.init(x: x, y: y, width: 300, height: 200)
            shipAlertView = ShipAlertView(frame: frameSize, title: title, message: message, btnOkTitle: btnOKTitle)
            controller.view.addSubview(shipAlertView)
            shipAlertView.onAlertOK = onActionOK
        }
    }
    
    static func onShowAlertYesNo(target:Any?,title:String,message:String,btnRightTitle:String,btnLeftTitle:String!,onActionRight:@escaping ()->Void,onActionLeft:@escaping ()->Void){
        if let controller = target as? UIViewController{
            let screenSize: CGRect! = UIScreen.main.bounds
            let x = (screenSize.width - 300) / 2
            let y = (screenSize.height - 200) / 2
            let frameSize = CGRect.init(x: x, y: y, width: 300, height: 200)
            
            shipAlertView = ShipAlertView.init(frame: frameSize, title: title, message: message, btnLeftTitle: btnLeftTitle, btnRightTitle: btnRightTitle)
            controller.view.addSubview(shipAlertView)
            shipAlertView.onAlertRight = onActionRight
            shipAlertView.onAlertLeft = onActionLeft
        }
    }
    
    var nibName : String!{
        return String.init(describing: self)
    }
    
    @IBAction func onClickLeft(_ sender: Any) {
        if delegate != nil{
            delegate.onActionBtnLeft()
        }
        
        ShipAlertView.onClicAlertLeft()
        self.dissmissFromSuperView()
    }
    
    class func onClicAlertOK(){
        shipAlertView.onAlertOK()
    }
    
    class func onClicAlertLeft(){
        shipAlertView.onAlertLeft()
    }
    
    class func onClicAlertRight(){
        shipAlertView.onAlertRight()
    }
    
    @IBAction func onClickCenter(_ sender: Any) {
        if delegate != nil{
            delegate.onActionForAlertOK()
        }
        ShipAlertView.onClicAlertOK()
        self.dissmissFromSuperView()
    }
    
    @IBAction func onClickRight(_ sender: Any) {
        if delegate != nil{
            delegate.onActionButtonRight()
        }
        
        ShipAlertView.onClicAlertRight()
        self.dissmissFromSuperView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.nibSetUP()
    }
    
    init(frame: CGRect,title:String,message:String,btnLeftTitle:String,btnRightTitle:String) {
        super.init(frame: frame)
        self.nibSetUP()
        self.typeAlert = TYPE_ALERT.TYPE_ALERT_YES_NO
        
        //set up view
        self.labelTitle.text = title
        self.labelMessage.text = message
        self.btnLeft.setTitle(btnLeftTitle, for: UIControlState.normal)
        self.btnRight.setTitle(btnRightTitle, for: UIControlState.normal)
        
        self.setUpViewByType()
    }
    
    init(frame: CGRect,title:String,message:String,btnOkTitle:String) {
        super.init(frame: frame)
        self.nibSetUP()
        self.typeAlert = TYPE_ALERT.TYPE_ALERT_OK
        
        //set update view 
        self.labelTitle.text = title
        self.labelMessage.text = message
        self.btnCenter.setTitle(btnOkTitle, for: UIControlState.normal)
        
        self.setUpViewByType()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.nibSetUP()
        self.setUpViewByType()
    }
    
    
    private func nibSetUP(){
        self.view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask =  [.flexibleWidth,.flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        self.view.layoutIfNeeded()
        self.addSubview(view)
    }
    
    private func setUpViewByType(){
        switch typeAlert.rawValue {
        case TYPE_ALERT.TYPE_ALERT_OK.rawValue:
            self.onSetViewForAlertOK()
            break
            
        case TYPE_ALERT.TYPE_ALERT_YES_NO.rawValue:
            self.onSetViewForAlertYesNo()
            break
        default:
            break
        }
    }
    
    func onSetViewForAlertOK(){
        self.btnLeft.isHidden = true
        self.btnRight.isHidden = true
        viewLineCenter.isHidden = true
        self.btnCenter.isHidden = false
    }
    
    func onSetViewForAlertYesNo(){
        viewLineCenter.isHidden = false
        self.btnLeft.isHidden = false
        self.btnRight.isHidden = false
        self.btnCenter.isHidden = true
    }
    
    private func loadViewFromNib() -> UIView{
        let nib = UINib(nibName: "ShipAlertView", bundle: nil)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
    
    private func dissmissFromSuperView(){
        UIView.animate(withDuration: 1, animations: {
            if self.superview != nil{
                self.view.removeFromSuperview()
                ShipAlertView.removeView()
            }
        }) { (isGrant) in
            
        }
    }
    
    class func removeView(){
        shipAlertView.removeFromSuperview()
    }
}
