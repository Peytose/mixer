//
//  MockEvent.swift
//  mixer
//
//  Created by Jose Martinez on 1/5/23.
//

import Foundation

struct MockEvent: Identifiable {
    let id = UUID()
    var hostName: String
    var fullHostName: String
    var visibility: String
    var title: String
    var attendance: String
    var date: String
    var shortDate: String
    var stickyMonth: String
    var stickyDay: String
    var duration: String
    var startTime: String
    var wetOrDry: String
    var description: String
    var theme: String
    var attireDescription: String
    var flyer: String
    var school: String
    var address: String
}

var events = [
    MockEvent(hostName: "MIT Theta Chi", fullHostName: "MIT Theta Chi Fraternity", visibility: "Invite Only", title: "Neon Party", attendance: "156", date: "Friday, January 20", shortDate: "Friday, 10:00 PM", stickyMonth: "Jan", stickyDay: "24", duration: "10:00 PM - 1:00 AM", startTime: "10:00 PM", wetOrDry: "Wet", description: "Neon party at Theta Chi this friday night, need we say more?", theme: "Neon/Black light", attireDescription: "Normal party clothes (wear neon if possible)", flyer: "theta-chi-party-poster", school: "MIT", address: "528 Beacon St, Boston MA"),
    MockEvent(hostName: "MIT Theta Chi", fullHostName: "MIT Theta Chi Fraternity", visibility: "Open", title: "Theta SpooChi", attendance: "455", date: "Friday, January 27", shortDate: "Friday, 10:00 PM", stickyMonth: "Jan", stickyDay: "27", duration: "10:00 PM - 1:00 AM", startTime: "10:00 PM", wetOrDry: "Wet", description: "Halloween Party. Come with a costume or no entry", theme: "Halloween", attireDescription: "Normal party clothes (wear neon if possible)", flyer: "theta-chi-party-poster-2", school: "MIT", address: "528 Beacon St, Boston MA"),
//    MockEvent(hostName: "MIT Theta Chi", fullHostName: "MIT Theta Chi Fraternity", visibility: "Open", title: "Rolling Loud Party", attendance: "455", date: "Friday, February 3", shortDate: "Friday, 10:00 PM", stickyMonth: "Feb", stickyDay: "3", duration: "10:00 PM - 1:00 AM", startTime: "10:00 PM", wetOrDry: "Wet", description: "Theta Chi's take on rolling loud. Will be playing music from hip hop artists featured at this year's Rolling Loud Miami concert. We will also be throwing water bags at the crowd so be ready to get wet", theme: "Neon/Black light", attireDescription: "Hip-Hop Concert attire (Rolling Loud Clothes)", flyer: "theta-chi-party-poster-3", school: "MIT", address: "528 Beacon St, Boston MA")
]
