//
//  MockHost.swift
//  mixer
//
//  Created by Jose Martinez on 1/24/23.
//

import SwiftUI

struct MockHost: Identifiable {
    let id = UUID()
    var name: String
    var username: String
    var oneLiner: String
    var background: String
    var followerCount: String
    var instagramLink: String
    var websiteLink: String
    var description: String
}

var hosts = [
    MockHost(name: "MIT Theta Chi", username: "@mitthetachi", oneLiner: "Your number one spot for college parties!", background: "profile-banner-2", followerCount: "1845", instagramLink: "https://instagram.com/mitthetachi?igshid=Zjc2ZTc4Nzk=", websiteLink: "http://ox.mit.edu/main/", description: "Established in 1902, Theta Chi Beta Chapter is the oldest active Theta Chi chapter in the country, and is one of the first fraternities founded at MIT. We have a storied history of developing leaders: our alumni go on to start companies, build self-driving cars, cure diseases, get involved in politics, serve in the military, and change the world. The brothers of Theta Chi are dedicated to helping each other achieve their goals and give back to the community."),
    MockHost(name: "MIT Phi Sig", username: "@mitphisigmakappa", oneLiner: "The best frat at MIT", background: "profile-banner-3", followerCount: "1433", instagramLink: "https://instagram.com/phisigmit?igshid=Zjc2ZTc4Nzk=", websiteLink: "https://phisig.mit.edu", description: "With everything else we’ve got going on in our lives at MIT brothers at Phi Sig still find time to hang out with each other to play video games, watch movies, play poker or just chill. We also regularly throw parties, inviting other members of both the MIT community and other nearby universities to let loose on a Friday night. Other big events we host include our Iron Chef week, during which our brothers compete to cook 3-course meals for friends and family, and Marathon Monday during which we grill and support the runners as they pass our house on the way to the finish line."),
    MockHost(name: "MIT Sigma Alpha Epsilon", username: "@mitsigmaalphaepsilon", oneLiner: "The worst frat at MIT", background: "profile-banner-4", followerCount: "1089", instagramLink: "https://instagram.com/sae.mit?igshid=Zjc2ZTc4Nzk=", websiteLink: "https://www.sae.mit.edu", description: "MIT SAE is a tightly-knit community of about 30 fun-loving guys who strive to excel in whatever our endeavors may be. Our members come from West Virginia to California, study everything from Math to Music, but find commonality in the idea that MIT is better when you’re part of a family. Ask any brother why they chose SAE, and they will likely tell you it’s because we’re “The Boys,” but beyond that, it’s because of our commitment to a supportive and inclusive environment that has served hundreds of brothers before us. Located at 155 Bay State Rd, SAE enjoys a prime location along the banks of the Charles, along with a short 10 minute bike commute to campus. If you want to join a community that has fun, works hard, and finds comfort in brotherhood, then be sure to come check us out!"),
]
