//
//  NetworkManager.swift
//  Bitcoin
//
//  Created by una on 2017. 12. 7..
//  Copyright © 2017년 una. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

class NetworkManager: Any {

    static func requestChartData()->Observable<Any>{
        
        
        return Observable<Any>.create({ (observable) -> Disposable in
            
            let url = "https://api.blockchain.info/charts/transactions-per-second"
            let parameters: Parameters = ["timespan": "5weeks" ,"rollingAverage":"8hours" ,"format":"json"]
            
            Alamofire.request(url, parameters: parameters)
                .responseJSON(completionHandler: { (response) in
                    
                    switch response.result{
                    case .success:
                        
                        if let data = response.data{
                            observable.onNext(data)
                            observable.onCompleted()
                        }
                    case .failure(let error):
                        print("status code is: \(error._code))")
                        observable.onError(error)
                    }
                })
            return Disposables.create {
            }
        })
    
    }
    static func requestTickerData()->Observable<Any>{
        
        
        return Observable<Any>.create({ (observable) -> Disposable in
            
            let url = "https://blockchain.info/ko/ticker"
            
            
            Alamofire.request(url)
                .responseJSON(completionHandler: { (response) in
                    
                    switch response.result{
                    case .success:
                        
                        if let data = response.data{
                            observable.onNext(data)
                            observable.onCompleted()
                        }
                    case .failure(let error):
                        print("status code is: \(error._code))")
                        
                        observable.onError(error)
                    }
                })
            
            
            return Disposables.create {
                
            }
        })
    }
    
}
