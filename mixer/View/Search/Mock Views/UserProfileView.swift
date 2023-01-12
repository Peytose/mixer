//
//  UserProfileView.swift
//  mixer
//
//  Created by Jose Martinez on 12/20/22.
//

import SwiftUI



struct UserProfileView: View {
    
    enum ProfileContext: String, CaseIterable {
        case current = "Going to"
        case upcoming = "Events attended"
    }
    
//    @EnvironmentObject private var eventManager: EventManager
//    @EnvironmentObject private var hostManager: HostManager
//    @StateObject private var viewModel = ExplorePageViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State var addFriend = false
    @State var shareUsername = false
    @State private var selection = "None"
    @State var showAlert = false
    @State var isFriends = false
    @State var profileContext: ProfileContext = .current

    @Namespace var animation
    @Namespace var namespace
    
    let link = URL(string: "https://mixer.llc")!

    let gradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color.black, location: 0),
            .init(color: .clear, location: 1)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
    
    var user: MockUser
    
    var body: some View {
        ZStack {
            Color.mixerBackground
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    //                        banner
                    cover2
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(alignment: .center, spacing: 12) {
                            Text("Peyton Lyons")
                                .font(.largeTitle).bold()
                                .minimumScaleFactor(0.5)
                            
                            Text("20")
                                .font(.title2.weight(.medium))
                                .offset(x: 0)
                            
                            Spacer()
                            
                            Text(isFriends ? "\(Image(systemName: "person.fill.checkmark")) Friends" : "Add Friend")
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
                                        isFriends.toggle()
                                    }
                                }
                                .alert(isFriends ? "Started following MIT Theta Chi" : "Stopped following MIT Theta Chi", isPresented: $showAlert, actions: {})
                            
                            ShareLink(item: link) {
                                Image(systemName: "square.and.arrow.up")
                                    .imageScale(.medium)
                                    .fontWeight(.semibold)
                            }
                            .buttonStyle(.plain)
                            
                        }
                        .lineLimit(1)
                        
                        Text("\(Image(systemName: "graduationcap.fill")) Fordham University")
                            .font(.body)
                            .fontWeight(.medium)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        
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
                            }
                            
                            
                            VStack(alignment: .leading) {
                                HStack(spacing: 3) {
                                    Text("Friends with")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                    Text("josemartinez, fishcoop")
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
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("About")
                            .font(.title).bold()
                            .padding(.trailing, 10)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            DetailRow(image: "figure.2.arms.open", text: "Taken")
                            
                            DetailRow(image: "house.fill", text: "MIT Theta Chi")
                            
                            DetailRow(image: "briefcase.fill", text: "Computer Science")
                            
                        }
                        .font(.headline.weight(.semibold))
                        .padding(.bottom, -80)
                        
                        LazyVStack(pinnedViews: [.sectionHeaders]) {
                            Section(content: {
                                if profileContext == .current {
                                    ForEach(Array(events.enumerated().prefix(2)), id: \.offset) { index, event in
                                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 20)]) {
                                            EventCard(event: event, namespace: namespace)
                                                .frame(height: 380)
                                                .padding(.horizontal, -15)
                                                .offset(y: 100)
                                        }
                                        .redacted(reason: isFriends ? [] : .placeholder)
                                    }
                                    .redacted(reason: isFriends ? [] : .placeholder)
                                    .overlay(!isFriends ?
                                             Text("Only Jose's friends can see his activity")
                                        .font(.title).bold()
                                        .multilineTextAlignment(.center)
                                        .offset(y: 60)
                                             : nil, alignment: .center)
                                    
                                    
                                } else {
                                    ForEach(Array(events.enumerated()), id: \.offset) { index, event in
                                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 20)]) {
                                            EventCard(event: event, namespace: namespace)
                                                .frame(height: 380)
                                                .padding(.horizontal, -15)
                                                .offset(y: 100)
                                        }
                                    }
                                    .redacted(reason: isFriends ? [] : .placeholder)
                                    .overlay(!isFriends ?
                                             Text("Only Jose's friends can see his activity")
                                        .font(.title).bold()
                                        .multilineTextAlignment(.center)
                                        .offset(y: 60)
                                             : nil, alignment: .center)
                                }
                            }, header: {
                                HStack {
                                    ForEach(ProfileContext.allCases, id: \.self) { [self] context in
                                        VStack(spacing: 8) {
                                            Text(context.rawValue)
                                                .fontWeight(.semibold)
                                                .foregroundColor(profileContext == context ? .white : .gray)
                                            
                                            ZStack{
                                                if profileContext == context {
                                                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                                                        .fill(Color.mixerIndigo)
                                                        .matchedGeometryEffect(id: "TAB", in: animation)
                                                }
                                                else {
                                                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                                                        .fill(.clear)
                                                }
                                            }
                                            .frame(height: 4)
                                        }
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            withAnimation(.easeInOut) {
                                                self.profileContext = context
                                            }
                                        }
                                    }
                                }
                                .background(Color.mixerBackground)
                                .offset(y: 80)
                            })
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.bottom, 200)
            }
            .overlay {
                navigationBarButtons
            }
            
        }
        .ignoresSafeArea()
        .preferredColorScheme(.dark)
        .navigationBarHidden(true)
        .statusBar(hidden: true)
        
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(user: users[1])

    }
}

extension UserProfileView {
    var cover2: some View {
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .named("scroll")).minY
            
            VStack {
                StretchableHeader(imageName: "mock-user")
                    .mask(Color.profileGradient) /// mask the blurred image using the gradient's alpha values
                    .matchedGeometryEffect(id: "profileBackground", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .scaleEffect(scrollY > 0 ? scrollY / 500 + 1 : 1)
                    .blur(radius: scrollY > 0 ? scrollY / 40 : 0)
            }
        }
        .padding(.bottom, 230)
    }
    
    var banner: some View {
        
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .named("scroll")).minY
            
            VStack {
                Image("banner-image-1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: 3) /// blur the image
                    .padding(-20) /// expand the blur a bit to cover the edges
                    .clipped() /// prevent blur overflow
                    .mask(gradient) /// mask the blurred image using the gradient's alpha values
                    .matchedGeometryEffect(id: "profileBackground", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .scaleEffect(scrollY > 0 ? scrollY / 500 + 1 : 1)
                    .blur(radius: scrollY > 0 ? scrollY / 20 : 0)
                    .frame(height: 220)
                    .frame(maxWidth: .infinity)
                    .overlay {
                        VStack(spacing: -10) {
                            Image(user.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .frame(width: 110, height: 110)
                                .shadow(radius: 5, x: 0, y: 10)
                                .padding(.bottom, 20)
                            
                            VStack(spacing: 3) {
                                HStack {
                                    Text(user.name)
                                        .font(.largeTitle.weight(.bold))
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.75)
                                    
                                    Text(user.age)
                                        .foregroundColor(.secondary)
                                        .font(.largeTitle.weight(.bold))
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.75)
                                }
                                
                                ShareLink(item: URL(string: user.username)!) {
                                    Text("@\(user.username)")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.blue)
                                }
                            }
                            
                        }
                        .padding(.top, 75)
                    }
                
            }
        }
        .padding(.bottom, 230)
    }
    
    var navigationBarButtons: some View {
        ZStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                BackArrowButton()
            })
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(30)
        }
    }
}

private struct PaddedImage: View {
    var image: String
    var body: some View {
        HStack {
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .padding(8)
                .background(.ultraThinMaterial)
                .backgroundStyle(cornerRadius: 10, opacity: 0.5)
                .cornerRadius(10)
            
        }
    }
}
