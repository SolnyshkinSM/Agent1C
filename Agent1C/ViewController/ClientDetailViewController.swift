//
//  ClientDetailViewController.swift
//  Agent1C
//
//  Created by Administrator on 09.11.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

import UIKit

class ClientDetailViewController: UIViewController {
    
    var client: Client?

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var innLabel: UILabel!
    @IBOutlet var cppLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let client = client {
            nameLabel.text = client.name
            innLabel.text = client.inn
            cppLabel.text = client.cpp
        }
    }
}
