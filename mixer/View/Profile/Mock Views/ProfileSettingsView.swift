//
//  UserProfileView.swift
//  mixer
//
//  Created by Jose Martinez on 12/18/22.
//

import SwiftUI

struct ProfileSettingsView: View {
    @StateObject var viewModel = UserProfileViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(Color.mixerBackground)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                List {
                    Section(header: Text("Personal Information").fontWeight(.semibold)) {
                        HStack {
                            Text("Email")
                            Spacer()
                            Text(viewModel.email)
                                .foregroundColor(.secondary)
                        }
                        HStack {
                            Text("Phone Number")
                            Spacer()
                            Text(viewModel.phone)
                                .foregroundColor(.secondary)
                        }
                    }
                    .listRowBackground(Color.mixerSecondaryBackground)
                    
                    SupportView()
                    LegalView()
                    
                    Rectangle()
                        .fill(Color.clear)
                        .listRowBackground(Color.clear)
                }
                .coordinateSpace(name: "scroll")
                .background(
                    Image("Blob 1")
                        .offset(x: 250, y: -180)
                        .blur(radius: 30)
                        .opacity(0.5)
                )
                .scrollContentBackground(.hidden)
                .listStyle(.insetGrouped)
                .padding(.bottom, 50)
            }
            .navigationTitle("Settings")
            .scrollIndicators(.hidden)
        }
    }
}


struct ProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingsView()
            .preferredColorScheme(.dark)
    }
}


fileprivate struct ProfileImageView: View {
//    var image: String
    
    var body: some View {
        ZStack {
//            AvatarView(image: , size: 170)
            Image("kingfisher-2.jpg")
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .shadow(radius: 20)
                .background(Circle().fill(.ultraThinMaterial))
                .frame(width: 170, height: 170)
            
            Image(systemName: "square.and.pencil")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
                .offset(y: 30)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel(Text("Profile photo"))
        .accessibilityHint(Text("Opens the iPhone's photo picker"))
    }
}


fileprivate struct SupportView: View {
    var body: some View {
        Section(header: Text("Support").fontWeight(.semibold)) {
            Link(destination: URL(string: "https://mixer.llc/contact/")!) {
                HStack {
                    HStack {
                        Image(systemName: "questionmark.circle")
                            .foregroundColor(.mixerIndigo)
                        Text("Help")
                    }
                    Spacer()
                    Image(systemName: "link")
                        .foregroundColor(.secondary)
                }
            }
        }
        .accentColor(.white)
        .listRowBackground(Color.mixerSecondaryBackground)
    }
}


fileprivate struct LegalView: View {
    var body: some View {
        Section(header: Text("LEGAL").fontWeight(.semibold)) {
            Link(destination: URL(string: "https://mixer.llc/privacy-policy/")!) {
                HStack {
                    Text("Privacy Policy")
                    Spacer()
                    Image(systemName: "link")
                        .foregroundColor(.secondary)
                }
            }
            
            Link(destination: URL(string: "https://mixer.llc")!) {
                HStack {
                    Text("Terms of Service")
                    Spacer()
                    Image(systemName: "link")
                        .foregroundColor(.secondary)
                }
            }
        }
        .listRowBackground(Color.mixerSecondaryBackground)
        .accentColor(.white)
    }
}
