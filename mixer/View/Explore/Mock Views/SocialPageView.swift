//
//  SocialPageView.swift
//  mixer
//
//  Created by Jose Martinez on 12/21/22.
//

import SwiftUI
import TabBar

struct ExplorePageView: View {
    
    @State var show = false
    @State var showStatusBar = true
    @State var selectedID = UUID()
    @EnvironmentObject var model: Model
        
    @Namespace var namespace

    @StateObject private var viewModel = ExplorePageViewModel()
    @StateObject private var eventManager = EventManager()
    @Binding var tabBarVisibility: TabBarVisibility
    
    var event: [MockEvent] {
        return events
    }
    
    var body: some View {
            ZStack {
                    ScrollView(showsIndicators: false) {
                        Rectangle()
                            .fill(.clear)
                            .frame(height: 30)
                            .frame(maxWidth: .infinity)
                            .overlay {
                                HStack {
                                    Circle()
                                        .fill(.clear)
                                        .frame(width: 40, height: 40)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        let impact = UIImpactFeedbackGenerator(style: .light)
                                        impact.impactOccurred()
                                        
                                        withAnimation(.spring(response: 2.2)) {
                                            viewModel.isRefreshing.toggle()
                                            
                                        }
                                    }) {
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
                                    }
                                    .buttonStyle(.plain)
                                } 
                                .padding(.horizontal)
                            }
                            .padding(.top, 15)
                        

                        VStack(alignment: .leading, spacing: 0) {
                            Text("Featured Hosts")
                                .font(.largeTitle.weight(.bold))
                                .padding(EdgeInsets(top: -10, leading: 20, bottom: 0, trailing: 0))
                            
                            ScrollView(.horizontal) {
                                LazyHGrid(rows: [GridItem(.adaptive(minimum: 300), spacing: 20)], spacing: 20) {
                                    if !viewModel.showHostView {
                                        cards
                                            .offset(x: -20)
                                    } else {
                                        ForEach(courses) { course in
                                            Rectangle()
                                                .fill(.white)
                                                .frame(height: 300)
                                                .cornerRadius(30)
                                                .shadow(color: Color("Shadow"), radius: 20, x: 0, y: 10)
                                                .opacity(0.3)
                                            .padding(.horizontal, 30)
                                            .offset(x: -20)

                                        }
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
//                            Text("Featured Hosts")
//                                .font(.largeTitle.weight(.bold))
//                                .padding(EdgeInsets(top: -10, leading: 20, bottom: 0, trailing: 0))
                            
    //                        if !viewModel.showHostView {
    //                            CourseItem(namespace: namespace)
    //                                .onTapGesture {
    //                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
    //                                        viewModel.showHostView.toggle()
    //                                        viewModel.showNavigationBar.toggle()
    //                                    }
    //                                }
    //                        } else {
    //                            Rectangle()
    //                                .fill(Color.clear)
    //                                .frame(height: 300)
    //                                .padding(20)
    //                                .padding(.bottom, 10)
    //                        }
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
                    
    //                if show {
    //                    detail
    //                }
                    
                    if viewModel.showHostView {
    //                    HostOrganizationView(namespace: namespace, parentViewModel: viewModel, tabBarVisibility: $tabBarVisibility)
    //                        .zIndex(2)
    //                        .transition(.asymmetric(
    //                            insertion: .opacity.animation(.easeInOut(duration: 0.1)),
    //                            removal: .opacity.animation(.easeInOut(duration: 0.2).delay(0.2))))
                        detail
                    }
                    
                    if viewModel.showEventView {
                        EventView(parentViewModel: viewModel, tabBarVisibility: $tabBarVisibility, event: eventManager.selectedEvent!)
                            .transition(.move(edge: .bottom).combined(with: .scale(scale: 1.3)))
                            .zIndex(3)
                    }
                }
                .ignoresSafeArea()
                .background(Color.mixerBackground)
                .statusBar(hidden: !viewModel.showNavigationBar)
                .onChange(of: viewModel.showHostView) { newValue in
                    withAnimation(.closeCard) {
                        if newValue {
                            showStatusBar = false
                        } else {
                            showStatusBar = true
                        }
                    }
            }
    }
    
    var cards: some View {
        ForEach(courses) { course in
            CourseItem(namespace: namespace, course: course, show: $show)
                .onTapGesture {
                    withAnimation(.openCard) {
//                        show.toggle()
                        viewModel.showHostView.toggle()
//                        model.showDetail.toggle()
                        showStatusBar = false
                        selectedID = course.id
                    }
            }
        }
    }
    var detail: some View {
    
        ForEach(courses) { course in
            if course.id == selectedID {
                CourseView(parentViewModel: viewModel, namespace: namespace, course: course, show: $show)
                    .zIndex(1)
                    .transition(.asymmetric(
                        insertion: .opacity.animation(.easeInOut(duration: 0.1)),
                    removal: .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))))
            }
        }
    }
}

struct ExplorePageView_Previews: PreviewProvider {
    static var previews: some View {
        ExplorePageView(tabBarVisibility: .constant(.visible))
            .preferredColorScheme(.dark)
            .environmentObject(Model())

    }
}

//struct CourseItem2: View {
//    var namespace: Namespace.ID
//
//    var body: some View {
//        VStack {
//            Spacer()
//            VStack(alignment: .leading, spacing: 5) {
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
//                        .matchedGeometryEffect(id: "subtitle2", in: namespace)
//                }
//
//                Text("Your number one spot for college parties!")
//                    .font(.body)
//                    .fontWeight(.semibold)
//                    .foregroundColor(.white.opacity(0.8))
//                    .lineLimit(1)
//                    .minimumScaleFactor(0.7)
//                    .matchedGeometryEffect(id: "text", in: namespace)
//            }
//            .padding(20)
//            .background(
//                Rectangle()
//                    .fill(.ultraThinMaterial)
//                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
//                    .padding(-5)
//                    .blur(radius: 20)
//                    .matchedGeometryEffect(id: "blur", in: namespace)
//            )
//        }
//        .foregroundStyle(.white)
//        .background(
//            Image("profile-banner-2")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .mask(Color.profileGradient) /// mask the blurred image using the gradient's alpha values
//                .matchedGeometryEffect(id: "background", in: namespace)
//        )
//        .mask(
//            RoundedRectangle(cornerRadius: 30, style: .continuous)
//                .matchedGeometryEffect(id: "mask", in: namespace)
//        )
//        .frame(height: 300)
//        .padding(20)
//    }
//}

//struct CourseItem2_Previews: PreviewProvider {
//    @Namespace static var namespace
//
//    static var previews: some View {
//        CourseItem2(namespace: namespace)
//    }
//}
