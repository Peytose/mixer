//
//  Profile2View.swift
//  mixer
//
//  Created by Jose Martinez on 12/20/22.
//

import SwiftUI



struct UserProfilePrototypeView: View {
    
    enum ProfilePrototypeContext: String, CaseIterable {
        case current = "Going to"
        case upcoming = "Events attended"
    }
    
    var event: [MockEvent] {
        return events
    }
    
    @State var shareUsername = false
    @State var profileContext: ProfilePrototypeContext = .current
    @State var showSettingsView = false
    @State var showAlert = false
    @State var isFriends = false

    @Namespace var animation
    @Namespace var namespace
    
    let link = URL(string: "https://mixer.llc")!

    var body: some View {
        ZStack {
            Color.mixerBackground
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    banner
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(alignment: .center, spacing: 12) {
                            Text("Peyton Lyons")
                                .font(.title).bold()
                                .minimumScaleFactor(0.5)
                            
                            Text("20")
                                .font(.title2.weight(.medium))
                                .offset(x: 0)
                            
                            Spacer()
                            
                            Link(destination: URL(string: "https://instagram.com/mitthetachi?igshid=Zjc2ZTc4Nzk=")!) {
                                Image("Instagram-Icon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(Color.white)
                                    .frame(width: 24, height: 24)
                            }
                            .offset(y: 2)
                            
                            ShareLink(item: link) {
                                Image(systemName: "square.and.arrow.up")
                                    .imageScale(.large)
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
                            .padding(.top, -5)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            DetailRow(image: "figure.2.arms.open", text: "Taken")
                            
                            DetailRow(image: "house.fill", text: "MIT Theta Chi")
                            
                            DetailRow(image: "briefcase.fill", text: "Computer Science")
                            
                        }
                        .font(.headline.weight(.semibold))
                        .padding(.bottom, -80)
                        
                        eventSection
                    }
                    .padding(.horizontal)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.bottom, 160)
            }
        }
        .ignoresSafeArea()
        .preferredColorScheme(.dark)
        .sheet(isPresented: $showSettingsView, content: {
            ProfileSettingsView()
                .preferredColorScheme(.dark)
        })
    }
}

struct UserProfilePrototypeView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfilePrototypeView()

    }
}

extension UserProfilePrototypeView {
    var banner: some View {
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .named("scroll")).minY
            VStack {
                StretchableHeader(imageName: "mock-user-1")
                    .mask(Color.profileGradient) /// mask the blurred image using the gradient's alpha values
                    .matchedGeometryEffect(id: "profileBackground", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .scaleEffect(scrollY > 0 ? scrollY / 500 + 1 : 1)
                    .blur(radius: scrollY > 0 ? scrollY / 40 : 0)
            }
            .overlay(alignment: .topTrailing) {
                Button(action: {
                    let impact = UIImpactFeedbackGenerator(style: .light)
                    impact.impactOccurred()
                    withAnimation(.spring()) {
                        showSettingsView.toggle()
                    }
                }, label: {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(Color.mainFont)
                        .font(.system(size: 28))
                        .shadow(radius: 10)
                })
                .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 20))
            }
        }
        .padding(.bottom, 270)
    }
    
    var eventSection: some View {
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
                    }
                } else {
                    ForEach(Array(events.enumerated()), id: \.offset) { index, event in
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 20)]) {
                            EventCard(event: event, namespace: namespace)
                                .frame(height: 380)
                                .padding(.horizontal, -15)
                                .offset(y: 100)
                        }
                    }
                }
            }, header: {
                HStack {
                    ForEach(ProfilePrototypeContext.allCases, id: \.self) { [self] context in
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
        .padding(.bottom, 40)
    }
}

