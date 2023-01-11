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
    @EnvironmentObject var model: Model
    @Namespace var namespace
    @Binding var tabBarVisibility: TabBarVisibility

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
                        .frame(height: 40)
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
                    
                    VStack(spacing: -50) {
                        //MARK: Featured Hosts
                        VStack(alignment: .leading, spacing: 18) {
                            Text("Featured Hosts")
                                .font(.largeTitle.weight(.bold))
                                .background(
                                    Image("Blob 1")
                                        .offset(x: 330, y: 230)
                                        .scaleEffect(0.9)
                                        .blur(radius: 10)
                                        .accessibility(hidden: true)
                                )
                                .padding(.leading, 20)

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
                                            .frame(height: 380)
                                            .onTapGesture {
                                                withAnimation(.openCard) {
                                                    viewModel.showEventView = true
                                                    viewModel.showNavigationBar = false
                                                    tabBarVisibility = .invisible
                                                }
                                            }
                                    }
                                } else {
                                    ForEach((1...4).reversed(), id: \.self) { event in
                                        EventCard(namespace: namespace)
                                            .frame(height: 380)
                                            .onTapGesture {
                                                withAnimation(.openCard) {
                                                    viewModel.showEventView = true
                                                    viewModel.showNavigationBar = false
                                                    tabBarVisibility = .invisible
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
                
                
                if viewModel.showEventView {
                    EventView(parentViewModel: viewModel, tabBarVisibility: $tabBarVisibility)
                        .transition(.move(edge: .bottom).combined(with: .scale(scale: 1.3)))
                        .zIndex(2)
                }
                
            }
            .ignoresSafeArea()
            .sheet(isPresented: $viewModel.showHostView) {
                HostOrganizationView(parentViewModel: viewModel)
            }
            .statusBar(hidden: viewModel.showEventView)
        
    }
}

struct ExplorePageView_Previews: PreviewProvider {
    static var previews: some View {
        ExplorePageView(tabBarVisibility: .constant(.visible))
            .preferredColorScheme(.dark)
            .environmentObject(Model())

    }
}
