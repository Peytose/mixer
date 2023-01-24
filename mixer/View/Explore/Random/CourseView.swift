//
//  CourseView.swift
//  mixer
//
//  Created by Jose Martinez on 1/24/23.
//

//
//  CourseView.swift
//  DesignCodeiOS15
//
//  Created by Meng To on 2021-12-10.
//

import SwiftUI
import MapKit

struct CourseView: View {
    @StateObject var parentViewModel: ExplorePageViewModel
    @StateObject private var memberManager = OrganizationMemberManager()

    @Environment(\.dismiss) var dismiss
    @State private var showingOptions = false
    @State private var currentAmount = 0.0
    @State private var finalAmount = 1.0
    @State var showMore = false
    @State var showAlert = false
    @State var isFollowing = false
    
    let coordinates = CLLocationCoordinate2D(latitude: 42.3507046, longitude: -71.0909822)
    let link = URL(string: "https://mixer.llc")!
    
    var eventList: [MockEvent] {
        return events
    }
    var results: [MockUser] {
        return users
    }
    
    var namespace: Namespace.ID
    var course: Course = courses[0]
    @Binding var show: Bool
    @State var appear = [false, false, false]
    @EnvironmentObject var model: Model
    @State var viewState: CGSize = .zero
    @State var isDraggable = true
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
                
                content
                    .padding(.top, -100)
                    .padding(.bottom, 200)
//                    .opacity(appear[2] ? 1 : 0)
            }
            .background(Color.mixerBackground)
            .mask(RoundedRectangle(cornerRadius: viewState.width / 3, style: .continuous))
            .shadow(color: .black.opacity(0.3), radius: 30, x: 0, y: 10)
            .scaleEffect(viewState.width / -500 + 1)
            .background(.black.opacity(viewState.width / 500))
            .background(.ultraThinMaterial)
            .gesture(isDraggable ? drag : nil)
            .ignoresSafeArea()
            
            button
            if parentViewModel.showUser {
                UserProfileView(viewModel: parentViewModel, user: memberManager.selectedMember!)
                    .transition(.move(edge: .bottom).combined(with: .scale(scale: 1.3)))
                    .zIndex(3)
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            fadeIn()
        }
        .onChange(of: show) { newValue in
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
                Image(course.background)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .matchedGeometryEffect(id: "background\(course.id)", in: namespace)
                        .mask(Color.profileGradient) /// mask the blurred image using the gradient's alpha values
                        .offset(y: scrollY > 0 ? -scrollY : 0)
                        .scaleEffect(scrollY > 0 ? scrollY / 500 + 1 : 1)
                        .blur(radius: scrollY > 0 ? scrollY / 40 : 0)
            )
            .mask(
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .matchedGeometryEffect(id: "mask\(course.id)", in: namespace)
        )
        }
        .frame(height: 500)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 7) {
                    Text(course.title)
                        .font(.largeTitle).bold()
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                        .matchedGeometryEffect(id: "title\(course.id)", in: namespace)

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
                        .matchedGeometryEffect(id: "checkmark\(course.id)", in: namespace)

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
                        .matchedGeometryEffect(id: "follow\(course.id)", in: namespace)

                }
                

                HStack(alignment: .center, spacing: 10) {
                    Text(course.subtitle)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white.opacity(0.8))
                        .matchedGeometryEffect(id: "subtitle\(course.id)", in: namespace)

                    Text("1845 Followers")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                        .matchedGeometryEffect(id: "subtitle2\(course.id)", in: namespace)


                    Spacer()
                    
                    Link(destination: URL(string: "https://instagram.com/mitthetachi?igshid=Zjc2ZTc4Nzk=")!) {
                        Image("Instagram-Icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.white)
                            .frame(width: 22, height: 22)
                    }
                    .matchedGeometryEffect(id: "instagram\(course.id)", in: namespace)

                    Link(destination: URL(string: "http://ox.mit.edu/main/")!) {
                        Image(systemName: "globe")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.white)
                            .frame(width: 22, height: 22)
                    }
                    .matchedGeometryEffect(id: "website\(course.id)", in: namespace)

                    ShareLink(item: link) {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .fontWeight(.medium)
                            .frame(width: 22, height: 22)
                    }
                    .buttonStyle(.plain)
                    .matchedGeometryEffect(id: "share\(course.id)", in: namespace)

                }
                
                Text(course.text)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.top, 10)
                    .matchedGeometryEffect(id: "text\(course.id)", in: namespace)
                
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
                        parentViewModel.showUser.toggle()
                        memberManager.selectedMember = user
                    }
                }
            }
        }
        .padding()
        .padding(.bottom, 120)
    }
    
    var button: some View {
        Button {
            withAnimation(.closeCard) {
                show.toggle()
//                model.showDetail.toggle()
                parentViewModel.showHostView.toggle()
            }
        } label: {
            Image(systemName: "xmark")
                .font(.body.weight(.bold))
                .foregroundColor(.secondary)
                .padding(8)
                .background(.ultraThinMaterial, in: Circle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(20)
        .padding(.top, 20)
        .ignoresSafeArea()
    }
    
    var overlayContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(course.title)
                .font(.largeTitle.weight(.bold))
                .matchedGeometryEffect(id: "title\(course.id)", in: namespace)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(course.subtitle.uppercased())
                .font(.footnote.weight(.semibold))
                .matchedGeometryEffect(id: "subtitle\(course.id)", in: namespace)
            Text(course.text)
                .font(.footnote)
                .matchedGeometryEffect(id: "text\(course.id)", in: namespace)
            Divider()
                .opacity(appear[0] ? 1 : 0)
            HStack {
                Image("Avatar Default")
                    .resizable()
                    .frame(width: 26, height: 26)
                    .cornerRadius(10)
                    .padding(8)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                Text("Taught by Meng To")
                    .font(.footnote)
            }
            .opacity(appear[1] ? 1 : 0)
        }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .matchedGeometryEffect(id: "blur\(course.id)", in: namespace)
            )
            .offset(y: 250)
            .padding(20)
    }
    
    var drag: some Gesture {
        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .onChanged { value in
                guard value.translation.width > 0 else { return }
                
                if value.startLocation.x < 100 {
                    withAnimation(.closeCard) {
                        viewState = value.translation
                    }
                }
                
                if viewState.width > 120 {
                    close()
                }
            }
            .onEnded { value in
                if viewState.width > 80 {
                    close()
                } else {
                    withAnimation(.closeCard) {
                        viewState = .zero
                    }
                }
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
        appear[0] = false
        appear[1] = false
        appear[2] = false
    }
    
    func close() {
        withAnimation(.closeCard.delay(0.3)) {
            show.toggle()
            model.showDetail.toggle()
        }
        
        withAnimation(.closeCard) {
            viewState = .zero
        }
        
        isDraggable = false
    }
}

struct CourseView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        CourseView(parentViewModel: ExplorePageViewModel(), namespace: namespace, show: .constant(true))
            .environmentObject(Model())
    }
}
