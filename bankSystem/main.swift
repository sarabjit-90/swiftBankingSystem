//
//  main.swift
//  bankSystem
//
//  Created by Sarabjit on 2020-10-30.
//

import Foundation

//create an empty array of bank accounts
var accounts = [Accounts]()

//defining the location of the file
let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

//defining the file by its name and txt as extension
let fileURL = URL(fileURLWithPath: "bank_data", relativeTo: directoryURL).appendingPathExtension("txt")


//Main menu
func mainMenu() {
    let options = """
    Choose Following options:
    1 : Start Services
    0 : Exit
    """
    print(options)
    let opt = Int(readLine()!)!
    switch opt {
    case 0:
        break
    case 1:
        inMenu()
    default:
        print("You choose wrong value! Please try again!\n")
        mainMenu()
    }
}
//inner Menu
func inMenu() {
    let innerOptions = """
    1 : Add New Account
    2 : Transactions
    3 : Enquery
    4 : View All accounts Information
    0 : Exit
    """
    print(innerOptions)
    let inOpt = Int(readLine()!)!
    switch inOpt {
    case 0:
        break
    case 1:
        newAccount()
    case 2:
        transactions()
    case 3:
        searchBy()
    case 4:
        for ac in 0..<accounts.count{
            accounts[ac].printDetail()
        }
    default:
        print("\nYou choose wrong option, Try again!\n")
        inMenu()
    }
}

//transaction function for account transactions
func transactions() {
    let text = """
    1 : Deposite
    2 : Withdraw
    3 : Change Info
    4 : Money Transfer
    5 : Paybills/utility actions
    6 : Go to Main Menu
    0 : Exit
    """
    print(text)
    let accOpts = Int(readLine()!)!
    switch accOpts {
    case 0:
        break
    case 1:
        deposite()
    case 2:
        withdraw()
    case 3:
        changes()
    case 4:
        transfer()
    case 5:
        paybills()
    default:
        print("\nYou choose wrong value, Please try again!\n")
        transactions()
    }
}
// transfer money from one to another accounts
func transfer() {
    print("Please enter account no from which you want to transfer:")
    let accOne = Int(readLine()!)!
    print("Please enter account no to which you want to transfer:")
    let accTwo = Int(readLine()!)!
    var crntTwo = 0.0
    var indexTwo = 0
    var crntOne = 0.0
    var indexOne = 0
    for an in 0..<accounts.count{
        if accounts[an].accNumber == accOne{
            crntOne = accounts[an].balance
            indexOne = an
        }
        if accounts[an].accNumber == accTwo{
            crntTwo = accounts[an].balance
            indexTwo = an
        }
    }
    print("Please enter amount")
    let tAmt = Double(readLine()!)!
    crntOne -= tAmt
    accounts[indexOne].balance = crntOne
    crntTwo += tAmt
    accounts[indexTwo].balance = crntTwo
    savingData()
}
// function paybills
func paybills() {
    print("Please enter Account no. to Bill: ")
    let acNo = Int(readLine()!)!
    var curnt = 0.0
    var index = 0
    for an in 0..<accounts.count{
        if accounts[an].accNumber == acNo{
            curnt = accounts[an].balance
            index = an
        }
    }
    print("Add amount that you want to Pay: ")
    let amt = Double(readLine()!)!
    curnt -= amt
    accounts[index].balance = curnt
    savingData()
}
// function for change info
func changes() {
    print("Please enter account number to change info: ")
    let chAno = Int(readLine()!)!
    for iAc in 0..<accounts.count{
        if accounts[iAc].accNumber == chAno{
            print("You want to change Client Name? y/n")
            let cNm = readLine()
            if cNm == "y"{
                print("Enter new Name: ")
                let nName = readLine()
                accounts[iAc].clientName = nName!
            }
            print("You want to change Client Phone? y/n")
            let cPn = readLine()
            if cPn == "y"{
                print("Enter new Phone: ")
                let npn = Int(readLine()!)!
                accounts[iAc].clientPhone = npn
            }
            
        }
    }
    savingData()
}
//function for deposite money
func deposite() {
    print("Please enter Account no.: ")
    let acNo = Int(readLine()!)!
    var curnt = 0.0
    var index = 0
    for an in 0..<accounts.count{
        if accounts[an].accNumber == acNo{
            curnt = accounts[an].balance
            index = an
        }
    }
    print("Add amount that you want to add: ")
    let amt = Double(readLine()!)!
    curnt += amt
    accounts[index].balance = curnt
    savingData()
    
}

// function to withdraw money
func withdraw() {
    print("Please enter Account no.: ")
    let aNu = Int(readLine()!)!
    var crBal = 0.0
    var crIndex = 0
    for acr in 0..<accounts.count{
        if accounts[acr].accNumber == aNu{
            crBal = accounts[acr].balance
            crIndex = acr
        }
    }
    print("Please enter amount that you want to withdraw: ")
    let wAmt = Double(readLine()!)!
    crBal -= wAmt
    accounts[crIndex].balance = crBal
    savingData()
}

//get the data from the defind file wihch on the define location
func readingFromFile(){
    do {
     // Get the saved data
     let savedData = try Data(contentsOf: fileURL)
     // Convert the data back into a string
        if String(data: savedData, encoding: .utf8) != nil {
        //print(savedString)
        let data = String(decoding: savedData, as: UTF8.self)
        let lines = data.split(whereSeparator: \.isNewline)
        for line in lines{
            //split each line into words which are fields
            let fields = line.components(separatedBy: ",")

            //create an object of Product assuming the seprated words are the inputs
            let acc = Accounts(accountNo: Int(fields[0])!, name: fields[1], type: fields[2], bal: Double(fields[3])!, phone: Int(fields[4])!)
            
            accounts.append(acc)//add the object acc to the array of accounts
        }
     }
    } catch {
     // Catch any errors
     print("Unable to read the file")
    }
}

//function to save data to a file
func savingData(){
    //merging all lines form the array in one string
    var myString:String = ""
    for ac in accounts{
        myString += ac.fileFormat()
    }
    //convert from string to data
    let data = myString.data(using: .utf8)
    do {
        //write the data into the file
        try data?.write(to: fileURL)
        print("File saved: \(fileURL.absoluteURL)")
    } catch {
     // Catch any errors
        print(error.localizedDescription)
    }
}
//search account by account number
func searchBy() {
    print("Enter valid account number to view detail: ")
    let accNo = Int(readLine()!)!
    for ac in 0..<accounts.count{
        if accounts[ac].accNumber == accNo{
            accounts[ac].printDetail()
        }
    }
}
//create new account
func newAccount(){
    while(true){
       // print("Enter Acc no: ")
        var accNum = accounts.count
        accNum = accNum + 1
        print("Enter Client Name: ")
        let cName = readLine()!
        print("Enter Account Type: ")
        let aType = readLine()!
        print("Enter Account Balance: ")
        let aBal = Double(readLine()!)!
        print("Enter Client Phone: ")
        let cPh = Int(readLine()!)!
        let obj = Accounts(accountNo: accNum, name: cName, type: aType, bal: aBal, phone: cPh)
        accounts.append(obj)
        print("Do you want to add more Account? y/n")
        let answer = readLine()!
        if answer == "n"{
            savingData()
            break
        }
    }
}

readingFromFile()
//savingData()


//savingData()
mainMenu()
