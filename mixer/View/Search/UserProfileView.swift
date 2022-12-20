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
    var user: MockUser

    @Namespace var animation
    @Namespace var namespace

    let gradient = LinearGradient(
        gradient: Gradient(stops: [
            .init(color: Color.black, location: 0),
            .init(color: .clear, location: 1)
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
    @State var profileContext: ProfileContext = .current
    
    var body: some View {
        ZStack {
            Color.lifXBackground
            ScrollView {
                VStack(alignment: .leading) {
                    banner
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("About")
                            .font(.title).bold()
                            .padding(.trailing, 10)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                PaddedImage(image: "figure.2.arms.open")
                                
                                Text(user.status)
                                    .font(.title3.weight(.semibold))
                            }
                            
                            HStack {
                                PaddedImage(image: "graduationcap.fill")
                                
                                Text(user.school)
                                    .font(.title3.weight(.semibold))
                            }
                            
                            HStack {
                                PaddedImage(image: "house.fill")
                                
                                Text(user.affiliation)
                                    .font(.title3.weight(.semibold))
                            }
                            
                            HStack {
                                PaddedImage(image: "briefcase.fill")
                                
                                Text(user.major)
                                    .font(.title3.weight(.semibold))
                            }
                            
                        }
                        LazyVStack(pinnedViews: [.sectionHeaders]) {
                            Section(content: {
                                if profileContext == .current {
                                    ForEach((1...1).reversed(), id: \.self) { event in
                                        EventCard(namespace: namespace)
                                            .frame(height: 200)
                                            .padding(.horizontal, -10)
                                            .offset(y: 100)
                                    }
                                } else {
                                    ForEach((1...3).reversed(), id: \.self) { event in
                                        EventCard(namespace: namespace)
                                            .frame(height: 200)
                                            .padding(.horizontal, -10)
                                            .offset(y: 100)
                                    }                                }
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
                                    .padding(.bottom, 0)
                                .background(Color.lifXBackground)
                                .offset(y: 70)
                            })
                        }
                        .offset(y: -50)

                        
                    }
                    .padding(.horizontal)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.bottom, 150)

            }
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "arrow.left")
                    .foregroundColor(.white)
                    .font(.system(size: 24))

            })
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(30)
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
                                .frame(width: 120, height: 120)
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
            .overlay {
                Button(action: {
                    let impact = UIImpactFeedbackGenerator(style: .light)
                    impact.impactOccurred()
                    withAnimation(.spring()) {
                        addFriend.toggle()
                    }
                }, label: {
                    Image(systemName: addFriend ? "person.crop.circle.badge.checkmark" : "person.crop.circle.badge.plus")
                        .symbolRenderingMode(addFriend ? .multicolor : .none)
                        .foregroundColor(.white)
                    .font(.system(size: 28))            })
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding(30)
            }
        }
        .padding(.bottom, 230)
    }
}

private struct PaddedImage: View {
    var image: String
    var body: some View {
        HStack {
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 22, height: 22)
                .padding(10)
                .background(.ultraThinMaterial)
                .backgroundStyle(cornerRadius: 10, opacity: 0.5)
                .cornerRadius(10)
            
        }
    }
}
