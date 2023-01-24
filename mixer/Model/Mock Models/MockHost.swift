//
//  MockHost.swift
//  mixer
//
//  Created by Jose Martinez on 1/24/23.
//

import SwiftUI

struct Course: Identifiable {
    let id = UUID()
    var title: String
    var subtitle: String
    var text: String
    var image: String
    var background: String
    var logo: String
}

var courses = [
    Course(title: "MIT Theta Chi", subtitle: "@mitthetachi", text: "Your number one spot for college parties!", image: "Illustration 9", background: "profile-banner-2", logo: "Logo 2"),
    Course(title: "MIT Phi Sig", subtitle: "@mitphisigmakappa", text: "The best frat at MIT", image: "Illustration 2", background: "Background 3", logo: "Logo 3"),
    Course(title: "MIT Sigma Alpha Epsilon", subtitle: "@mitsigmaalphaepsilon", text: "The worst frat at MIT", image: "Illustration 3", background: "Background 4", logo: "Logo 4"),
]
