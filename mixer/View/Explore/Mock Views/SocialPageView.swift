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

    @State var selectedID = UUID()
    @Binding var tabBarVisibility: TabBarVisibility
    
    @Namespace var namespace

    var event: [MockEvent] {
        return events
    }
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
            // MARK: Refresh Button
                refreshButtonHeader
                
                VStack(alignment: .leading, spacing: 0) {
                    //MARK: Featured Host Section
                    Text("Featured Hosts")
                        .font(.largeTitle.weight(.bold))
                        .padding(EdgeInsets(top: -10, leading: 20, bottom: 0, trailing: 0))
                    
                    featuredHostSection
                    //MARK: Events Section
                    eventsSection
                }
                .padding(.bottom, 120)
            }
            .padding(.top, 40)
            
            if viewModel.showHostView {
                hostView
            }
            
            if viewModel.showEventView {
                eventView
            }
        }
        .ignoresSafeArea()
        .background(Color.mixerBackground)
        .statusBar(hidden: !viewModel.showNavigationBar)
        .preferredColorScheme(.dark)
    }
    
    var refreshButtonHeader: some View {
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
    }
    
    var featuredHostSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.adaptive(minimum: 300), spacing: 20)], spacing: 20) {
                if !viewModel.showHostView {
                    featuredHostCards
                        .offset(x: -20)
                } else {
                    ForEach(hosts) { course in
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
    }
    
    var eventsSection: some View {
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
    
    var featuredHostCards: some View {
        ForEach(hosts) { course in
            FeaturedHostCard(namespace: namespace, host: course)
                .onTapGesture {
                    withAnimation(.openCard) {
                        viewModel.showHostView.toggle()
                        viewModel.showNavigationBar.toggle()
                        selectedID = course.id
                    }
            }
        }
    }
    var hostView: some View {
        ForEach(hosts) { course in
            if course.id == selectedID {
                HostOrganizationView(viewModel: viewModel, namespace: namespace, host: course)
                    .zIndex(1)
                    .transition(.asymmetric(
                        insertion: .opacity.animation(.easeInOut(duration: 0.1)),
                    removal: .opacity.animation(.easeInOut(duration: 0.3).delay(0.2))))
            }
        }
    }
    
    var eventView: some View {
        EventView(parentViewModel: viewModel, tabBarVisibility: $tabBarVisibility, event: eventManager.selectedEvent!)
            .transition(.move(edge: .bottom).combined(with: .scale(scale: 1.3)))
            .zIndex(3)
    }
}

struct ExplorePageView_Previews: PreviewProvider {
    static var previews: some View {
        ExplorePageView(tabBarVisibility: .constant(.visible))
    }
}
