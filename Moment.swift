struct MomentBank {
  private let password: String

  init(password: String, _ initialDeposit: Double) {
    self.password = password
    makeDeposit(ofAmount: initialDeposit)
  }

  func isValid(_ enteredPassword: String) -> Bool {
    if enteredPassword == self.password {
      return true
    } else {
      return false
    }
  }

  private var balance: Double = 0 {
    willSet {
       print("\(newValue)")
    } 
    didSet {
      if balance < 100 {
      displayLowBalanceMessage()
      }
    }
  }
  static let depositBonusRate = 0.01

  private func finalDepositWithBonus(fromInitialDeposit deposit: Double) -> Double {
    return  deposit + (deposit * MomentBank.depositBonusRate)
  }

  mutating func makeDeposit(ofAmount depositAmount: Double) {
    let depositWithBonus = finalDepositWithBonus(fromInitialDeposit: depositAmount)
    balance += depositWithBonus
    print("Making a deposit of $ \(depositAmount) with a bonus rate. The final amount deposited is \(depositWithBonus)")
  }

  func displayBalance(usingPassword password: String) {
    if !isValid(password) {
       print("Error: Invalid password. Cannot retrieve balance.")
       return
    } else {
      print("Your current balance is $\(balance)")
    }
  }
  
  mutating func makeWithdrawal(ofAmount withdrawalAmount: Double, usingPassword password: String) {
    if !isValid(password) {
       print("Error: Invalid password. Cannot make withdrawal.")
       return
    } else {
      balance -= withdrawalAmount
      print("Making a $\(withdrawalAmount) withdrawal")
    }
  }

  private func displayLowBalanceMessage() {
    print("Alert: Your balance is under $100")
  }

}

var myAccount = MomentBank(password: "1234", 500)
myAccount.makeDeposit(ofAmount: 50)
myAccount.makeWithdrawal(ofAmount: 100, usingPassword: "1234")
myAccount.displayBalance(usingPassword: "1234")

