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
    @StateObject var parentViewModel: ExplorePageViewModel
    @Environment(\.dismiss) var dismiss
    @State private var appear = [false, false, false]
    @State private var showingOptions = false
    @State private var currentAmount = 0.0
    @State private var finalAmount = 1.0
    @State var showMore = false
    @State var showAlert = false
    @State var isFollowing = false
    @Binding var tabBarVisibility: TabBarVisibility

    @Namespace var namespace
    
    let coordinates = CLLocationCoordinate2D(latitude: 42.3507046, longitude: -71.0909822)
    let link = URL(string: "https://mixer.llc")!
    var eventList: [MockEvent] {
        return events
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            cover2
            
            content
        }
        .background(Color.mixerBackground)
        .coordinateSpace(name: "scroll")
        .preferredColorScheme(.dark)
        .ignoresSafeArea()
        .overlay {
            closeButton
        }
    }
            
    var cover2: some View {
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .named("scroll")).minY
            
            VStack {
                StretchableHeader(imageName: "profile-banner-2")
                    .mask(Color.profileGradient) /// mask the blurred image using the gradient's alpha values
                    .matchedGeometryEffect(id: "profileBackground", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .scaleEffect(scrollY > 0 ? scrollY / 500 + 1 : 1)
                    .blur(radius: scrollY > 0 ? scrollY / 40 : 0)
            }
        }
        .padding(.bottom, 270)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 25) {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 7) {
                    Text("MIT Theta Chi")
                        .font(.largeTitle).bold()
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                    
                    Image(systemName: "checkmark.seal.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white, .blue)
                        .onTapGesture {
                            let impact = UIImpactFeedbackGenerator(style: .light)
                            impact.impactOccurred()
                            withAnimation(.spring()) {
                                showAlert.toggle()
                            }                        }
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
                
                HStack(spacing: 10) {
                    Text("1845 Followers")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Spacer()
                    
                    Link(destination: URL(string: "https://instagram.com/mitthetachi?igshid=Zjc2ZTc4Nzk=")!) {
                        Image("Instagram-Icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.white)
                            .frame(width: 20, height: 20)
                    }
                    
                    Link(destination: URL(string: "http://ox.mit.edu/main/")!) {
                        Image(systemName: "globe")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.white)
                            .frame(width: 20, height: 20)
                    }
                    
                    ShareLink(item: link) {
                        Image(systemName: "square.and.arrow.up")
                            .imageScale(.medium)
                            .fontWeight(.semibold)
                    }
                    .buttonStyle(.plain)
                }
                
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
                .padding(.bottom, -10)
                .padding(.top, -5)

            VStack {
                Text("Established in 1902, Theta Chi Beta Chapter is the oldest active Theta Chi chapter in the country, and is one of the first fraternities founded at MIT. We have a storied history of developing leaders: our alumni go on to start companies, build self-driving cars, cure diseases, get involved in politics, serve in the military, and change the world. The brothers of Theta Chi are dedicated to helping each other achieve their goals and give back to the community.")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .lineLimit(showMore ? nil : 4)
                
                Text("Read more")
                    .fontWeight(.bold)
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
                    EventRow(flyer: event.flyer, title: event.title, date: event.eventRowDate, attendance: event.attendance)
                }
            }
        }
        .padding()
        .padding(.bottom, 120)
    }
    
    var closeButton: some View {
        Button {
            withAnimation() {
                parentViewModel.showHostView.toggle()
                parentViewModel.showNavigationBar.toggle()
                tabBarVisibility = .visible
            }
            dismiss()
            
        } label: { XDismissButton() }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(20)
            .padding(.top, 30)
            .ignoresSafeArea()
    }
    
    func fadeIn() {
        withAnimation(.easeOut.delay(0.3)) {
            appear[0] = true
        }
        withAnimation(.easeOut.delay(0.4)) {
            appear[1] = true
        }
        withAnimation(.easeOut.delay(0.5)) {
            appear[2] = true
        }
    }
    
    func fadeOut() {
        withAnimation(.easeIn(duration: 0.1)) {
            appear[0] = false
            appear[1] = false
            appear[2] = false
        }
    }
}

struct EventView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        HostOrganizationView(parentViewModel: ExplorePageViewModel(), tabBarVisibility: .constant(.visible))
            .preferredColorScheme(.dark)
    }
}
