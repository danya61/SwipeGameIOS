//
//  myView.swift
//  GestureGameApp
//
//  Created by Danya on 13.10.16.
//  Copyright © 2016 Danya. All rights reserved.
//

import UIKit

class myView: UIView {

    var view : UIView!
    var nibName = "myView"
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    deinit {
    }
    
    @IBAction func `continue`(_ sender: AnyObject) {
    }
    
    
    func loadFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        var view2 = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view2
    }
    
    func setup() {
        view = loadFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    

}
