//
//  ProfileViewModel.swift
//  mixer
//
//  Created by Peyton Lyons on 11/12/22.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
        getUserRelationship()
//        fetchUsersStats()
    }
    
    
    func requestFriend() {
        guard let uid = user.id else { return }
        UserService.sendFriendRequest(uid: uid) { _ in
            self.user.relationshiptoCurrentUser = .youRequested
            NotificationsViewModel.uploadNotifications(toUid: uid, type: .follow)
        }
    }
    
    
    func acceptFriendRequest() {
        guard let uid = user.id else { return }
        UserService.acceptFriendRequest(uid: uid) { _ in
            self.user.relationshiptoCurrentUser = .friends
            NotificationsViewModel.uploadNotifications(toUid: uid, type: .follow)
        }
    }
    
    
    func cancelFriendRequest() {
        guard let uid = user.id else { return }
        UserService.cancelRequestOrRemoveFriend(uid: uid) { _ in
            self.user.relationshiptoCurrentUser = .strangers
        }
    }
    
    
    func getUserRelationship() {
        guard !user.isCurrentUser else { return }
        guard let uid = user.id else { return }
        
        UserService.getUserRelationship(uid: uid) { relation in
            self.user.relationshiptoCurrentUser = relation
        }
    }
    
    
//    func fetchUsersStats() {
//        guard let uid = user.id else { return }
//
//        COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments { snapshot, _ in
//            guard let following = snapshot?.documents.count else { return }
//
//            COLLECTION_FRIENDS.document(uid).collection("user-friends").getDocuments { snapshot, _ in
//                guard let followers = snapshot?.documents.count else { return }
//
//                self.user.stats = UserStats(following: following, followers: followers)
//            }
//        }
//    }
}
