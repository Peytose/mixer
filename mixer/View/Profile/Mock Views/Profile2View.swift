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
    
//    @StateObject var viewModel = ProfileViewModel()
    @State var shareUsername = false
    @State var profileContext: ProfilePrototypeContext = .current
    @State var showSettings = false

    @Namespace var animation
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            if !showSettings {
                Color.mixerBackground
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        banner
                        
                        VStack(alignment: .leading, spacing: 20) {
                            Text("About")
                                .font(.title).bold()
                                .padding(.trailing, 10)
                            
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    PaddedImage(image: "figure.2.arms.open")
                                    
                                    Text("Taken")
                                }
                                
                                HStack {
                                    PaddedImage(image: "graduationcap.fill")
                                    
//                                    Text(viewModel.university)
                                    Text("MIT")
                                }
                                
                                HStack {
                                    PaddedImage(image: "house.fill")
                                    
                                    Text("ΘX")
                                }
                                
                                HStack {
                                    PaddedImage(image: "briefcase.fill")
                                    
                                    Text("Aerospace Engineering")
                                }
                                
                            }
                            .font(.headline.weight(.semibold))

                            
                            LazyVStack(pinnedViews: [.sectionHeaders]) {
                                Section(content: {
                                    if profileContext == .current {
                                        ForEach((1...3).reversed(), id: \.self) { event in
                                            EventCard(namespace: namespace)         .frame(height: 200)
                                                .padding(.horizontal, -10)
                                                .offset(y: 100)
                                        }
                                    } else {
                                        ForEach((1...15).reversed(), id: \.self) { event in
                                            EventCard(namespace: namespace)         .frame(height: 200)
                                                .padding(.horizontal, -10)
                                                .offset(y: 100)
                                        }                                }
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
                                        .padding(.bottom, 0)
                                    .background(Color.mixerBackground)
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
            } else {
                ProfileSettingsView()
                    .transition(.move(edge: .bottom))
                    .offset(y: 40)
                
            }
        }
        .ignoresSafeArea()
        .preferredColorScheme(.dark)
//        .task {
//            viewModel.getProfile()
//        }
        .overlay {
            navigationBarButtons
        }
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
                Image("banner-image-1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: 3) /// blur the image
                    .padding(-20) /// expand the blur a bit to cover the edges
                    .clipped() /// prevent blur overflow
                    .mask(Color.profileGradient) /// mask the blurred image using the gradient's alpha values
                    .matchedGeometryEffect(id: "profileBackground", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .scaleEffect(scrollY > 0 ? scrollY / 500 + 1 : 1)
                    .blur(radius: scrollY > 0 ? scrollY / 20 : 0)
                    .frame(height: 220)
                    .frame(maxWidth: .infinity)
                    .overlay {
                        VStack(spacing: -10) {
//                            Image(uiImage: viewModel.avatar)
                            Image("default-avatar")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipShape(Circle())
                                .frame(width: 110, height: 110)
                                .shadow(radius: 5, x: 0, y: 10)
                                .padding(.bottom, 20)
                            
                            VStack(spacing: 3) {
                                HStack {
//                                    Text("\(viewModel.firstName) \(viewModel.lastName)")
                                    Text("John Doe")
                                        .font(.largeTitle.weight(.bold))
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.75)
                                    
                                    Text("21")
                                        .foregroundColor(.secondary)
                                        .font(.largeTitle.weight(.bold))
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.75)
                                }
                                
//                                ShareLink(item: URL(string: "\(viewModel.firstName) \(viewModel.lastName)")!) {
                                    Text("@johndoe")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.blue)
//                                }
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
                let impact = UIImpactFeedbackGenerator(style: .light)
                impact.impactOccurred()
                withAnimation(.spring()) {
                    showSettings.toggle()
                }
            }, label: {
                Image(systemName: showSettings ? "person.fill" : "gearshape.fill")
                    .foregroundColor(Color.mainFont)
                    .font(.system(size: 28))
                    .shadow(radius: 10)

            })
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 20))
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
                .frame(width: 21, height: 21)
                .padding(8)
                .background(.ultraThinMaterial)
                .backgroundStyle(cornerRadius: 10, opacity: 0.5)
        }
    }
}
