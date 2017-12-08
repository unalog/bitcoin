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

struct Chart {
    var x:Double
    var y:Double
}

class BitCoinChartViewModel: Any {
    
    var description:Variable<String> = Variable<String>("")
    var status:Variable<String> = Variable<String>( "")
    var name:Variable<String> = Variable<String>( "")
    var unit:Variable<String> = Variable<String>("")
    var period:Variable<String> = Variable<String>("")
    var price:Variable<Double> = Variable<Double>(0)
    var chart:Variable<Array<Chart>> = Variable<Array<Chart>>([])
  
    
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
                        
                        var values:Array<Chart> = []
                        
                        let val = parsing["values"]

                        for (_,subJson):(String, JSON) in val {
                            //Do something you want
                            
                            let x = subJson["x"].doubleValue
                            let y = subJson["y"].doubleValue
                            let chart = Chart(x: x, y: y)
                            
                            
                            values.append(chart)
                        }
                        
                        self.chart.value.append(contentsOf: values)
                        
                    }
                }
            })
        
        
        _ = NetworkManager.requestTickerData()
            .asObservable()
            .subscribe(onNext: { (data) in
                if let json = data as? Data{
                    
                    if let parsing = try? JSON(data:json){
                        
                       // print(parsing)
                        
                        self.price.value = parsing["KRW"]["last"].doubleValue
                        //"KRW" : {"15m" : 494436.55, "last" : 494436.55, "buy" : 494302.27, "sell" : 494436.55,  "symbol" : "₩"},
                        
                    }
                }
            })
        
                
    }

}
