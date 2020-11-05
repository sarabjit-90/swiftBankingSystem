//
//  accounts.swift
//  bankSystem
//
//  Created by Sarabjit on 2020-10-30.
//

import Foundation

class Accounts{
    var accNumber:Int
    var clientName:String
    var accType:String
    var balance:Double
    var clientPhone:Int
    
    init(accountNo:Int, name:String, type:String, bal:Double, phone:Int) {
        self.accNumber = accountNo
        self.clientName = name
        self.accType = type
        self.balance = bal
        self.clientPhone = phone
    }
    
    //Function to print client user acc
    func printDetail(){
        print("Account No: \(self.accNumber)\nClient Name: \(self.clientName)\nAccount Type: \(self.accType)\nBalance: \(self.balance)\nClient Phone: \(self.clientPhone)\n")
    }
    
    func fileFormat() -> String {
        let line = String(self.accNumber)+","+self.clientName+","+self.accType+","+String(self.balance)+","+String(self.clientPhone)+"\n"
        return line
    }
    
}
