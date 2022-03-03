//
//  SMSCodeViewController.swift
//  PhoneNumberAuthMap
//
//  Created by ankita khare on 28/02/22.
//

import UIKit

class SMSCodeViewController: UIViewController ,UITextFieldDelegate{
        
        private let codeField: UITextField = {
           
            let field = UITextField()
            field.backgroundColor = .secondarySystemBackground
            field.placeholder  = "Enter Code"
            field.returnKeyType = .continue
            field.textAlignment = .center
            return field
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemBackground
            view.addSubview(codeField)
            codeField.frame = CGRect(x: 0, y: 0, width: 220, height: 50)
            codeField.center = view.center
            codeField.delegate = self
            // Do any additional setup after loading the view.
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            if let text = textField.text, !text.isEmpty{
                let code  = text
                AuthManager.shared.varifyCode(smsCode: code) {[weak self] success in
                    guard success else{return}
                    DispatchQueue.main.async {
                        let vc   = MapViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc,animated: true)
                    }
                }}
            return true
        }
    }


        

    
