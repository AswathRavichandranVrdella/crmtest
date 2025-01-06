//
//  LoginNavigationView.swift
//  VivyaCRM
//
//  Created by aravinthan t on 24/12/24.
//

import SwiftUI
import Themehandler

struct LoginNavigationView: View
{
    @Environment(\.colorScheme) var colorScheme
    @State private var isDarkMode = false
    @EnvironmentObject var colorManager: ColorManagers
    
    @State var email: String = ""
    @State var pass: String = ""
    @State var Newpass: String = ""
    @State var Confirmpass: String = ""
    @State var isChecked: Bool = false
    @State private var isAnimated = false
    
    @State private var showSetUpPassword = false
    @State private var showOTPScreen = false
    @State private var forgotpasswordscreen = false
    
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isPasswordHidden = true
    
    @State private var navigateToHome = false
    
    @State private var isEditing = false // Tracks the editing state of the TextField
    
    @State private var textFields: [String] = Array(repeating: "", count: 4)
    
    @FocusState var focusvalue : Int?
    
    let isPad = UIDevice.current.userInterfaceIdiom == .pad
    
    init()
    {
        UIScrollView.appearance().bounces = false
        
    }
    
    var body: some View
    {
        
        //        NavigationStack {
        ScrollView{
            
            VStack{
                
                if isEditing
                {
                    TopframeView
                    //                            .transition(.opacity)
                }
                
                if !isEditing
                {
                    TopView
                    //                            .transition(.opacity)
                }
                
                
                Spacer()
                    .padding(.bottom, 10)
                
                BottonView
                    .transition(.move(edge: .leading)) // Add sliding animation
                    .offset(
                        x: isAnimated ? 0 : UIDevice().userInterfaceIdiom == .pad ? 500 : 300,
                        y: isAnimated ? 0 : UIDevice().userInterfaceIdiom == .pad ? 500 : 300
                    ) // Initial offset for bottom trailing animation
                    .animation(.easeInOut(duration: 1.5), value: isAnimated) // Smooth animation
                    .padding(.bottom, 50)
                    .onAppear(){
#if DEBUG
                       print("Debug")
#elseif UAT
                        print("UAT")
#elseif PROD
                        print("Prod")
#else
                        print("Release")
#endif
                        
                       
                        print(Urls.loginUrl)
                    }
            }
            
        }
        .background(ColorManagers.shared.getColor(for: "background"))
        .foregroundStyle(ColorManagers.shared.getColor(for: "textPrimary"))
        
        .ignoresSafeArea()
        //        }
        .animation(.easeInOut(duration: 0.5), value: showSetUpPassword)
        .onAppear {
            // Trigger the animation when the view appears
            withAnimation(.easeInOut(duration: 1.5)) {
                isAnimated = true
            }
        }
        
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { _ in
            withAnimation {
                isEditing = true
                
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
            withAnimation {
                isEditing = false
                
            }
        }
        
    }
    
    private var TopframeView: some View {
        
        ZStack{
            Rectangle()
                .fill(ColorManagers.shared.getColor(for: "secondary"))
                .frame(height: 100)
            
            Text("VIVYA CRM")
                .foregroundStyle(Color.white)
                .font(.custom("Avenir Next Bold", size: UIDevice().userInterfaceIdiom == .pad ? 30 : 22))
                .padding(.top, 50)
        } .onChange(of: colorScheme) {
            colorManager.updateCurrentColors()
              
            
            //function to change the colour when the mode of the app changed
            
        }
        
        
        
    }
    
    private var TopView: some View {
        
        ZStack {
            Circle()
                .fill(ColorManagers.shared.getColor(for: "secondary"))
                .offset(
                    x: isAnimated ? 0 : -(UIDevice().userInterfaceIdiom == .pad ? 500 : 300),
                    y: isAnimated ? 0 : -(UIDevice().userInterfaceIdiom == .pad ? 500 : 300)
                ) // Initial offset for animation
                .padding(.top, UIDevice().userInterfaceIdiom == .pad ? -700 : -230)
                .padding(.leading, UIDevice().userInterfaceIdiom == .pad ? -400 : -200)
                .padding(.trailing, UIDevice().userInterfaceIdiom == .pad ? -120 : -60)
            
            
            
            // Content
            VStack {
                // Top Leading Back Button
                HStack {
                    
                    if showSetUpPassword || forgotpasswordscreen || showOTPScreen {
                        Button(action: {
                            // Handle back action
                            
                            if forgotpasswordscreen{
                                withAnimation {
                                    forgotpasswordscreen = false // Show SetUpPassword view
                                }
                            }
                            else if showOTPScreen {
                                withAnimation {
                                    showOTPScreen = false // Show SetUpPassword view
                                }
                            }
                            
                            else if showSetUpPassword {
                                withAnimation {
                                    showSetUpPassword = false
                                    showOTPScreen = true// Show SetUpPassword view
                                }
                            }
                            
                            
                            
                        }) {
                            Image("LoginBack")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIDevice().userInterfaceIdiom == .pad ? 50 : 40, height: UIDevice().userInterfaceIdiom == .pad ? 50 : 40)
                                .padding(.leading, 25)
                        }
                    }
                    
                    else {
                        Rectangle()
                            .fill(.clear)
                            .frame(width: UIDevice().userInterfaceIdiom == .pad ? 50 : 40, height: UIDevice().userInterfaceIdiom == .pad ? 50 : 40)
                            .padding(.leading, 25)
                    }
                    //
                    Spacer()
                }
                .padding(.top, 70)
                
                //                       Spacer()
                
                // Centered Logo
                
                Image("VivyaCRMlogo")
                    .resizable()
                    .frame(width: UIDevice().userInterfaceIdiom == .pad ? 290 : 200, height: UIDevice().userInterfaceIdiom == .pad ? 70 : 45)
                    .opacity(isAnimated ? 1 : 0)
                    .animation(.easeInOut(duration: 1.5), value: isAnimated)
                    .padding(.top, UIDevice().userInterfaceIdiom == .pad ? 200 : 100)
                
                Spacer()
                
            }
            
        }.onChange(of: colorScheme) {
            colorManager.updateCurrentColors()
            
            //function to change the colour when the mode of the app changed
            
        }
       
        
        
        
    }
    
    private var BottonView: some View {
        
        VStack {
            VStack(spacing: 5) {
                Text(appStrings.instance.loginTitleText)
                
                
//                    .font(.custom("Poppins-Bold", size: UIDevice().userInterfaceIdiom == .pad ? 30 : 22))
//                    .fontWeight(.bold)
                
//                    .font(
//                    Font.custom("Poppins-SemiBoldItalic", size: 20)
//
//                    )
                
                    .font(Font.custom("Poppins-Bold", size: UIDevice().userInterfaceIdiom == .pad ? 30 : 22))
                
//                    .font(
//                        ColorManagers.shared.getFont(for: "Poppins-Bold", size: UIDevice().userInterfaceIdiom == .pad ? 30 : 22)
//                    
//                    )
                
                
                Text(appStrings.instance.loginTitleTextSecondary)
                    .font(.custom("Avenir Next Regular", size: UIDevice().userInterfaceIdiom == .pad ? 20 : 13))
                    .frame(height: 45)
                    .kerning(0.2)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                
                
            }
            
            VStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 3) {
                    Text(appStrings.instance.loginMailIdTitle)
                        .font(.custom("Avenir Next Bold", size: UIDevice().userInterfaceIdiom == .pad ? 20 : 15))
                    TextField("", text: $email)
                        .autocapitalization(.none) // Disable automatic capitalization
                        .keyboardType(.emailAddress) // Use email keyboard type
                        .textInputAutocapitalization(.never) // Ensures no autocapitalization on newer iOS versions
                        .autocorrectionDisabled(true)
                        .padding(.leading, 10)
                        .frame(height: 40)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        )
                    
                }
                
                VStack(alignment: .leading, spacing: 3) {
                    Text(appStrings.instance.loginPasswordTitle)
                        .font(.custom("Avenir Next Bold", size: UIDevice().userInterfaceIdiom == .pad ? 20 : 15))
                    ZStack {
                        // Password Field
                        if isPasswordHidden {
                            SecureField("", text: $pass)
                                .autocorrectionDisabled(true)
                                .padding(.leading, 10)
                                .frame(height: 40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                )
                        } else {
                            TextField("", text: $pass)
                                .autocorrectionDisabled(true)
                                .padding(.leading, 10)
                                .frame(height: 40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                )
                        }
                        
                        // Toggle Password Visibility Button
                        HStack {
                            Spacer()
                            Button(action: {
                                isPasswordHidden.toggle()
                            }) {
                                Image(systemName: isPasswordHidden ? "lock.open" : "lock")
                                    .padding(.trailing, 10)
                                    .foregroundColor(Color(#colorLiteral(red: 0.3155861497, green: 0.1523542702, blue: 0.5989382267, alpha: 1)))
                            }
                        }
                    }
                }
                
                HStack {
                    HStack {
                        Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                            .foregroundColor(isChecked ? Color(#colorLiteral(red: 0.3155861497, green: 0.1523542702, blue: 0.5989382267, alpha: 1)) : .gray)
                        
                            .onTapGesture {
                                isChecked.toggle()
                                isDarkMode.toggle()
                            }
                        
                        Text(appStrings.instance.loginPageRememberMeTitle)
                            .font(.custom("Avenir Next Regular", size: UIDevice().userInterfaceIdiom == .pad ? 20 : 13))
                    }
                    Spacer()
                    Button(appStrings.instance.loginPageForgotPasswordTitle, action: {
                        
                        withAnimation {
                            forgotpasswordscreen = true // Show SetUpPassword view
                        }
                        
                        
                    })
                    .font(.custom("Avenir Next Medium", size: UIDevice().userInterfaceIdiom == .pad ? 20 : 13))
                    .foregroundStyle(.red)
                }
                
                // Login Button
                Button(action: {
                    // Handle login action
                    
                    
//                    if email == "ios" && pass == "12345678"
//                    {
//                        //need to show SetUpPassword View and hide BottomView
//                        withAnimation {
//                            showOTPScreen = true // Show SetUpPassword view
//                        }
//                    }
//                    else
//                    {
//                        alertMessage = "Email and password are not correct."
//                        showAlert = true
//                    }
                })
               
               
                {
                    Text(appStrings.instance.loginButtonTitle)
                        .font(.system(size: UIDevice().userInterfaceIdiom == .pad ? 30 : 20, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .frame(height: UIDevice().userInterfaceIdiom == .pad ? 60 : 50)
                        .background(ColorManagers.shared.getColor(for: "secondary"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top, 25)
                }
                
                
                // Attach the alert to the view
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Login Failed"),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
                // Navigation to Home Page
                //                               .navigationDestination(isPresented: $navigateToHome) {
                //                                   HomePage()
                //                               }
                
            }
        }
        
        .padding(.horizontal, 50)
        
        
    }
    
    
    private var setuppasswordview : some View
    {
        VStack {
            VStack(spacing: 5) {
                Text("Set Up Your Password")
                    .font(.custom("Avenir Next Bold", size: UIDevice().userInterfaceIdiom == .pad ? 30 : 22))
                Text("Please create a password for your account. It should be at least 8 characters long.")
                    .font(.custom("Avenir Next Regular", size: UIDevice().userInterfaceIdiom == .pad ? 20 : 13))
                    .frame(height: 45)
                    .kerning(0.2)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
            }
            
            VStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 3) {
                    Text("New Password")
                        .font(.custom("Avenir Next Bold", size: UIDevice().userInterfaceIdiom == .pad ? 20 : 15))
                    ZStack {
                        // Password Field
                        if isPasswordHidden {
                            SecureField("", text: $Newpass)
                                .padding(.leading, 10)
                                .frame(height: 40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                )
                        } else {
                            TextField("", text: $Newpass)
                                .padding(.leading, 10)
                                .frame(height: 40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                )
                        }
                        
                        // Toggle Password Visibility Button
                        HStack {
                            Spacer()
                            Button(action: {
                                isPasswordHidden.toggle()
                            }) {
                                Image(systemName: isPasswordHidden ? "lock.open" : "lock")
                                    .padding(.trailing, 10)
                                    .foregroundColor(Color(#colorLiteral(red: 0.3155861497, green: 0.1523542702, blue: 0.5989382267, alpha: 1)))
                            }
                        }
                    }
                    
                }
                
                VStack(alignment: .leading, spacing: 3) {
                    Text("Confirm Password")
                        .font(.custom("Avenir Next Bold", size: UIDevice().userInterfaceIdiom == .pad ? 20 : 15))
                    ZStack {
                        // Password Field
                        if isPasswordHidden {
                            SecureField("", text: $Confirmpass)
                                .padding(.leading, 10)
                                .frame(height: 40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                )
                        } else {
                            TextField("", text: $Confirmpass)
                                .padding(.leading, 10)
                                .frame(height: 40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                                )
                        }
                        
                        // Toggle Password Visibility Button
                        HStack {
                            Spacer()
                            Button(action: {
                                isPasswordHidden.toggle()
                            }) {
                                Image(systemName: isPasswordHidden ? "lock.open" : "lock")
                                    .padding(.trailing, 10)
                                    .foregroundColor(Color(#colorLiteral(red: 0.3155861497, green: 0.1523542702, blue: 0.5989382267, alpha: 1)))
                            }
                        }
                    }
                }
                
                
                // Login Button
                Button(action: {
                    // Handle login action
                    if Newpass == Confirmpass {
                        
                        
                    }
                    else
                    {
                        alertMessage = "Confirm password and new password are not same"
                        showAlert = true
                    }
                })
                
                {
                    Text("Create Account")
                        .font(.system(size: UIDevice().userInterfaceIdiom == .pad ? 30 : 20, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .frame(height: UIDevice().userInterfaceIdiom == .pad ? 60 : 50)
                        .background(Color(#colorLiteral(red: 0.3155861497, green: 0.1523542702, blue: 0.5989382267, alpha: 1)))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.top, 25)
                }
                
                
                // Attach the alert to the view
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Login Failed"),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
                // Navigation to Home Page
                //                               .navigationDestination(isPresented: $navigateToHome) {
                //                                   HomePage()
                //                               }
                
            }
        }
        .padding(.horizontal, 50)
        
    }
    
    
    
    
}




#Preview {
    LoginNavigationView()
}

