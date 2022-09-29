//
//  LoginPage.swift
//  PaaS-TA Container Platform
//
//  Created by minkyuLee on 2022/09/27.
//

import SwiftUI

struct LoginPage: View {
    @EnvironmentObject var userVM : UserVM
    
    @AppStorage("log_Status") var status = false
    
    var body: some View {
        
        VStack{
            
            // Welcome Back text for 3 half of the screen...
            Text("Welcome\nback")
                .font(.system(size: 55).bold())
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: getRect().height / 3.5)
                .padding()
                .background(
                
                    ZStack{
                        
                        // Gradient Circle...
                        LinearGradient(colors: [
                            Color("LoginCircle"),
                            Color("LoginCircle")
                                .opacity(0.8),
                            Color("Purple")
                        ], startPoint: .top, endPoint: .bottom)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(.trailing)
                        .offset(y: -25)
                        .ignoresSafeArea()
                            
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                            .frame(width: 30, height: 30)
                            .blur(radius: 3)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                            .padding(30)
                        
                        Circle()
                            .strokeBorder(Color.white.opacity(0.3), lineWidth: 3)
                            .frame(width: 23, height: 23)
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .padding(30)
                        
                    }
                )
            
            .frame(height: getRect().height / 3.5)
            
            ScrollView(.vertical, showsIndicators: false) {
                
                // Login Page Form...
                VStack(spacing: 15){
                    
                    Text(userVM.registerUser ? "Register" : "Login")
                        .font(.system(size: 22).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Custom Text Field...
                    
                    CustomTextField(icon: "envelope", title: "Email", hint: "suslmk@naver.com", value: $userVM.email, showPassword: .constant(false))
                        .autocapitalization(.none)
                        .padding(.top, 30)
                    
                    CustomTextField(icon: "lock", title: "Password", hint: "123456", value: $userVM.password, showPassword: $userVM.showPassword)
                        .autocapitalization(.none)
                        .padding(.top, 10)
                    
                    // Register Reenter Password
                    if userVM.registerUser{
                        CustomTextField(icon: "envolope", title: "Re-Enter Password", hint: "123456", value: $userVM.re_Enter_Password, showPassword: $userVM.showReEnterPassword).textInputAutocapitalization(.none)
                            .padding(.top, 10)
                    }
                    
                    // Forgot Password Button...
                    Button {
                        userVM.ForgetPassword()
                    } label: {
                        
                        Text("Forget password?")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Purple"))
                    }
                    .padding(.top,8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    //Login Button...
                    Button {
                        if userVM.registerUser{
                            userVM.Register()
                        }
                        else {
                            userVM.login(email: userVM.email, password: userVM.password)
                        }
                    } label: {
                        
                        Text("Login")
                            .font(.system(size: 17))
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color("Purple"))
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }
                    .padding(.top,25)
                    .padding(.horizontal)
                    
                    // Register User Button...
                    
                    Button {
                        withAnimation{
                            userVM.registerUser.toggle()
                        }
                    } label: {
                        
                        Text(userVM.registerUser ? "Back to login" : "Create account")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Purple"))
                    }
                    .padding(.top,8)
                    .onReceive(userVM.loginSuccess, perform: {
                        print("LoginView - loginSuccess() called")
                        status.toggle()
                    })
                    
                }
                .padding(30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                // Applying Custom Corners...
                    .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 25))
                    .ignoresSafeArea()
            )
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Purple"))
        
        // Clearing data when Changes...
        // Optional...
        .onChange(of: userVM.registerUser) { newValue in
            userVM.email = ""
            userVM.password = ""
            userVM.re_Enter_Password = ""
            userVM.showPassword = false
            userVM.showReEnterPassword = false
        }
        .overlay(
            Group{
                if status {
                    MainView()
                        .transition(.move(edge: .trailing))
                }
            }
        )
        
    }
    
    @ViewBuilder
    func CustomTextField(icon: String, title: String, hint: String, value: Binding<String>, showPassword: Binding<Bool>) -> some View{
        
        VStack(alignment: .leading, spacing: 12) {
            
            Label {
                Text(title)
                    .font(.system(size: 14))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            if title.contains("Password") && !showPassword.wrappedValue{
                SecureField(hint, text: value)
                    .padding(.top,2)
            }
            else{
                TextField(hint, text: value)
                    .padding(.top,2)
            }
            
            Divider()
                .background(Color.black.opacity(0.4))
        }
        // Showing Show Button for password Field...
        .overlay(
            
            Group{
                
                if title.contains("Password"){
                    Button(action: {
                        showPassword.wrappedValue.toggle()
                    }, label: {
                        Text(showPassword.wrappedValue ? "Hide" : "Show")
                            .font(.system(size: 14).bold())
                            .foregroundColor(Color("Purple"))
                        
                    })
                    .offset(y: 8)
                    
                }
                
            }
            , alignment: .trailing
        )
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}

// Extending View to get Screen Bounds...
extension View {
    func getRect() -> CGRect{
        return UIScreen.main.bounds
    }
}
