//
//  LoginPage.swift
//  Ecommerce
//
//  Created by JunHyuk Lim on 4/10/2022.
//

import SwiftUI

struct LoginPage: View {
    //MARK: - PROPERTIES
    let customFont = "Raleway-Regular"
    
    @StateObject var loginViewModel : LoginPageViewModel = LoginPageViewModel()
    
    //MARK: - BODY
    var body: some View {
        VStack {
            //MARK: - TITLE IMAGE
            Text("Welcome\nback")
                .font(.custom(customFont, size: 55)).bold()
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(
                    ZStack{
                        LinearGradient(colors: [
                            Color("LoginCircle"),
                            Color("LoginCircle").opacity(0.8),
                            Color("Purple")
                        ], startPoint: .top, endPoint: .bottom)
                        .frame(width:100, height: 100)
                        .clipShape(Circle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(.trailing)
                        .offset(y: -25)
                        .ignoresSafeArea()
                        
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                            .frame(width: 30, height: 30)
                            .blur(radius: 2)
                            .frame(maxWidth : .infinity, maxHeight:.infinity, alignment: .bottomTrailing)
                            .padding(30)
                        
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                            .frame(width: 23, height: 23)
                            .blur(radius: 2)
                            .frame(maxWidth : .infinity, maxHeight:.infinity, alignment: .topLeading)
                            .padding(.leading, 30)
                    }
                )
            //MARK: - LOGIN
            ScrollView(.vertical, showsIndicators: true) {
                VStack(spacing: 15) {
                    //LOGIN TITLE
                    Text(loginViewModel.registerUser ? "Register" : "Login")
                        .font(.custom(customFont, size:22).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    //Email
                    CustomTextField(icon: "envelope", title: "Email", hint: "abc@abc.com", value: $loginViewModel.email, showPassword: $loginViewModel.showPassword)
                        .padding(.top, 30)
                    
                    //Password
                    CustomTextField(icon: "lock", title: "Password", hint: "123456", value: $loginViewModel.password, showPassword: $loginViewModel.showPassword)
                        .padding(.top, 10)
                    
                    //Register ReEnter Password
                    if loginViewModel.registerUser{
                        CustomTextField(icon: "lock", title: "Re-Enter Password", hint: "123456", value: $loginViewModel.reEnterPassword, showPassword: $loginViewModel.showReEnterPassword)
                            .padding(.top, 10)
                    }
                    
                    //Forgot Password Button
                    Button {
                        loginViewModel.forgotPassword()
                    } label: {
                        Text("Forgot password?")
                            .font(.custom(customFont, size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Purple"))
                    } //: BUTTON
                    .padding(.top, 8)
                    .frame(maxWidth:.infinity, alignment: .leading)
                    
                    //LOGIN BUTTON
                    Button {
                        if loginViewModel.registerUser {
                            loginViewModel.register()
                        }
                        else {
                            loginViewModel.login()
                        }
                    } label: {
                        Text("Login")
                            .font(.custom(customFont, size: 17).bold())
                            .padding(.vertical, 20)
                            .frame(maxWidth:.infinity)
                            .foregroundColor(.white)
                            .background(Color("Purple"))
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    } //: BUTTON
                    .padding(.top, 25)
                    .padding(.horizontal)
                    
                    //Register User Button
                    Button {
                        withAnimation {
                            loginViewModel.registerUser.toggle()
                        }
                    } label: {
                        Text(loginViewModel.registerUser ? "Back to login" : "Create Account")
                            .font(.custom(customFont, size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Purple"))
                    } //: BUTTON
                    .padding(.top, 8)
                    
                } //: VSTACK
                .padding(30)
            } //: SCROLLVIEW
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                    .ignoresSafeArea()
            )
        } //: VSTACK
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Purple"))
        
        .onChange(of: loginViewModel.registerUser) { newValue in
            loginViewModel.email = ""
            loginViewModel.password = ""
            loginViewModel.reEnterPassword = ""
            loginViewModel.showPassword = false
            loginViewModel.showReEnterPassword = false
        }
    }
    
    //MARK: - EXTENSION
    @ViewBuilder
    func CustomTextField(icon: String, title: String, hint: String, value: Binding<String>, showPassword: Binding<Bool>)->some View{
        
        VStack(alignment: .leading, spacing: 12) {
            Label {
                Text(title)
                    .font(.custom(customFont, size: 14))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            if title.contains("Password") && !showPassword.wrappedValue {
                SecureField(hint, text: value)
                    .padding(.top, 2)
            } else {
                TextField(hint, text: value)
                    .padding(.top, 2)
            }

            Divider()
                .background(Color.black.opacity(0.4))
        } //: VSTACK
        .overlay(
            Group{
                if title.contains("Password"){
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Text(showPassword.wrappedValue ? "Hide" : "Show")
                            .font(.custom(customFont, size: 13).bold())
                            .foregroundColor(Color("Purple"))
                    })
                    .offset(y: 8)
                }
            }

            ,alignment: .trailing
        )
    }
}



//MARK: - PREVIEW
struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
