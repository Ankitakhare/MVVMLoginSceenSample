//
//  ViewController.swift
//  MVVMLoginSceenSample
//
//  Created by ankita khare on 28/02/22.
//



import UIKit

class LoginViewController: UIViewController {
    // MARK: - Stored Properties
    var loginViewModel: LoginViewModel!
    
    //MARK: - IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginErrorDescriptionLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    
    //MARK: - ViewController States
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setupButton()
        bindData()
    }
    
    
    //MARK: - IBActions
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        //Here we ask viewModel to update model with existing credentials from text fields
        loginViewModel.updateCredentials(username: usernameTextField.text!, phonenumber: passwordTextField.text!)
        
        //Here we check user's credentials input - if it's correct we call login()
        switch loginViewModel.credentialsInput() {
            
        case .Correct:
            login()
        case .Incorrect:
            return
        }
    }
    
    
    func bindData() {
            loginViewModel.credentialsInputErrorMessage.bind { [weak self] in
                self?.loginErrorDescriptionLabel.isHidden = false
                self?.loginErrorDescriptionLabel.text = $0
            }
            
            loginViewModel.isUsernameTextFieldHighLighted.bind { [weak self] in
                if $0 { self?.highlightTextField((self?.usernameTextField)!)}
            }
            
            loginViewModel.isPasswordTextFieldHighLighted.bind { [weak self] in
                if $0 { self?.highlightTextField((self?.passwordTextField)!)}
            }
            
            loginViewModel.errorMessage.bind {
                guard let errorMessage = $0 else { return }
                //Handle presenting of error message (e.g. UIAlertController)
            }
    }
    
    
    func login() {
        loginViewModel.login()
    }
    
    
    func setupButton() {
        loginButton.layer.cornerRadius = 5
    }
    
    
    func setDelegates() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    
    func highlightTextField(_ textField: UITextField) {
        textField.resignFirstResponder()
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.cornerRadius = 3
    }
}


//MARK: - Text Field Delegate Methods
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        loginErrorDescriptionLabel.isHidden = true
        usernameTextField.layer.borderWidth = 0
        passwordTextField.layer.borderWidth = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
