////
////  HostHomeView.swift
////  mixer
////
////  Created by Jose Martinez on 12/21/22.
////
////
//
//
//  EventView.swift
//  mixer
//
//  Created by Jose Martinez on 12/21/22.
//

import SwiftUI
import MapKit
import TabBar

struct HostOrganizationView: View {
    var namespace: Namespace.ID
    @State var appear = [false, false, false]
    
    @StateObject var parentViewModel: ExplorePageViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showingOptions = false
    @State private var currentAmount = 0.0
    @State private var finalAmount = 1.0
    @State var showMore = false
    @State var showAlert = false
    @State var isFollowing = false
    @Binding var tabBarVisibility: TabBarVisibility
    
    let coordinates = CLLocationCoordinate2D(latitude: 42.3507046, longitude: -71.0909822)
    let link = URL(string: "https://mixer.llc")!
    
    var eventList: [MockEvent] {
        return events
    }
    var results: [MockUser] {
        return users
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
                
                content2
                    .padding(.top, 380)
//                    .opacity(appear[2] ? 1 : 0)
            }
            .background(Color.mixerBackground)
            .ignoresSafeArea()
            
            button
        }
        .preferredColorScheme(.dark)
        .onAppear {
            fadeIn()
        }
//        .onChange(of: show) { newValue in
//            fadeOut()
//        }
    }
    
    var cover: some View {
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .named("scroll")).minY
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 500)
            .foregroundStyle(.black)
            .background(
                    Image("profile-banner-2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .matchedGeometryEffect(id: "background", in: namespace)
                        .mask(Color.profileGradient) /// mask the blurred image using the gradient's alpha values
                        .offset(y: scrollY > 0 ? -scrollY : 0)
                        .scaleEffect(scrollY > 0 ? scrollY / 500 + 1 : 1)
                        .blur(radius: scrollY > 0 ? scrollY / 40 : 0)
            )
            .mask(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .matchedGeometryEffect(id: "mask", in: namespace)
        )
        }
//        .overlay(
//            VStack(alignment: .leading, spacing: 12) {
//                Text("MIT Theta Chi")
//                    .font(.largeTitle.weight(.bold))
//                    .matchedGeometryEffect(id: "title", in: namespace)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//
//                HStack(alignment: .center, spacing: 10) {
//                    Text("@mitthetachi")
//                        .font(.subheadline)
//                        .fontWeight(.semibold)
//                        .foregroundColor(.white.opacity(0.8))
//                        .matchedGeometryEffect(id: "subtitle", in: namespace)
//
//
//                    Text("1845 Followers")
//                        .font(.subheadline)
//                        .fontWeight(.semibold)
//                        .foregroundColor(.secondary)
//                }
//
//                Text("Your number one spot for college parties!")
//                    .font(.body)
//                    .fontWeight(.semibold)
//                    .foregroundColor(.white.opacity(0.8))
//                    .matchedGeometryEffect(id: "text", in: namespace)
//            }
//                .padding(20)
//                .background(
//                    Rectangle()
//                        .fill(.ultraThinMaterial)
//                        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
//                        .matchedGeometryEffect(id: "blur", in: namespace)
//                )
//                .offset(y: 250)
//                .padding(20)
//        )
    }
    var content2: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 7) {
                    Text("MIT Theta Chi")
                        .font(.largeTitle).bold()
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                        .matchedGeometryEffect(id: "title", in: namespace)

                    Image(systemName: "checkmark.seal.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white, .blue)
                        .onTapGesture {
                            let impact = UIImpactFeedbackGenerator(style: .light)
                            impact.impactOccurred()
                            withAnimation(.spring()) {
                                showAlert.toggle()
                            }
                            
                        }
                        .alert("Verified Host", isPresented: $showAlert, actions: {}) {
                                Text("Verified badges are awarded to hosts that have provided proof of identity and have demonstrated that they have the necessary experience and qualifications to host a safe event")
                        }

                    Spacer()
                    
                    Text(isFollowing ? "Following" : "Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(EdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 8))
                        .background {
                            Capsule()
                                .stroke()
                        }
                        .onTapGesture {
                            let impact = UIImpactFeedbackGenerator(style: .light)
                            impact.impactOccurred()
                            withAnimation(.spring()) {
                                isFollowing.toggle()
                            }
                        }

                    
                }
                

                HStack(alignment: .center, spacing: 10) {
                    Text("@mitthetachi")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white.opacity(0.8))
                        .matchedGeometryEffect(id: "subtitle", in: namespace)

                    Text("1845 Followers")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                        .matchedGeometryEffect(id: "subtitle2", in: namespace)


                    Spacer()
                    
                    Link(destination: URL(string: "https://instagram.com/mitthetachi?igshid=Zjc2ZTc4Nzk=")!) {
                        Image("Instagram-Icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.white)
                            .frame(width: 22, height: 22)
                    }
                    
                    Link(destination: URL(string: "http://ox.mit.edu/main/")!) {
                        Image(systemName: "globe")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.white)
                            .frame(width: 22, height: 22)
                    }
                    
                    ShareLink(item: link) {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .fontWeight(.medium)
                            .frame(width: 22, height: 22)
                    }
                    .buttonStyle(.plain)
                }
                
                Text("Your number one spot for college parties!")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.top, 10)
                    .matchedGeometryEffect(id: "text", in: namespace)
                
                HStack {
                    HStack(spacing: -8) {
                        Circle()
                            .stroke()
                            .foregroundColor(.mixerSecondaryBackground)
                            .frame(width: 28, height: 46)
                            .overlay {
                                Image("profile-banner-1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                            }
                        
                        Circle()
                            .stroke()
                            .foregroundColor(.mixerSecondaryBackground)
                            .frame(width: 28, height: 46)
                            .overlay {
                                Image("mock-user-1")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                            }
                        
                        Circle()
                            .fill(Color.mixerSecondaryBackground)
                            .frame(width: 28, height: 46)
                            .overlay {
                                Text("+3")
                                    .foregroundColor(.white)
                                    .font(.footnote)
                            }
                    }
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 3) {
                            Text("Followed by")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Text("peytonlyons2002, fishcoop")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        
                        Text("and 3 more")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            Text("About this host")
                .font(.title).bold()
                .padding(.bottom, -14)
                .padding(.top, -10)

            VStack {
                Text("Established in 1902, Theta Chi Beta Chapter is the oldest active Theta Chi chapter in the country, and is one of the first fraternities founded at MIT. We have a storied history of developing leaders: our alumni go on to start companies, build self-driving cars, cure diseases, get involved in politics, serve in the military, and change the world. The brothers of Theta Chi are dedicated to helping each other achieve their goals and give back to the community.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineLimit(showMore ? nil : 4)
                
                Text("Read more")
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .leading)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showMore.toggle()
                        }
                    }
            }
            
            Text("Located at")
                .font(.title).bold()
            
            MapSnapshotView(location: coordinates)
                .cornerRadius(12)
            
            VStack(alignment: .leading) {
                Text("Events hosted")
                    .font(.title).bold()
                    .padding(.bottom, 10)
                
                ForEach(Array(eventList.enumerated().prefix(9)), id: \.offset) { index, event in
                    EventRow(flyer: event.flyer, title: event.title, date: event.date, attendance: event.attendance)
                }
            }
            
            Text("Members of MIT Theta Chi")
                .font(.title).bold()
                .padding(.bottom, 10)

            ForEach(Array(results.enumerated().prefix(9)), id: \.offset) { index, user in
                if index != 0 { Divider() }
                NavigationLink(destination: UserProfileView(user: user)) {
                    HStack(spacing: 15) {
                        Image(user.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width: 40, height: 40)
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text(user.name)
                                    .font(.system(size: 18, weight: .semibold, design: .default))
                                    .lineLimit(1)
                                
                                    .foregroundColor(.white)
                                Text(user.school)
                                    .font(.system(size: 18, weight: .semibold, design: .default))
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding(.vertical, -16)
                }
            }
        }
        .padding()
        .padding(.bottom, 120)
    }

    var button: some View {
        Button {
            withAnimation(.closeCard) {
                parentViewModel.showHostView.toggle()
                parentViewModel.showNavigationBar.toggle()
                dismiss()
            }
        } label: {XDismissButton()}
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(20)
        .padding(.top, 35)
        .ignoresSafeArea()
    }
    
    func fadeIn() {
        withAnimation(.easeOut.delay(0.3)) {
            appear[0] = true
        }
        withAnimation(.easeOut.delay(0.4)) {
            appear[1] = true
        }
        withAnimation(.easeOut.delay(0.2)) {
            appear[2] = true
        }
    }
    
    func fadeOut() {
        appear[0] = false
        appear[1] = false
        appear[2] = false
    }
}

struct HostOrganizationView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        HostOrganizationView(namespace: namespace, parentViewModel: ExplorePageViewModel(), tabBarVisibility: .constant(.visible))
    }
}
