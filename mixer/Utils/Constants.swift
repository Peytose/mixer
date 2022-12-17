//
//  Constants.swift
//  mixer
//
//  Created by Peyton Lyons on 11/11/22.
//

import Firebase

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_REQUESTS = Firestore.firestore().collection("friendships")
let COLLECTION_FRIENDSHIPS = Firestore.firestore().collection("friendships")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
let COLLECTION_EVENTS = Firestore.firestore().collection("events")
let COLLECTION_NOTIFICATIONS = Firestore.firestore().collection("notifications")
