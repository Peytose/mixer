//
//  UserProfileViewModel.swift
//  mixer
//
//  Created by Jose Martinez on 12/18/22.
//

import CloudKit
import SwiftUI

//extension ProfileView {
    
    @MainActor final class UserProfileViewModel: ObservableObject {
        @Published var firstName             = ""
        @Published var lastName              = ""
        @Published var avatar                = UIImage(named: "kingfisher-2.jpg")
        @Published var email                 = ""
        @Published var phone                 = ""
        @Published var birthday              = Date.now
        @Published var gender                = ""
        @Published var university            = ""
        @Published var hasHostStatus         = false
        @Published var isCheckedIn           = false
        @Published var isShowingPhotoPicker  = false
        @Published var isLoading             = false
        @Published var isShowingUpdateButton = false
        @Published var alertItem: AlertItem?
        @Published var contentHasScrolled    = false
        @Published var expandMenu            = false
        @Published var showNavigationBar     = true
        
        private var existingProfileRecord: CKRecord?
        
        
//        func getProfile() {
//            guard let userRecord = CloudKitManager.shared.userRecord else {
//                alertItem = AlertContext.noUserRecord
//                return
//            }
//
//            guard let profileReference = userRecord["userProfile"] as? CKRecord.Reference else { return }
//            let profileRecordID = profileReference.recordID
//
//            showLoadingView()
//
//            Task {
//                do {
//                    let record = try await CloudKitManager.shared.fetchRecord(with: profileRecordID)
//                    existingProfileRecord = record
//
//                    let profile = UserProfile(record: record)
//                    firstName  = profile.firstName
//                    lastName   = profile.lastName
//                    email      = profile.email
//                    phone      = profile.phone
//                    birthday   = profile.birthday
//                    gender     = profile.gender
//                    university = profile.university
//                    avatar     = profile.avatarImage
//
//                    hideLoadingView()
//                } catch {
//                    alertItem = AlertContext.unableToGetProfile
//                }
//            }
//        }
        
        
//        func updateProfile() {
//            guard let profileRecord = existingProfileRecord else {
//                alertItem = AlertContext.unableToGetProfile
//                return
//            }
//
//            profileRecord[UserProfile.kFirstName] = firstName
//            profileRecord[UserProfile.kLastName]  = lastName
//            profileRecord[UserProfile.kEmail]     = email
//            profileRecord[UserProfile.kPhone]     = phone
//            profileRecord[UserProfile.kBirthday]  = birthday
//            profileRecord[UserProfile.kGender]    = gender
//            profileRecord[UserProfile.kAvatar]    = avatar.convertToCKAsset()
//
//            showLoadingView()
//
//            Task {
//                do {
//                    let _ = try await CloudKitManager.shared.save(record: profileRecord)
//                    hideLoadingView()
//                    alertItem = AlertContext.updateProfileSuccess
//                } catch {
//                    hideLoadingView()
//                    alertItem = AlertContext.updateProfileFailure
//                }
//            }
//        }
        
        
//        private func showLoadingView() { isLoading = true }
//        private func hideLoadingView() { isLoading = false }
    }
