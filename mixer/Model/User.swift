//
//  User.swift
//  mixer
//
//  Created by Peyton Lyons on 11/11/22.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    let username: String
    let email: String
    let profileImageUrl: String
    let firstName: String
    let lastName: String
    @DocumentID var id: String?
    var bio: String?
    var stats: UserStats?
    
    var relationshiptoCurrentUser: UserRelationship?

    var isCurrentUser: Bool { return AuthViewModel.shared.userSession?.uid == id }
}

enum UserRelationship: Int, Decodable {
    case friends
    case youRequested
    case theyRequested
    case strangers
    
    var relationshipStatus: String {
        switch self {
            case .friends: return "Friends"
            case .youRequested: return "Requested"
            default: return ""
        }
    }
}

struct UserStats: Decodable {
    var following: Int
//    var posts: Int
    var followers: Int
}
