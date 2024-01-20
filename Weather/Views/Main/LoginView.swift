import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            Image("Background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Sign in")
                    .font(.system(size: 30, weight: .light, design: .default))
                    .foregroundColor(.white)
                    
                VStack(spacing: 20) {
                    Text("Username")
                        .font(.system(size: 20, weight: .light, design: .default))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading) // Align the label with the input field
                  
                    
                    HStack {
                        TextField("Enter your username", text: $username)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.black.opacity(0.5))
                            .padding(.leading)
                            .cornerRadius(5)
                            .font(.system(size: 20, weight: .light, design: .default))
                            .foregroundColor(.white)
                   
                        
                        Spacer() // Add spacer to push the button to the right edge
                    }
                    
                    Text("Password")
                        .font(.system(size: 20, weight: .light, design: .default))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading) // Align the label with the input field
                    
                    HStack {
                        SecureField("Enter your password", text:  $password)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .background(Color.black.opacity(0.5))
                            .padding(.leading)
                            .cornerRadius(10)
                            .font(.system(size: 20, weight: .light, design: .default))
                            .foregroundColor(.white)
                      
                        
                        Spacer() // Add spacer to push the button to the right edge
                    }
                    HStack {
                        Button(action: {
                            // Perform login action
                        }) {
                            Text("Login")
                                .font(.system(size: 15, weight: .bold, design: .default))
                                .foregroundColor(.white)
                                .padding()
                                .frame(width:290) // Make the button same width as the input field
                                .background(Color.blue)
                                .cornerRadius(5)
                        }
                    }
                    VStack {
                        Button(action: {
                            // Perform login action
                        }) {
                            Text("Sign in with Apple ID")
                                .font(.system(size: 15, weight: .bold, design: .default))
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 290) // Make the button same width as the input field
                                .background(Color.black)
                                .cornerRadius(5)
                                .overlay(
                                    HStack {
                                        Image(systemName: "apple.logo")
                                            .foregroundColor(.white)
                                        Spacer()
                                    }
                                    .padding(.leading, 25)
                                )
                        }
                        Button(action: {
                            // Perform login action
                        }) {
                            Text("Sign in with Google")
                                .font(.system(size: 15, weight: .bold, design: .default))
                                .foregroundColor(.black)
                                .padding()
                                .frame(width: 290) // Make the button same width as the input field
                                .background(Color.white)
                                .cornerRadius(5)
                                .overlay(
                                    HStack {
                                        Image(systemName: "externaldrive.fill")
                                            .foregroundColor(.green)
                                        Spacer()
                                    }
                                    .padding(.leading, 20)
                                )
                        }
                    }
                }
                                .padding(.horizontal, 40)
                                .padding(.top) // Align the button with the input fields
                Spacer()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

