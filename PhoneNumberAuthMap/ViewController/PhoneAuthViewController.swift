//
//  PhoneAuthViewController.swift
//  PhoneNumberAuthMap
//
//  Created by ankita khare on 28/02/22.
//

import UIKit

class PhoneAuthViewController: UIViewController ,UITextFieldDelegate{
    
    private let phoneField: UITextField = {
       
        let field = UITextField()
        field.backgroundColor = .secondarySystemBackground
        field.placeholder  = "Phone Number"
        field.returnKeyType = .continue
        field.textAlignment = .center
        field.keyboardType = .numberPad
        return field
    }()

       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(phoneField)
        phoneField.frame = CGRect(x: 0, y: 0, width: 220, height: 50)
        phoneField.center = view.center
        phoneField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    /*func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          let s = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
          guard !s.isEmpty else { return true }
          let numberFormatter = NumberFormatter()
          numberFormatter.numberStyle = .none
          return numberFormatter.number(from: s)?.intValue != nil
     }*/
    
         
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text, !text.isEmpty{
            let number  = "+91\(text)"
            AuthManager.shared.startAuth(phoneNumber: number) {[weak self ] success in
                guard success else{return}
                DispatchQueue.main.async {
                    let vc   = SMSCodeViewController()
                    vc.title = "Enter OTP"
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }}
        return true
    }
}


    

