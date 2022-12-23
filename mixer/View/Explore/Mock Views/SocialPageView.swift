//
//  SocialPageView.swift
//  mixer
//
//  Created by Jose Martinez on 12/21/22.
//

import SwiftUI

struct ExplorePageView: View {
    @StateObject private var viewModel = ExplorePageViewModel()
    @EnvironmentObject var model: Model
    @Namespace var namespace
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Rectangle()
                    .fill(Color.mixerBackground)
                    .frame(maxWidth: geo.size.width, maxHeight: .infinity)
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
                        .frame(width: 100, height: 72)
                        .opacity(0)
                    
                    VStack(spacing: -50) {
                        //MARK: Featured Hosts
                        VStack(alignment: .leading, spacing: 18) {
                            Text("Featured")
                                .font(.title.weight(.semibold))
                                .background(
                                    Image("Blob 1")
                                        .offset(x: 305, y: 150)
                                        .opacity(0.8)
                                        .blur(radius: 10)
                                        .accessibility(hidden: true)
                                )
                                .padding(.leading)

                            TabView {
                                ForEach(1..<5) { i in
                                    GeometryReader { proxy in
                                        FeaturedHost()
                                            .cornerRadius(30)
                                            .modifier(OutlineModifier(cornerRadius: 30))
                                            .rotation3DEffect(
                                                .degrees(proxy.frame(in: .global).minX / -10),
                                                axis: (x: 0, y: 1, z: 0), perspective: 1
                                            )
                                            .blur(radius: abs(proxy.frame(in: .global).minX) / 40)
                                            .overlay(
                                                Image("theta-chi-crest")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .offset(x: 32, y: -80)
                                                    .frame(height: 230)
                                                //MARK: Parallax Effect (Changed it to 1.5 from 2 to make it faster)
                                                    .offset(x: proxy.frame(in: .global).minX / 1.5)
                                            )
                                            .padding(20)
                                            .onTapGesture {
                                                viewModel.showHostView.toggle()
                                            }
//                                            .onTapGesture {
//                                                hostManager.selectedHost = host
//                                                if let _ = hostManager.selectedHost { viewModel.showHostView = true }
//                                                viewModel.expandMenu = false
//                                            }
                                    }
                                }
                            }
                            .tabViewStyle(.page(indexDisplayMode: .never))
                            .frame(height: 460)
                        }
                        
                        LazyVStack(pinnedViews: [.sectionHeaders]) {
                            Section(content: {
                                if viewModel.exploreContext == .current {
                                    
                                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 300), spacing: 20)]) {
                                        EventCard(namespace: namespace)
                                            .frame(height: 300)
                                            .padding(.horizontal, -10)
                                            .onTapGesture {
                                                withAnimation(.openCard) {
                                                    //                                                    hostManager.selectedHost = host
                                                    viewModel.showEventView = true
                                                    viewModel.showNavigationBar = false

                                                    //                                                    eventManager.selectedEvent = event
                                                    //                                                    if let _ = eventManager.selectedEvent {
                                                    //                                                        viewModel.showEventView = true
                                                    //                                                        viewModel.showNavigationBar = false
                                                    //                                                    }
                                                }
                                            }
                                    }
                                } else {
                                    ForEach((1...4).reversed(), id: \.self) { event in
                                        EventCard(namespace: namespace)
                                            .frame(height: 300)
                                            .padding(.horizontal, -10)
                                            .onTapGesture {
                                                withAnimation(.openCard) {
                                                    //                                                    hostManager.selectedHost = host
                                                    viewModel.showEventView = true
                                                    viewModel.showNavigationBar = false

                                                    //                                                    eventManager.selectedEvent = event
                                                    //                                                    if let _ = eventManager.selectedEvent {
                                                    //                                                        viewModel.showEventView = true
                                                    //                                                        viewModel.showNavigationBar = false
                                                    //                                                    }
                                                }
                                            }
                                    }

                                }
                                
                            }, header: {
                                viewModel.stickyHeader()
                                    .background(Color.mixerBackground)
                                    .modifier(OffsetModifier(offset: $viewModel.headerOffsets.0, returnFromStart: false))
                                    .modifier(OffsetModifier(offset: $viewModel.headerOffsets.1))
                            })
                        }
                    }
                    .padding(.bottom, 120)
                }
                .padding(.top, 40)
                .coordinateSpace(name: "scroll")
                
                if viewModel.showEventView {
                    EventView(parentViewModel: viewModel)
                }
            }
            .ignoresSafeArea()
            .overlay(
                NavigationBar(title: "Explore", contentHasScrolled: $viewModel.contentHasScrolled, showNavigationBar: $viewModel.showNavigationBar, showLocation: true)
                    .opacity(viewModel.headerOffsets.0 < 70 ? 0 : 1)
            )
            .sheet(isPresented: $viewModel.showHostView) {
                HostOrganizationView()
            }
        .statusBar(hidden: viewModel.showEventView)
        }
    }
}

struct ExplorePageView_Previews: PreviewProvider {
    static var previews: some View {
        ExplorePageView()
            .preferredColorScheme(.dark)
            .environmentObject(Model())

    }
}
