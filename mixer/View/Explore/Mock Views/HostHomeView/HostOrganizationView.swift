//
//  HostOrganizationView.swift
//  mixer
//
//  Created by Jose Martinez on 1/24/23.
//

import SwiftUI
import MapKit

struct HostOrganizationView: View {
    @StateObject var viewModel: ExplorePageViewModel
    @StateObject private var memberManager = OrganizationMemberManager()
        
    @State private var showingOptions = false
    @State var showMore = false
    @State var showAlert = false
    @State var isFollowing = false
    @State var showFullFlyer = false
    @State var viewState: CGSize = .zero
    @State var appear = [false, false, false]

    @Environment(\.dismiss) var dismiss
    
    var namespace: Namespace.ID

    let coordinates = CLLocationCoordinate2D(latitude: 42.3507046, longitude: -71.0909822)
    let link = URL(string: "https://mixer.llc")!
    
    var host: MockHost = hosts[0]

    var eventList: [MockEvent] {
        return events
    }
    var results: [MockUser] {
        return users
    }
        
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                cover
                
                overlayedContent
                    .offset(y: -100)

                content
                    .opacity(appear[1] ? 1 : 0)
                    .offset(y: -90)

            }
            .background(Color.mixerBackground)
            .ignoresSafeArea()
            
            closeButton

            if viewModel.showUser {
                UserProfileView(viewModel: viewModel, user: memberManager.selectedMember!)
                    .transition(.move(edge: .bottom).combined(with: .scale(scale: 1.3)))
                    .zIndex(3)
            }
            
            if showFullFlyer {
                popUp
                    .transition(.scale(scale: 0.01))
                    .zIndex(1)
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            fadeIn()
        }
        .onChange(of: viewModel.showHostView) { newValue in
            fadeOut()
        }
    }
    
    var cover: some View {
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .global).minY
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(.black)
            .background(
                Image(host.background)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "background\(host.id)", in: namespace)
                    .mask(Color.profileGradient)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .scaleEffect(scrollY > 0 ? scrollY / 500 + 1 : 1)
                    .blur(radius: scrollY > 0 ? scrollY / 40 : 0)
                    .onLongPressGesture(minimumDuration: 0.5) {
                        let impact = UIImpactFeedbackGenerator(style: .heavy)
                        impact.impactOccurred()
                        withAnimation() {
                            showFullFlyer.toggle()
                        }
                    }
                    .zIndex(2)
            )
            .mask(
                RoundedRectangle(cornerRadius: appear[0] ? 0 : 30, style: .continuous)
                    .matchedGeometryEffect(id: "mask\(host.id)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
            )
        }
        .frame(height: 500)
    }
    
    var overlayedContent: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 7) {
                Text(host.name)
                    .font(.largeTitle).bold()
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                    .matchedGeometryEffect(id: "title\(host.id)", in: namespace)
                
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
                    .matchedGeometryEffect(id: "checkmark\(host.id)", in: namespace)
                
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
                    .matchedGeometryEffect(id: "follow\(host.id)", in: namespace)
            }
            
            
            HStack(alignment: .center, spacing: 10) {
                Text(host.username)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.8))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .matchedGeometryEffect(id: "subtitle\(host.id)", in: namespace)
                
                Spacer()
                
                Link(destination: URL(string: host.instagramLink)!) {
                    Image("Instagram-Icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.white)
                        .frame(width: 22, height: 22)
                }
                .matchedGeometryEffect(id: "instagram\(host.id)", in: namespace)
                
                Link(destination: URL(string: host.websiteLink)!) {
                    Image(systemName: "globe")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.white)
                        .frame(width: 22, height: 22)
                }
                .matchedGeometryEffect(id: "website\(host.id)", in: namespace)
                
                ShareLink(item: link) {
                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .fontWeight(.medium)
                        .frame(width: 22, height: 22)
                }
                .buttonStyle(.plain)
                .matchedGeometryEffect(id: "share\(host.id)", in: namespace)
                
            }
            
            Text("\(host.followerCount) Followers")
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
                .matchedGeometryEffect(id: "subtitle2\(host.id)", in: namespace)
            
            Text(host.oneLiner)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundColor(.white.opacity(0.8))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .matchedGeometryEffect(id: "text\(host.id)", in: namespace)
            
            HStack {
                HStack(spacing: -8) {
                    Image("profile-banner-1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 28, height: 28)
                        .clipShape(Circle())
                        .padding(1)
                        .background(Color.mixerBackground)
                        .clipShape(Circle())
                    
                    Image("mock-user-1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 28, height: 28)
                        .clipShape(Circle())
                        .padding(1)
                        .background(Color.mixerBackground)
                        .clipShape(Circle())
                    
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
            .opacity(appear[2] ? 1 : 0)
        }
        .padding(.horizontal)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("About this host")
                .font(.title).bold()
                .padding(.bottom, -14)
                .padding(.top, -10)
            
            VStack {
                Text(host.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .lineLimit(showMore ? nil : 4)
                
                Text(showMore ? "Show less" : "Show more")
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
                .onTapGesture {
                    withAnimation(.openCard) {
                        viewModel.showUser.toggle()
                        memberManager.selectedMember = user
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 120, trailing: 16))
    }
    
    var popUp: some View {
        GeometryReader { proxy in
            ZStack {
                Rectangle()
                    .fill(Color.clear)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .backgroundBlur(radius: 10, opaque: true)
                    .ignoresSafeArea()
                
                Image(host.background)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 370, height: 435)
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .aspectRatio(contentMode: .fit)
                    .modifier(ImageModifier(contentSize: CGSize(width: proxy.size.width, height: proxy.size.height)))
            }
        }
    }
    
    var closeButton: some View {
        Button {
            if showFullFlyer {
                withAnimation() {
                    showFullFlyer.toggle()
                }
            } else {
                withAnimation(.closeCard) {
                    viewModel.showHostView.toggle()
                    viewModel.showNavigationBar.toggle()
                    dismiss()
                }
            }
        } label: {XDismissButton()}
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(20)
        .padding(.top, 20)
        .ignoresSafeArea()
    }
    
    func fadeIn() {
        withAnimation(.easeOut.delay(0.3)) {
            appear[0] = true
        }
        withAnimation(.easeOut.delay(0.25)) {
            appear[1] = true
        }
        withAnimation(.easeOut.delay(0.15)) {
            appear[2] = true
        }
    }
    
    func fadeOut() {
            appear[0] = false
        withAnimation(.easeOut) {
            appear[1] = false
        }
        withAnimation(.easeOut) {
            appear[2] = false
        }
    }
    
}

struct HostOrganizationView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        HostOrganizationView(viewModel: ExplorePageViewModel(), namespace: namespace)
    }
}
