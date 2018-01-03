//
//  ViewController.swift
//  EtherTicker1
//
//  Created by Michael Amalfitano on 7/1/17.
//  Copyright © 2017 Michael Amalfitano. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var EtherPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData(){
        EtherPrice.text = "fetching..."
        Alamofire.request("https://api.gdax.com/products/ETH-USD/book").responseJSON { response in
            if let data = response.data{
                self.dataDidFetched(data: data)
            }
        }
    }
    
    func dataDidFetched(data: Data){
        do{
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]{
                if let asksArray = json["asks"] as?[Any]{
                    if let priceArray = asksArray.first as? [Any]{
                        let price = priceArray.first as? String
                        EtherPrice.text = "$" + price!
                    }}}
        }catch{}
        
    }
    
    @IBAction func fetchData(_ sender: UIButton) {
        loadData()
    }
    
}

