//
//  MockUser.swift
//  mixer
//
//  Created by Jose Martinez on 12/20/22.
//

import SwiftUI

struct MockUser: Identifiable {
    let id = UUID()
    var index: Int
    var name: String
    var status: String
    var affiliation: String
    var image: String
    var school: String
    var major: String
    var username: String
    var banner: String
    var age: String
}
//Profile Background 2
//banner-image-1
var users = [
    MockUser(index: 0, name: "Albert Garcia", status: "Single and ready to mingle", affiliation: "ΘX", image: "mock-user", school: "MIT", major: "Computer Science", username: "albertgarcia1", banner: "banner-image-1", age: "22"),
    MockUser(index: 1, name: "Vijay Dey", status: "Down for anything", affiliation: "ΘX", image: "default-avatar", school: "MIT", major: "Quant Guy", username: "vijaydey", banner: "Profile Background 2", age: "21"),
    MockUser(index: 2, name: "Andre Hamelburg", status: "Taken :(", affiliation: "ΘX", image: "mock-user", school: "MIT", major: "Chemical Engineering", username: "andrehamelburg", banner: "Profile Background 2", age: "20"),
    MockUser(index: 3, name: "Divij Lankalapalli", status: "Ready to bang", affiliation: "ΘX", image: "default-avatar", school: "MIT", major: "Computer Science and Math", username: "divijlankalapalli", banner: "banner-image-1", age: "20"),
    MockUser(index: 4, name: "Spencer Yandrofski", status: "Newly Single", affiliation: "ΘX", image: "default-avatar", school: "MIT", major: "Mechanical Engineering", username: "spenceryandrofski", banner: "banner-image-1", age: "20"),
    MockUser(index: 5, name: "Roberto Sarabia", status: "Taken :)", affiliation: "ΘX", image: "default-avatar", school: "MIT", major: "Mechanical Engineering", username: "robertosarabia1", banner: "Profile Background 2", age: "22"),
    MockUser(index: 6, name: "Santiago Silvani", status: "DTF XOXO", affiliation: "BC", image: "default-avatar", school: "Boston College", major: "Business", username: "santiagosilvani", banner: "banner-image-1", age: "20"),
    MockUser(index: 7, name: "Mario Peraza", status: "Single and ready to mingle", affiliation: "ΘX", image: "mock-user", school: "MIT", major: "Mechanical Engineering", username: "marioperaza", banner: "banner-image-1", age: "20"),
    MockUser(index: 8, name: "Julian Hamelburg", status: "Down for anything", affiliation: "ΘX", image: "default-avatar", school: "MIT", major: "Computer Science and Music", username: "julianhamelburg", banner: "Profile Background 2", age: "22"),
    MockUser(index: 9, name: "John Doe", status: "Taken :(", affiliation: "ΘX", image: "mock-user", school: "MIT", major: "Aerospace Engineering", username: "johndoe12", banner: "Profile Background 2", age: "20"),
    MockUser(index: 10, name: "Juan Reyes", status: "Ready to bang", affiliation: "ΘX", image: "default-avatar", school: "MIT", major: "Math and Computer Science", username: "juanreyes", banner: "banner-image-1", age: "20"),
    MockUser(index: 11, name: "Lucas Marden", status: "French Kissing rn", affiliation: "ΘX", image: "default-avatar", school: "MIT", major: "Material Science", username: "lucasmarden", banner: "banner-image-1", age: "20"),
    MockUser(index: 12, name: "Gabriel Burbridge", status: "Taken :)", affiliation: "", image: "default-avatar", school: "MSU", major: "Physics", username: "gabrielburbridge", banner: "Profile Background 2", age: "20"),
    MockUser(index: 13, name: "Creel Hendricks", status: "DTF XOXO", affiliation: "", image: "default-avatar", school: "MIT", major: "Civil Engineering", username: "creelhendricks", banner: "Profile Background 2", age: "20"),
    MockUser(index: 14, name: "Kevin Awoufak", status: "Single and ready to mingle", affiliation: "ΘX", image: "mock-user", school: "MIT", major: "Computer Science", username: "kevinawoufak", banner: "banner-image-1", age: "20"),
    MockUser(index: 15, name: "Derek Liang", status: "Down for anything", affiliation: "ΘX", image: "default-avatar", school: "MIT", major: "Computer Science", username: "derekliang", banner: "banner-image-1", age: "20"),
    MockUser(index: 16, name: "Leon Fan", status: "Single", affiliation: "ΘX", image: "mock-user", school: "MIT", major: "Pre-med", username: "leonfan4", banner: "Profile Background 2", age: "20"),
    MockUser(index: 17, name: "Brian Robinson", status: "Ready to bang", affiliation: "ΘX", image: "default-avatar", school: "MIT", major: "Aerospace Engineering", username: "brianrobinson", banner: "banner-image-1", age: "20"),
    MockUser(index: 18, name: "Alex Edwards", status: "French Kissing rn", affiliation: "ΘX", image: "default-avatar", school: "MIT", major: "Mechanical Engineering and Nuclear Engineering", username: "alexedwards99", banner: "banner-image-1", age: "20"),
    MockUser(index: 19, name: "Erik Thompson", status: "Taken :)", affiliation: "", image: "default-avatar", school: "MIT", major: "Mechanical Engineering", username: "erickthompson7", banner: "Profile Background 2", age: "20"),
    MockUser(index: 20, name: "Peyton Lyons", status: "Taken ;)", affiliation: "", image: "default-avatar", school: "Fordham University", major: "Computer Science", username: "peytonlyons", banner: "banner-image-1", age: "20")
]
