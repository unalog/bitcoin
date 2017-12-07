//
//  ViewController.swift
//  Bitcoin
//
//  Created by una on 2017. 12. 7..
//  Copyright © 2017년 una. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var discriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    
    
    var vm = BitCoinChartViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        commonInit()
        vm.loadData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func commonInit(){
        
        _ = vm.description.asObservable()
            .bind(to: discriptionLabel.rx.text)
        _ = vm.name.asObservable()
            .bind(to: nameLabel.rx.text)
        _ = vm.unit.asObservable()
            .bind(to: unitLabel.rx.text)
        
        _ = vm.price.asObservable()
            .subscribe(onNext: { (price) in
                self.priceLabel.text = "\(price)"
            })
            
        
        
    }

}

