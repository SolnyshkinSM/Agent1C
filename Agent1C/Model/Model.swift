//
//  Model.swift
//  Agent1C
//
//  Created by Administrator on 06.11.2020.
//  Copyright © 2020 Administrator. All rights reserved.
//

struct ClientGroup: Decodable {
    let title: String
    let results: [Client]
}

class Client: Decodable {
    var name = ""
    var inn = ""
    var cpp = ""
}


struct SaleGroup: Decodable {
    let title: String
    let results: [Sale]
}

class Sale: Decodable {
    var name = ""
    var sum = 0
}
