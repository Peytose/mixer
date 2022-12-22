import SwiftUI
////
////  HostHomeView.swift
////  mixer
////
////  Created by Jose Martinez on 12/21/22.
////
//
////
////  HostHomepageView.swift
////  mixer
////
////  Created by Jose Martinez on 9/27/22.
////
//
import SwiftUI
import CloudKit

struct HostOrganizationView: View {
    @Environment(\.dismiss) var dismiss
    @State var viewState: CGSize = .zero
    @State var appear = [false, false, false]
    @State var showMore = false
    @State var isLiked = false
    @State var showLikedMessage = false
    @State var showEventView = false

    let coordinates = CLLocationCoordinate2D(latitude: 42.3507046, longitude: -71.0909822)
    
    @EnvironmentObject var model: Model
    @Environment(\.presentationMode) var presentationMode
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            ScrollView {
//                cover
                Circle()
                    .fill(.blue)

//                content
//                    .offset(y: 120)
//                    .padding(.bottom, 200)
//                    .padding(.top, -30)
//                    .opacity(appear[2] ? 1 : 0)
            }
//            .coordinateSpace(name: "scroll")
//            .background(Color.mixerBackground)
//            .mask(RoundedRectangle(cornerRadius: appear[0] ? 0 : 30))
//            .mask(RoundedRectangle(cornerRadius: viewState.width / 3))
//            .modifier(OutlineModifier(cornerRadius: viewState.width / 3))
//            .shadow(color: Color("Shadow").opacity(0.5), radius: 30, x: 0, y: 10)
//            .scaleEffect(-viewState.width/500 + 1)
//            .background(.black.opacity(viewState.width / 500))
//            .background(.ultraThinMaterial)
//            .gesture(drag)
//            .ignoresSafeArea()
        }
//        .zIndex(1)
//        .onAppear { fadeIn() }
//        .overlay(alignment: .topTrailing, content: {
//            Button { dismiss() } label: { XDismissButton() }
//                .padding()
//        })
//        .sheet(isPresented: $showEventView) {
//            EventView()
//        }
    }
}

//extension HostOrganizationView {
//    var cover: some View {
//        GeometryReader { proxy in
//            let scrollY = proxy.frame(in: .named("scroll")).minY
//
//            VStack {
//                Spacer()
//            }
//            .frame(maxWidth: .infinity)
//            .frame(height: scrollY > 0 ? 500 + scrollY : 500)
//            .background(
////                Image(uiImage: viewModel.host.crestImage)
//                Image("theta-chi-crest")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .padding(20)
//                    .frame(width: 290, height: 290)
//                    .matchedGeometryEffect(id: "image 1", in: namespace)
//                    .offset(y: -50)
//                    .offset(y: scrollY > 0 ? -scrollY : 0)
//                    .accessibility(hidden: true)
//            )
//            .background(
//                ZStack {
//                    Image("mit-banner")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .matchedGeometryEffect(id: "background2", in: namespace)
//                        .offset(y: scrollY > 0 ? -scrollY : 0)
//                        .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
//                        .blur(radius: scrollY > 0 ? scrollY / 10 : 0)
//                        .opacity(0.6)
//                        .accessibility(hidden: true)
//
//                    Rectangle()
//                        .fill(Color.clear)
//                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//                        .backgroundBlur(radius: 15, opaque: true) //Originally 8
//                        .matchedGeometryEffect(id: "background2", in: namespace)
//                        .offset(y: scrollY > 0 ? -scrollY : 0)
//                        .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
//                        .blur(radius: scrollY > 0 ? scrollY / 10 : 0)
//                        .ignoresSafeArea()
//                }
//            )
//            .mask(
//                RoundedRectangle(cornerRadius: appear[0] ? 20 : 30)
//                    .matchedGeometryEffect(id: "mask", in: namespace)
//                    .offset(y: scrollY > 0 ? -scrollY : 0)
//            )
//            .overlay (
//                VStack(alignment: .leading, spacing: 10) {
//                    HStack {
////                        Text(viewModel.host.name)
//                        Text("Theta Chi")
//                            .font(.largeTitle).bold()
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .foregroundColor(.primary)
//                        .matchedGeometryEffect(id: "title", in: namespace)
//
//                        Image(systemName: isLiked ? "heart.fill" : "heart")
//                            .font(.title2.weight(.semibold))
//                            .foregroundColor(isLiked ? Color.mixerIndigo : Color.secondary)
//                            .onTapGesture {
//                                let impact = UIImpactFeedbackGenerator(style: .light)
//                                impact.impactOccurred()
//                                withAnimation(.spring()) {
//                                    isLiked.toggle()
//                                    showLikedMessage.toggle()
//                                }
//                            }
//                            .alert("Added to favorites!", isPresented: $showLikedMessage, actions: {})
//                    }
//
//                    HStack {
////                        Text(viewModel.host.address.uppercased())
//                        Text("528 Beacon St".uppercased())
//                            .font(.body.weight(.semibold))
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .foregroundColor(.white.opacity(0.8))
//                            .matchedGeometryEffect(id: "subtitle", in: namespace)
//                        HStack(spacing: 15) {
//                            Image(systemName: "map.fill")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 24, height: 24)
//                                .foregroundColor(Color.white.opacity(0.8))
//                                .shadow(color: Color.black, radius: 8)
//
//                            Link(destination: URL(string: "http://ox.mit.edu/main/")!) {
//                                Image(systemName: "safari.fill")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: 24, height: 24)
//                                    .foregroundColor(Color.white.opacity(0.8))
//                                    .shadow(color: Color.black, radius: 8)
//                            }
//
//                            Image("Instagram-Icon")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .shadow(color: Color.black, radius: 8)
//                                .frame(width: 24, height: 24)
//
//                        }
//                    }
//
//                    Divider()
//                        .foregroundColor(.secondary)
//                        .opacity(appear[1] ? 1 : 0)
//
//                    HStack {
//                        Image("mixer-icon-white")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 26, height: 26)
//                            .cornerRadius(10)
//                            .padding(8)
//                            .background(.ultraThinMaterial)
//                            .backgroundStyle(cornerRadius: 18, opacity: 0.4)
//
//                        Text("This host is verified and partnered with mixer")
//                            .font(.footnote.weight(.semibold))
//                            .foregroundStyle(.secondary)
//                    }
//                    .opacity(appear[1] ? 1 : 0)
//                    .accessibilityElement(children: .combine)
//                }
//                    .padding(20)
//                    .padding(.vertical, 10)
//                    .padding(.trailing, -10)
//                    .padding(.leading, -10)
//                    .background(
//                        Rectangle()
//                            .fill(.ultraThinMaterial)
//                            .frame(maxHeight: .infinity, alignment: .bottom)
//                            .cornerRadius(30)
//                            .blur(radius: 30)
//                            .matchedGeometryEffect(id: "blur", in: namespace)
//                            .opacity(appear[0] ? 0 : 1)
//                    )
////                    .background(
////                        Rectangle()
////                            .fill(.ultraThinMaterial)
////                            .backgroundStyle(cornerRadius: 30)
////                            .opacity(appear[0] ? 1 : 0)
////                            .padding(.vertical, 10)
////                            .padding(.horizontal, -10)
////                    )
////                    .offset(y: scrollY > 0 ? -scrollY * 1.8 : 0)
////                    .frame(maxHeight: .infinity, alignment: .bottom)
////                    .offset(y: 100)
////                    .padding(20)
//            )
//            .overlay {
//                hostSchoolLogo
//            }
//        }
//        .frame(height: 500)
//    }
//
////    var content: some View {
////        VStack(alignment: .leading, spacing: 30) {
////            Text("Host Bio")
////                .font(.title).bold()
////                .offset(y: 10)
////
////            VStack(alignment: .leading, spacing: 5) {
////
//////                Text(viewModel.host.description)
////                Text("Established in 1902, Theta Chi Beta Chapter is the oldest active Theta Chi chapter in the country, and is one of the first fraternities founded at MIT. We have a storied history of developing leaders: our alumni go on to start companies, build self-driving cars, cure diseases, get involved in politics, serve in the military, and change the world. The brothers of Theta Chi are dedicated to helping each other achieve their goals and give back to the community.")
////                    .font(.system(size: 18).weight(.semibold))
////                    .foregroundColor(Color.mainFont)
////                    .lineLimit(showMore ? nil : 4)
////                    .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .leading)
////
////                Text("Read more")
////                    .fontWeight(.bold)
////                    .foregroundColor(.blue)
////                    .onTapGesture {
////                        withAnimation(.spring()) {
////                            showMore.toggle()
////                        }
////                    }
////
////            }
////
////            //            Text("Located at")
////            //                .font(.title).bold()
////            //
////            //            MapSnapshotView(location: coordinates)
////            //                .cornerRadius(12)
////
//////            if !eventManager.events[viewModel.host.id, default: []].isEmpty {
//////                VStack(alignment: .leading, spacing: -60) {
//////                    Text("Past Events")
//////                        .font(.title).bold()
//////
//////                    ScrollView(.vertical, showsIndicators: false) {
//////                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
//////                            ForEach(eventManager.events[viewModel.host.id, default: []]) { event in
//////                                PastEventRow(event: event)
//////                                    .onTapGesture {
//////                                        eventManager.selectedEvent = event
//////                                        if let _ = eventManager.selectedEvent { viewModel.showEventView = true }
//////                                    }
//////                            }
//////                        }
//////                        .padding(20)
//////                        .background(.ultraThinMaterial)
//////                        .backgroundStyle(cornerRadius: 30)
//////                        .padding(.vertical, 80)
//////                    }
//////                }
//////            } else { Text("No Past Events").font(.title).bold() }
////            Text("No Past Events").font(.title).bold()
////        }
////        .padding(20)
////    }
//
//    var hostSchoolLogo: some View {
//        LogoView(image: Image("2560px-MIT_logo.svg"))
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
//            .padding(15)
//            .matchedGeometryEffect(id: "logo", in: namespace)
//            .ignoresSafeArea()
//    }
//
////    var drag: some Gesture {
////
////        DragGesture(minimumDistance: 30, coordinateSpace: .local)
////            .onChanged { value in
////                guard value.translation.width > 0 else { return }
////
////                if value.startLocation.x < 100 {
////                    withAnimation {
////                        viewState = value.translation
////                    }
////                }
////
////                if viewState.width > 120 {
////                    close()
////                }
////            }
////            .onEnded { value in
////                if viewState.width > 80 {
////                    close()
////                } else {
////                    withAnimation(.openCard) {
////                        viewState = .zero
////                    }
////                }
////            }
////
////    }
//
////    func close() {
////        withAnimation {
////            viewState = .zero
////        }
////        withAnimation(.closeCard.delay(0.2)) {
////            model.showDetail = false
////            model.selectedCourse = 0
////        }
////    }
////
////    func fadeIn() {
////        withAnimation(.easeOut.delay(0.3)) {
////            appear[0] = true
////        }
////        withAnimation(.easeOut.delay(0.4)) {
////            appear[1] = true
////        }
////        withAnimation(.easeOut.delay(0.5)) {
////            appear[2] = true
////        }
////    }
////
////    func fadeOut() {
////        withAnimation(.easeIn(duration: 0.1)) {
////            appear[0] = false
////            appear[1] = false
////            appear[2] = false
////        }
////    }
//
//}

//struct HostOrganizationView_Previews: PreviewProvider {
//    @Namespace static var namespace
//
//    static var previews: some View {
//        HostOrganizationView()
//            .environmentObject(Model())
//            .preferredColorScheme(.dark)
//    }
//}



struct Previews_HostHomeView_Previews: PreviewProvider {
    static var previews: some View {
        HostOrganizationView()
            .environmentObject(Model())
    }
}

//struct HostHomePage: View {
//    var body: some View {
//        Rectangle()
//    }
//}
//
//struct HostHomePageView_Previews: PreviewProvider {
//    static var previews: some View {
//        HostHomePage()
//    }
//}
