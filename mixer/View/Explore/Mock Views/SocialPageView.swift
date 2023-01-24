//
//  SocialPageView.swift
//  mixer
//
//  Created by Jose Martinez on 12/21/22.
//

import SwiftUI
import TabBar

struct ExplorePageView: View {
    @StateObject private var viewModel = ExplorePageViewModel()
    @StateObject private var eventManager = EventManager()

    @EnvironmentObject var model: Model
    @Namespace var namespace
    @Binding var tabBarVisibility: TabBarVisibility
    
    @State var show = false

    
    var event: [MockEvent] {
        return events
    }
    
    var body: some View {
            ZStack {
                Rectangle()
                    .fill(Color.mixerBackground)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView(showsIndicators: false) {
                    GeometryReader { proxy in
                        let offset = proxy.frame(in: .named("scroll")).minY
                        Color.clear.preference(key: ScrollPreferenceKey.self, value: offset)
                    }
                    .onPreferenceChange(ScrollPreferenceKey.self) { value in
                        withAnimation(.easeInOut) {
                            viewModel.contentHasScrolled = value < 0 ? true : false
                        }
                    }
                    
                    Rectangle()
                        .fill(.clear)
                        .frame(height: 30)
                        .frame(maxWidth: .infinity)
                        .overlay(alignment: .top) {
                            HStack {
                                Circle()
                                    .fill(.clear)
                                    .frame(width: 40, height: 40)
                                Spacer()
                                
                                Button(action: {}) {
                                    Circle()
                                        .fill(.ultraThinMaterial.opacity(0.9))
                                        .backgroundColor(opacity: 0.4)
                                        .backgroundBlur(radius: 10)
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                        .overlay {
                                            Image(systemName: "arrow.triangle.2.circlepath")
                                                .imageScale(.large)
                                                .fontWeight(.medium)
                                        }
                                        .rotationEffect(Angle(degrees: viewModel.isRefreshing ? 720 : 0))
                                        .onTapGesture {
                                            let impact = UIImpactFeedbackGenerator(style: .light)
                                            impact.impactOccurred()
                                            
                                            withAnimation(.spring(response: 2.2)) {
                                                viewModel.isRefreshing.toggle()
                                                
                                            }
                                        }
                                }
                                .buttonStyle(.plain)
                            }
                            .padding(.horizontal)
                        }
                        .padding(.top, -10)
                    

                    
                    
                    VStack(alignment: .leading, spacing: 0) {
                        //                        //MARK: Featured Hosts
                        //                        VStack(alignment: .leading, spacing: 18) {
                        Text("Featured Hosts")
                            .font(.largeTitle.weight(.bold))
//                            .background(
//                                Image("Blob 1")
//                                    .offset(x: 330, y: 240)
//                                    .scaleEffect(0.85)
//                                    .accessibility(hidden: true)
//                            )
                            .padding(.leading, 20)
                        
                        if !viewModel.showHostView {
                            CourseItem(namespace: namespace, show: $show)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                        viewModel.showHostView.toggle()
                                        viewModel.showNavigationBar.toggle()
                                    }
                                }
                                .padding(.bottom, 10)
                        } else {
//                            CourseItem(namespace: namespace, show: $show)
//                                .onTapGesture {
//                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
//                                        show.toggle()
//                                    }
//                                }
//                                .padding(.bottom, 10)
//                                .opacity(0.0)
                            Rectangle()
                                .fill(Color.clear)
                                .frame(height: 300)
                                .padding(20)
                        }
                        //
                        //                            TabView {
                        //                                ForEach(1..<5) { i in
                        //                                    GeometryReader { proxy in
                        //                                        FeaturedHost()
                        //                                            .cornerRadius(30)
                        //                                            .modifier(OutlineModifier(cornerRadius: 30))
                        //                                            .rotation3DEffect(
                        //                                                .degrees(proxy.frame(in: .global).minX / -10),
                        //                                                axis: (x: 0, y: 1, z: 0), perspective: 1
                        //                                            )
                        //                                            .blur(radius: abs(proxy.frame(in: .global).minX) / 40)
                        //                                            .overlay(
                        //                                                Image("theta-chi-crest")
                        //                                                    .resizable()
                        //                                                    .aspectRatio(contentMode: .fit)
                        //                                                    .offset(x: 32, y: -80)
                        //                                                    .frame(height: 230)
                        //                                                //MARK: Parallax Effect (Changed it to 1.5 from 2 to make it faster)
                        //                                                    .offset(x: proxy.frame(in: .global).minX / 1.5)
                        //                                            )
                        //                                            .padding(20)
                        //                                            .onTapGesture {
                        //                                                withAnimation(.openCard) {
                        //                                                    viewModel.showHostView = true
                        //                                                    viewModel.showNavigationBar = false
                        //                                                }
                        //                                            }
                        //                                    }
                        //                                }
                        //                            }
                        //                            .tabViewStyle(.page(indexDisplayMode: .never))
                        //                            .frame(height: 460)
                        //                        }
                        //
                        LazyVStack(pinnedViews: [.sectionHeaders]) {
                            Section(content: {
                                if viewModel.exploreContext == .current {
                                    ForEach(Array(events.enumerated().prefix(2)), id: \.offset) { index, event in
                                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 20)]) {
                                            EventCard(event: event, namespace: namespace)
                                                .frame(height: 380)
                                                .onTapGesture {
                                                    withAnimation(.openCard) {
                                                        viewModel.showEventView = true
                                                        viewModel.showNavigationBar = false
                                                        eventManager.selectedEvent = event
                                                        tabBarVisibility = .invisible
                                                    }
                                                }
                                        }
                                    }
                                } else {
                                    ForEach(Array(events.enumerated()), id: \.offset) { index, event in
                                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 20)]) {
                                            EventCard(event: event, namespace: namespace)
                                                .frame(height: 380)
                                                .onTapGesture {
                                                    withAnimation(.openCard) {
                                                        viewModel.showEventView = true
                                                        viewModel.showNavigationBar = false
                                                        eventManager.selectedEvent = event
                                                        tabBarVisibility = .invisible
                                                    }
                                                }
                                        }
                                    }
                                }
                            }, header: {
                                viewModel.stickyHeader()
                                    .background(Color.mixerBackground)
                            })
                        }
                    }
                    .zIndex(1)
                    .padding(.bottom, 120)
                }
                .padding(.top, 40)
                .coordinateSpace(name: "scroll")
                
                if viewModel.showHostView {
                    HostOrganizationView(namespace: namespace, parentViewModel: viewModel, tabBarVisibility: $tabBarVisibility)
                        .zIndex(2)
                        .transition(.asymmetric(
                            insertion: .opacity.animation(.easeInOut(duration: 0.1)),
                            removal: .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))))
                }
                
                if viewModel.showEventView {
                    EventView(parentViewModel: viewModel, tabBarVisibility: $tabBarVisibility, event: eventManager.selectedEvent!)
                        .transition(.move(edge: .bottom).combined(with: .scale(scale: 1.3)))
                        .zIndex(3)
                }
                
//                if viewModel.showHostView {
//                    HostOrganizationView(parentViewModel: viewModel, tabBarVisibility: $tabBarVisibility)
//                        .transition(.move(edge: .bottom).combined(with: .scale(scale: 1.3)))
//                        .zIndex(3)
//                }
                
               
                
            }
            .ignoresSafeArea()
            .statusBar(hidden: !viewModel.showNavigationBar)
    }
}

struct ExplorePageView_Previews: PreviewProvider {
    static var previews: some View {
        ExplorePageView(tabBarVisibility: .constant(.visible))
            .preferredColorScheme(.dark)
            .environmentObject(Model())

    }
}

struct CourseItem: View {
    var namespace: Namespace.ID
    @Binding var show: Bool
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 5) {
                Text("MIT Theta Chi")
                    .font(.largeTitle.weight(.bold))
                    .matchedGeometryEffect(id: "title", in: namespace)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
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
                }
                
                Text("Your number one spot for college parties!")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.8))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .matchedGeometryEffect(id: "text", in: namespace)
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .padding(-5)
                    .blur(radius: 20)
                    .matchedGeometryEffect(id: "blur", in: namespace)
            )
        }
        .foregroundStyle(.white)
        .background(
            Image("profile-banner-2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "background", in: namespace)
        )
        .mask(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .matchedGeometryEffect(id: "mask", in: namespace)
        )
        .frame(height: 300)
        .padding(20)
    }
}

struct CourseItem_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        CourseItem(namespace: namespace, show: .constant(true))
    }
}
//
//  CourseView.swift
//  DesignCodeiOS15
//
//  Created by Meng To on 2021-12-10.
//

//struct CourseView: View {
//    var namespace: Namespace.ID
//    @Binding var show: Bool
//
//    var body: some View {
//        ZStack {
//            ScrollView {
//                cover
//            }
//            .background(Color.mixerBackground)
//            .ignoresSafeArea()
//
//            Button {
//                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
//                    show.toggle()
//                }
//            } label: {
//                Image(systemName: "xmark")
//                    .font(.body.weight(.bold))
//                    .foregroundColor(.secondary)
//                    .padding(8)
//                    .background(.ultraThinMaterial, in: Circle())
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
//            .padding(20)
//            .ignoresSafeArea()
//        }
//    }
//
//    var cover: some View {
//        VStack {
//            Spacer()
//        }
//        .frame(maxWidth: .infinity)
//        .frame(height: 500)
//        .foregroundStyle(.black)
//        .background(
//            Image("profile-banner-2")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .matchedGeometryEffect(id: "background", in: namespace)
//        )
//        .mask(
//            RoundedRectangle(cornerRadius: 30, style: .continuous)
//                .matchedGeometryEffect(id: "mask", in: namespace)
//        )
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
//    }
//}

//struct CourseView_Previews: PreviewProvider {
//    @Namespace static var namespace
//
//    static var previews: some View {
//        CourseView(namespace: namespace, show: .constant(true))
//    }
//}
