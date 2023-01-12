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
        ZStack {
            ScrollView(showsIndicators: false) {
                cover2
                
                content
            }
            .coordinateSpace(name: "scroll")
            .background(Color.mixerBackground)
            .ignoresSafeArea()
        }
        .preferredColorScheme(.dark)
        .onAppear { fadeIn() }
        .overlay {
            closeButton
        }
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
    
    var cover: some View {
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .named("scroll")).minY
            
            VStack {
            }
            .frame(maxWidth: .infinity)
            .frame(height: scrollY > 0 ? 500 + scrollY : 500)  //MARK: Change Flyer Height
            .background(
                Image("theta-chi-crest")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 290, height: 290)
                    .matchedGeometryEffect(id: "image 1", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
            )
            .background(
                ZStack {
                    Image("mit-banner")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .matchedGeometryEffect(id: "background 2", in: namespace)
                        .offset(y: scrollY > 0 ? -scrollY : 0)
                        .scaleEffect(scrollY > 0 ? scrollY / 500 + 1 : 1)
                        .blur(radius: scrollY > 0 ? scrollY / 20 : 0)
                        .opacity(0.9)
                    
                    Rectangle()
                        .fill(Color.clear)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .backgroundBlur(radius: 10, opaque: true)
                        .ignoresSafeArea()
                }
            )
            .mask(
                RoundedRectangle(cornerRadius: 20)
            )
            .overlay(
                //                VStack {
                VStack(alignment: .leading, spacing: 3) {
                    HStack {
                        Text("MIT Theta Chi")
                            .font(.title).bold()
                            .foregroundColor(.primary)
                            .lineLimit(2)
                            .minimumScaleFactor(0.5)
                        
                        Spacer()
                        Text(isFollowing ? "Following" : "Follow")
                            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                            .background {
                                Capsule()
                                    .stroke()
                            }
                            .onTapGesture {
                                let impact = UIImpactFeedbackGenerator(style: .light)
                                impact.impactOccurred()
                                withAnimation(.spring()) {
                                    showAlert.toggle()
                                    isFollowing.toggle()
                                }
                            }
                            .alert(isFollowing ? "Added to Favorites" : "Removed from Favorites", isPresented: $showAlert, actions: {})
                        
                        Button {
                            let impact = UIImpactFeedbackGenerator(style: .light)
                            impact.impactOccurred()
                            showingOptions.toggle()
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(Color.white)
                        }
                        .confirmationDialog("Select an option", isPresented: $showingOptions, titleVisibility: .hidden) {
                            Button("Report") {
                            }
                        }
                    }
                    
                    HStack {
                        Text("528 Beacon St, Boston MA")
                            .font(.body.weight(.semibold))
                            .foregroundColor(.white.opacity(0.7))
                        
                        Spacer()
                        
                        
                    }
                    
                    Divider()
                        .foregroundColor(.secondary)
                        .padding(.vertical, 4)
                    
                    HStack {
                        Image(systemName: "checkmark")
                            .imageScale(.small)
                            .foregroundColor(Color.white)
                            .padding(5)
                            .background(.ultraThinMaterial)
                            .backgroundStyle(cornerRadius: 18, opacity: 0.4)
                        
                        Text("Verified Host")
                            .font(.body.weight(.semibold))
                            .foregroundColor(.white.opacity(0.7))
                        
                        Spacer()
                        
                        Link(destination: URL(string: "https://instagram.com/mitthetachi?igshid=Zjc2ZTc4Nzk=")!) {
                            Image("Instagram-Icon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.white)
                                .frame(width: 22, height: 22)
                                .padding(6)
                                .background(.ultraThinMaterial)
                                .backgroundStyle(cornerRadius: 18, opacity: 0.4)
                        }
                        
                        Button(action: {
                            let latitude = 42.3507046
                            let longitude = -71.0909822
                            let url = URL(string: "maps://?saddr=&daddr=\(latitude),\(longitude)")
                            if UIApplication.shared.canOpenURL(url!) {
                                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                            }
                        }, label: {
                            Image(systemName: "map.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.white)
                                .frame(width: 20, height: 20)
                                .padding(7)
                                .background(.ultraThinMaterial)
                                .backgroundStyle(cornerRadius: 18, opacity: 0.4)
                        })
                        
                        Link(destination: URL(string: "http://ox.mit.edu/main/")!) {
                            Image(systemName: "globe")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.white)
                                .frame(width: 20, height: 20)
                                .padding(7)
                                .background(.ultraThinMaterial)
                                .backgroundStyle(cornerRadius: 18, opacity: 0.4)
                        }
                        
                        ShareLink(item: link) {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.white)
                                .frame(width: 20, height: 20)
                                .padding(7)
                                .background(.ultraThinMaterial)
                                .backgroundStyle(cornerRadius: 18, opacity: 0.4)
                        }
                    }
                    .font(.headline)
                }
                    .padding(EdgeInsets(top: 12, leading: 15, bottom: 12, trailing: 15))
                    .background(
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .backgroundStyle(cornerRadius: 30)
                    )
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(20)
                    .offset(y: 100)
            )
            .offset(y: scrollY > 0 ? -scrollY * 1.8 : 0)
        }
        .frame(height: 500)
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
        .padding(.bottom, 230)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 25) {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 12) {
                    Text("MIT Theta Chi")
                        .font(.largeTitle).bold()
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    
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
                                showAlert.toggle()
                                isFollowing.toggle()
                            }
                        }
                        .alert(isFollowing ? "Started following MIT Theta Chi" : "Stopped following MIT Theta Chi", isPresented: $showAlert, actions: {})
                    
                    Image(systemName: "square.and.arrow.up")
                        .imageScale(.large)
                        .fontWeight(.semibold)
                }
                
                Text("1845 Followers")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
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
                                Image("mock-user")
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
                        
                        
                        //                    Image("profile-banner-1")
                        //                        .resizable()
                        //                        .aspectRatio(contentMode: .fit)
                        //                        .clipShape(Circle())
                        //                        .frame(width: 40, height: 40)
                    }
                    
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 3) {
                            Text("Followed by")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            
                            Text("peytonlyons2002, fishcoop")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        
                        Text("and 3 more")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    
                }
                
            }
            
            Text("About this host")
                .font(.title).bold()
                .padding(.bottom, -10)
            
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
        .padding(EdgeInsets(top: 60, leading: 0, bottom: 120, trailing: 0))
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
    
    struct EventView_Previews: PreviewProvider {
        @Namespace static var namespace
        
        static var previews: some View {
            HostOrganizationView(parentViewModel: ExplorePageViewModel(), tabBarVisibility: .constant(.visible))
                .preferredColorScheme(.dark)
        }
    }
}

struct EventRow: View {
    var flyer: String
    var title: String
    var date: String
    var attendance: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(spacing: 15) {
                Image(flyer)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(title)
                            .fontWeight(.semibold)
                        
                        Text(date)
                            .fontWeight(.semibold)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    HStack {
                        Image(systemName: "person.3.fill")
                            .imageScale(.small)
                            .symbolRenderingMode(.hierarchical)
                        
                        Text("\(attendance) Attended")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                    }
                }
                .lineLimit(1)
                .minimumScaleFactor(0.75)
                
                Spacer()
                                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.white.opacity(0.7))
                })
            }
        }
        .frame(height: 60)
    }
}

struct StretchableHeader: View {
    let imageName: String
    
    var body: some View {
        GeometryReader { geometry in
            Image(self.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width,
                       height: geometry.height)
                .offset(y: geometry.verticalOffset)
        }
        .frame(height: 380)
    }
}

extension GeometryProxy {
    private var offset: CGFloat {
        frame(in: .global).minY
    }
    var height: CGFloat {
        size.height + (offset > 0 ? offset : 0)
    }
    
    var verticalOffset: CGFloat {
        offset > 0 ? -offset : 0
    }
}
