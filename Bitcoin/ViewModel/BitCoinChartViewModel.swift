//
//  BitCoinChartViewModel.swift
//  Bitcoin
//
//  Created by una on 2017. 12. 7..
//  Copyright © 2017년 una. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON

class Value:Any{
    
    var x:Int
    var y:Int
    
    init(x:Int, y:Int) {
        
        self.x = x
        self.y = y
    }
    
}
class BitCoinChartViewModel: Any {
    
    var description:Variable<String>
    var status:Variable<String>
    var name:Variable<String>
    var unit:Variable<String>
    var period:Variable<String>
    var price:Variable<Double>
    var value:Variable<Array<Value>>
    
    init() {
        
        description = Variable<String>("")
        status = Variable<String>( "")
        name = Variable<String>( "")
        unit = Variable<String>("")
        period = Variable<String>("")
        price = Variable<Double>(0)
        value = Variable<Array<Value>>([])
        
        
    }
    
    func loadData() {
        
        _ = NetworkManager.requestChartData()
            .asObservable()
            .subscribe(onNext: { (data) in
                if let json = data as? Data{
                    
                    if let parsing = try? JSON(data:json){
                        
                        self.description.value = parsing["description"].stringValue
                        self.status.value = parsing["status"].stringValue
                        self.name.value = parsing["name"].stringValue
                        self.unit.value = parsing["unit"].stringValue
                        self.period.value = parsing["pariod"].stringValue
//                        var val = parsing["value"]
//                        
//                        for (key,subJson):(String, JSON) in val {
//                            //Do something you want
//                        }
                        
                    }
                }
            })
        
        
        _ = NetworkManager.requestTickerData()
            .asObservable()
            .subscribe(onNext: { (data) in
                if let json = data as? Data{
                    
                    if let parsing = try? JSON(data:json){
                        
                        print(parsing)
                        
                        self.price.value = parsing["KRW"]["last"].doubleValue
                        //"KRW" : {"15m" : 494436.55, "last" : 494436.55, "buy" : 494302.27, "sell" : 494436.55,  "symbol" : "₩"},
                        
                    }
                }
            })
        
                
    }

}
