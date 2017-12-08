//
//  WallertViewModel.swift
//  Bitcoin
//
//  Created by una on 2017. 12. 8..
//  Copyright © 2017년 una. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON

struct Wallet {
    var acount:Double
}


class WalletViewModel: Any {

    var wallet = Variable<Wallet>(Wallet(acount:0))
    var acount = Variable<Double>(0)
    var buyPrice = Variable<Double>(0)
    var sellPrice = Variable<Double>(0)
    

    init() {
        
        
        _ = wallet.asObservable()
            .subscribe(onNext: { (wallet) in
                self.acount.value = wallet.acount
            })
       
        
    }
    
    func loadData()  {
        
        _ = NetworkManager.requestTickerData()
            .asObservable()
            .subscribe(onNext: { (data) in
                
                if let json = data as? Data{
                    
                    if let parsing = try? JSON(data:json){
                        
                        // print(parsing)
                        
                        self.buyPrice.value = parsing["KRW"]["buy"].doubleValue
                        self.sellPrice.value = parsing["KRW"]["sell"].doubleValue
                        //"KRW" : {"15m" : 494436.55, "last" : 494436.55, "buy" : 494302.27, "sell" : 494436.55,  "symbol" : "₩"},
                        
                    }
                }
            })
    }
    func addMoney(money:Double)  {
        
        self.wallet.value.acount += money
    }
    func subMoney(money:Double) {
        
        
    }
    func buy() {
        self.wallet.value.acount -= buyPrice.value
    }
    func sell(){
        self.wallet.value.acount += sellPrice.value
    }
    
}
