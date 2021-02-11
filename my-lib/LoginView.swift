//
//  LoginView.swift
//  ScreenDemo
//
//  Created by Shubham Kumar Singh on 02/02/21.
//

import SwiftUI
import AppStorage

public struct LoginView: View {
    
    public init() {
        
    }
    
    @State var username: String = ""
    @State var password: String = ""
    @State var goToHome: Bool = false
    
    @AppStorageCompat("language")
    private var language = LocalizationService.shared.language
    
    public var body: some View {
        NavigationView {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 50, content: {
                NavigationLink(destination: HomeView(), isActive: $goToHome) { EmptyView() }
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 30, content: {
                    Button(action: {
                        LocalizationService.shared.language = .english
                        UserDefaults.standard.set([Language.english.rawValue], forKey: "AppleLanguages")
                        UserDefaults.standard.synchronize()
                        
                        let scene = UIApplication.shared.connectedScenes.first
                        let contentView = LoginView().environment(\.layoutDirection, .leftToRight)

                        // Use a UIHostingController as window root view controller.
                        if let windowScene = scene as? UIWindowScene {
                            let window = windowScene.windows.first
                            window?.rootViewController = UIHostingController(rootView: contentView)
                            window?.makeKeyAndVisible()
                        }
                    }, label: {
                        Text("English")
                    })
                    Button(action: {
                        LocalizationService.shared.language = .arabic
                        UserDefaults.standard.set([Language.arabic.rawValue], forKey: "AppleLanguages")
                        UserDefaults.standard.synchronize()
                        
                        let scene = UIApplication.shared.connectedScenes.first
                        let contentView = LoginView().environment(\.layoutDirection, .rightToLeft)

                        // Use a UIHostingController as window root view controller.
                        if let windowScene = scene as? UIWindowScene {
                            let window = windowScene.windows.first
                            window?.rootViewController = UIHostingController(rootView: contentView)
                            window?.makeKeyAndVisible()
                        }
                        
                    }, label: {
                        Text("Arabic")
                    })
                })
                TextField(Constant.username.localized(reqBundle: Constant.sdkBundle), text: $username)
                    .padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    .cornerRadius(5)
                    .padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                TextField(Constant.password.localized(reqBundle: Constant.sdkBundle), text: $password)
                    .padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    .cornerRadius(5)
                    .keyboardType(.numberPad)
                    .padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
                Button(Constant.login.localized(reqBundle: Constant.sdkBundle)) {
                    self.goToHome = true
                }
            }).navigationBarTitle(Text(Constant.login.localized(reqBundle: Constant.sdkBundle)))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
