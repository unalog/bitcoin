//
//  ValueViewController.swift
//  Bitcoin
//
//  Created by una on 2017. 12. 8..
//  Copyright © 2017년 una. All rights reserved.
//

import UIKit
import RxCocoa

class ValueViewController: UIViewController {

    
    @IBOutlet weak var valueTable: UITableView!
    
    let vm = BitCoinChartViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        commonInit()
        
        vm.loadData()
        // Do any additional setup after loading the view.
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
        
       
        _ = vm.chart.asObservable()
            .bind(to: valueTable.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self))({ (row, chart, cell) in
                cell.textLabel?.text = "\(chart.x), \(chart.y)"
            })
        
        
        
    }
    
}
