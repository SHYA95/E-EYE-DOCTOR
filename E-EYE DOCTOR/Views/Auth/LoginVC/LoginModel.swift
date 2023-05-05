//
//  LoginModel.swift
//  MyWalletIos
//
//  Created by AliSharaf on 06/04/2023.
//

import Foundation

struct LoginModel: Codable {
    let id: String
    let userName: String
    let phone: String
    let status: Int
    let balance: Int
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userName
        case phone = "Phone"
        case status = "Status"
        case balance = "Balance"
        case token = "Token"
    }
}

