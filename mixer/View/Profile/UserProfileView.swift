//
//  UserProfileView.swift
//  mixer
//
//  Created by Jose Martinez on 12/18/22.
//

import SwiftUI

struct UserProfileView: View {
    @StateObject var viewModel = UserProfileViewModel()
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.lifXBackground)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            List {
                Section { }
                
                ZStack {
                    GeometryReader { proxy in
                        let offset = proxy.frame(in: .named("scroll")).minY
                        Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
                    }
                    .onPreferenceChange(ScrollPreferenceKey.self) { value in
                        withAnimation(.easeInOut) {
                            viewModel.contentHasScrolled = value < 100 ? true : false
                        }
                    }
                    
                    VStack(spacing: 4) {
                        ProfileImageView()
                            .onTapGesture {
                                viewModel.showNavigationBar = false
                                viewModel.isShowingPhotoPicker = true
                                viewModel.isShowingUpdateButton = true
                            }
                            .background(
                                HexagonBlobView()
                                    .offset(x: -50, y: -100)
                            )
                            .background(
                                BlobView()
                                    .offset(x: 230, y: -20)
                                    .scaleEffect(0.5)
                            )
                        Text("\(viewModel.firstName) \(viewModel.lastName)")
                            .font(.system(size: 27, weight: .semibold, design: .default))
                        HStack {
                            Image(systemName: "house.fill")
                                .imageScale(.medium)
                            
                            Text("ΘX")
                                .foregroundColor(.secondary)
                                .font(.title2.weight(.semibold))
                                .lineLimit(2)
                                .minimumScaleFactor(0.75)
                                .padding(.trailing, 10)
                            
                            Image(systemName: "graduationcap.fill")
                                .imageScale(.medium)
                            
                            Text("MIT")
                                .foregroundColor(.secondary)
                                .font(.title2.weight(.semibold))
                                .lineLimit(2)
                                .minimumScaleFactor(0.75)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 220)
                    .padding(.vertical, 10)
                }
                .listRowBackground(
                    ZStack {
                        Rectangle()
                            .fill(.black.opacity(0.05))
                            .background(.ultraThinMaterial.opacity(0.9))
                            .backgroundBlur(radius: 10)
                            .backgroundColor(opacity: 0.5)
                    }
                )

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
                .listRowBackground(Color.lifXLightGray)
                
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
            )
            .scrollContentBackground(.hidden)
            .listStyle(.insetGrouped)
            .padding(.bottom, 50)

            
//            if viewModel.isShowingUpdateButton {
//                VStack {
//                    Spacer()
//
//                    Button {
//                        viewModel.updateProfile()
//                        viewModel.isShowingUpdateButton = false
//                    } label: {
//                        OnboardButton(text: "Update")
//                    }
//                    .padding(.bottom, 50)
//                }
//            }
            
//            if viewModel.isLoading { LoadingView() }
        }
//        .task {
//            viewModel.getProfile()
//        }
        .overlay(
            NavigationBar(title: "Profile", showSearchView: .constant(false), onSocialPage: false, contentHasScrolled: $viewModel.contentHasScrolled, showNavigationBar: $viewModel.showNavigationBar)
        )
//        .sheet(isPresented: $viewModel.isShowingPhotoPicker) { PhotoPicker(image: $viewModel.avatar) }
//        .alert(item: $viewModel.alertItem, content: { $0.alert })
        .scrollIndicators(.hidden)
    }
}


struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
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
        .listRowBackground(Color.lifXLightGray)
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
        .listRowBackground(Color.lifXLightGray)
        .accentColor(.white)
    }
}
