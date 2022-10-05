//
//  LoginPageViewModel.swift
//  Ecommerce
//
//  Created by JunHyuk Lim on 4/10/2022.
//

import SwiftUI

class LoginPageViewModel : ObservableObject {
    
    //Login Properties
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var showPassword : Bool = false
    
    //Register Properties
    @Published var registerUser : Bool = false
    @Published var reEnterPassword : String = ""
    @Published var showReEnterPassword : Bool = false
    
    //Log Status
    @AppStorage("logStatus") var logStatus: Bool = false
    
    func login() {
        withAnimation {
            logStatus = true
        }
    }
    
    func register() {
        withAnimation {
            logStatus = true
        }
    }
    
    func forgotPassword() {
        
    }
    
}
