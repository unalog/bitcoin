//
//  WalletViewController.swift
//  Bitcoin
//
//  Created by una on 2017. 12. 8..
//  Copyright © 2017년 una. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class WalletViewController: UIViewController {

    
    @IBOutlet weak var coinTable: UITableView!
    @IBOutlet weak var acountLabel: UILabel!
    @IBOutlet weak var refillButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var sellButton: UIButton!
    @IBOutlet weak var buyPriceLabel: UILabel!
    @IBOutlet weak var sellPriceLabel: UILabel!
    
    let vm = WalletViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commonInit()
        // Do any additional setup after loading the view.
        
        vm.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func commonInit(){
        _ = vm.acount.asObservable()
            .map{$0.description}
            .bind(to: acountLabel.rx.text)
        
        _ = vm.buyPrice.asObservable()
            .map{$0.description}
            .bind(to: buyPriceLabel.rx.text)
        
        _ = vm.sellPrice.asObservable()
            .map{$0.description}
            .bind(to: sellPriceLabel.rx.text)
        
       
        _ = buyButton.rx.tap
            .subscribe(onNext:{
               self.vm.buy()
            })
        
        _ = sellButton.rx.tap
            .subscribe(onNext:{
               self.vm.sell()
            })
        _ = refillButton.rx.tap
            .subscribe(onNext:{
                self.vm.addMoney(money: 100000000)
            })

        _ = vm.acount.asObservable()
            .map{ $0 > 0 }
            .asObservable()
            .bind(to: refillButton.rx.isHidden)
        
        
        
        
        _ = Observable.combineLatest(vm.acount.asObservable(), vm.buyPrice.asObservable())
            {  $0 > $1 }
            .bind(to: buyButton.rx.isEnabled)
        
//        _ = Observable.combineLatest(vm.acount.asObservable(), vm.sellPrice.asObservable())
//        { acount, price -> Bool in
//            return acount < price
//            }
//            .bind(to: sellButton.rx.isEnabled)
        
        



    }
}

