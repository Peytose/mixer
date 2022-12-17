//
//  AuthViewModel.swift
//  mixer
//
//  Created by Peyton Lyons on 11/11/22.
//

import SwiftUI
import FirebaseAuth
import Firebase

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var emailIsVerified = false
    @Published var firstName             = ""
    @Published var lastName              = ""
    @Published var phoneNumber           = ""
    @Published var code                  = ""
    @Published var email                 = ""
    @Published var username              = ""
    @Published var birthdayString        = "" { didSet { checkValidBirthday() } }
    @Published var birthday              = Date.now { didSet { isValidBirthday = true } }
    @Published var gender                = "Female"
    @Published var avatar: UIImage?
    @Published var university            = ""
    @Published var isValidBirthday       = false
    @Published var alertItem: AlertItem?
    
    static let shared = AuthViewModel()
    
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    enum Screen: Int, CaseIterable {
        case name
        case phone
        case code
        case email
        case username
        case birthday
        case gender
        case avatar
    }
    
    @Published var active: Screen = Screen.allCases.first!
    @Published var hasError = false
    
    
    func next() {
        let nextScreenIndex = min(active.rawValue + 1, Screen.allCases.last!.rawValue)
        if let screen = Screen(rawValue: nextScreenIndex) { active = screen }
    }
    
    
    func previous() {
        let previousScreenIndex = max(active.rawValue - 1, Screen.allCases.first!.rawValue)
        if let screen = Screen(rawValue: previousScreenIndex) {
            active = screen
        }
    }
    
    
    private func login() {
        self.fetchUser()
    }
    
    
    func sendEmailLink() {
        if email.hasSuffix(".edu") { return } // make sure email ends in .edu (temp solution)
        
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(string: "https://mixer.page.link/verify-email")
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        actionCodeSettings.setAndroidPackageName("com.example.android", installIfNotAvailable: false, minimumVersion: "12")
        
        Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings) { error in
            if let error = error as? NSError {
                self.handleAuthError(error)
                return
            }

            UserDefaults.standard.set(self.email, forKey: "Email")
            self.alertItem = AlertContext.sentEmailLink
        }
    }
    
    
    func handleEmailLink(_ url: Foundation.URL) {
        let link = url.absoluteString
        guard let email = UserDefaults.standard.string(forKey: "Email") else { return }
        
        let credential = EmailAuthProvider.credential(withEmail: email, link: link)
        
        userSession?.link(with: credential, completion: { _, error in
            if let error = error as? NSError {
                self.handleAuthError(error)
                return
            }
            
            self.next()
        })
    }
    
    
    func sendPhoneVerification() {
        PhoneAuthProvider.provider().verifyPhoneNumber("+1\(phoneNumber)", uiDelegate: nil) { ID, error in
            if let error = error as? NSError {
                self.handleAuthError(error)
                return
            }
            
            self.next()
            
            guard let verificationID = ID else { return }
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
        }
    }
    
    
    func verifyPhoneNumber() {
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else { return }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: code)
        
        Auth.auth().signIn(with: credential) { result, error in
            if let error = error as? NSError {
                self.handleAuthError(error)
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            
            guard let isNewUser = result?.additionalUserInfo?.isNewUser else { return }
            isNewUser ? self.next() : self.login()
        }
    }
    
    
    func register() {
        guard let image = avatar else { return }
        
        ImageUploader.uploadImage(image: image, type: .profile) { imageUrl in
            guard let uid = self.userSession?.uid else { return }
            print("✅ Successfully registered user ... ")
            
            let data = ["firstName": self.firstName,
                        "lastName": self.lastName,
                        "email": self.email.lowercased(),
                        "username": self.username.lowercased(),
                        "birthday": Timestamp(date: self.birthday),
                        "gender": self.gender,
                        "profileImageUrl": imageUrl,
                        "university": self.university,
                        "uid": uid]
            
            COLLECTION_USERS.document(uid).setData(data) { _ in
                print("✅ Succesfully uploaded user data ...")
                self.fetchUser()
            }
        }
    }
    
    
    func signOut() {
        self.userSession = nil
        try? Auth.auth().signOut()
    }
    
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            self.currentUser = user
        }
    }
    
    
    private func convertStringToDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM  dd  yyyy"
        
        let date = dateFormatter.date(from: birthdayString)!
        
        if date < Date.now { birthday = date } else { return }
    }
    
    
    private func checkValidBirthday() {
        if birthdayString.count > 12 { birthdayString = String(birthdayString.prefix(12)) }
        else if birthdayString.count < 12 { isValidBirthday = false }
        else { convertStringToDate() }
    }
    
    
    private func handleAuthError(_ error: NSError) {
        let errorCode = AuthErrorCode(_nsError: error)
        
        switch errorCode.code {
        case .invalidCredential:
            alertItem = AlertContext.invalidCredential
        case .emailAlreadyInUse:
            alertItem = AlertContext.emailAlreadyInUse
        case .invalidEmail:
            alertItem = AlertContext.invalidEmail
        case .tooManyRequests:
            alertItem = AlertContext.tooManyRequests
        case .userNotFound:
            alertItem = AlertContext.userNotFound
            //          case .requiresRecentLogin:
            //          case .invalidUserToken:
        case .networkError:
            alertItem = AlertContext.networkError
        case .credentialAlreadyInUse:
            alertItem = AlertContext.credentialAlreadyInUse
            //          case .unauthorizedDomain:
            //          case .adminRestrictedOperation:
            //          case .emailChangeNeedsVerification:
        default:
            alertItem = AlertContext.unspecifiedAuthError
            print("DEBUG: Auth error \(error.localizedDescription)")
        }
    }
}

