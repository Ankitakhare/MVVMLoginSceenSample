//
//  LoginViewModel.swift
//  MVVMLoginSceenSample
//
//  Created by ankita khare on 28/02/22.
//


import UIKit
import Foundation

class LoginViewModel {
    // MARK: - Stored Properties
    private let loginManager: LoginManager
    
    //Here our model notify that was updated
    private var credentials = Credentials() {
        didSet {
            username = credentials.username
            phonenumber = credentials.phonenumber
        }
    }
    
    private var username = ""
    private var phonenumber = ""
    
    var credentialsInputErrorMessage: Observable<String> = Observable("")
    var isUsernameTextFieldHighLighted: Observable<Bool> = Observable(false)
    var isPasswordTextFieldHighLighted: Observable<Bool> = Observable(false)
    var errorMessage: Observable<String?> = Observable(nil)
    
    
    init(loginManager: LoginManager) {
        self.loginManager = loginManager
    }
    
    //Here we update our model
    func updateCredentials(username: String, phonenumber: String, otp: String? = nil) {
        credentials.username = username
        credentials.phonenumber = phonenumber
    }
    
    
    func login() {
        loginManager.loginWithCredentials(username: username, phonenumber: phonenumber) { [weak self] (error) in
            guard let error = error else {
                return
            }
            
            self?.errorMessage.value = error.localizedDescription
        }
    }
    
    
    func credentialsInput() -> CredentialsInputStatus {
        if username.isEmpty && phonenumber.isEmpty {
            credentialsInputErrorMessage.value = "Please provide username and password."
            return .Incorrect
        }
        if username.isEmpty {
            credentialsInputErrorMessage.value = "Username field is empty."
            isUsernameTextFieldHighLighted.value = true
            return .Incorrect
        }
        if phonenumber.isEmpty {
            credentialsInputErrorMessage.value = "PhoneNumber field is empty."
            isPasswordTextFieldHighLighted.value = true
            return .Incorrect
        }
        return .Correct
    }
}

extension LoginViewModel {
    enum CredentialsInputStatus {
        case Correct
        case Incorrect
    }
}
