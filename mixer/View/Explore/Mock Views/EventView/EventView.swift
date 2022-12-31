//
//  EventView.swift
//  mixer
//
//  Created by Jose Martinez on 12/21/22.
//

import SwiftUI
import MapKit

struct EventView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var model: Model
    @StateObject var parentViewModel: ExplorePageViewModel
    @State var appear = [false, false, false]
    var isAnimated = true
    @State private var showingOptions = false
    @State private var selection = "None"
    @State var showFullFlyer = false
    @Namespace var namespace
    
    let coordinates = CLLocationCoordinate2D(latitude: 42.3507046, longitude: -71.0909822)
    let link = URL(string: "https://mixer.llc")!

    var body: some View {
        ZStack {
            ScrollView {
                cover
                
                content
                    .padding(.vertical, 80)
//                HostOrganizationView()
            }
            .padding(.bottom, 70)
            .coordinateSpace(name: "scroll")
            .background(Color.mixerBackground)
            .ignoresSafeArea()
            
            if showFullFlyer {
                Rectangle()
                    .fill(Color.clear)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .backgroundBlur(radius: 10, opaque: true)
                    .ignoresSafeArea()
                
                Image("theta-chi-party-poster")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 370, height: 435)
                    .overlay{
                        flyerCloseButton
                    }
            }
            
        }
        .zIndex(1)
        .preferredColorScheme(.dark)
        .onAppear { fadeIn() }
//        .onChange(of: model.showDetail) { show in
//            fadeOut()
//        }
        .overlay{
            closeButton
        }
        .overlay(alignment: .bottom) {
            HStack(spacing: -5) {
                Button(action: {
                    let impact = UIImpactFeedbackGenerator(style: .light)
                    impact.impactOccurred()
                    
                }, label: {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.mixerPurpleGradient)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .padding(.horizontal, 10)
                })
                .overlay {
                    HStack {
                        Image(systemName: "list.clipboard")
                            .imageScale(.large)
                            .foregroundColor(.white)
                        
                        Text("Get on the Guestlist")
                            .font(.title3.weight(.semibold))
                    }
                }
                
                Button(action: {
                    let impact = UIImpactFeedbackGenerator(style: .light)
                    impact.impactOccurred()
                    showingOptions.toggle()
                    
                }, label: {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(.ultraThinMaterial)
                        .backgroundStyle(cornerRadius: 12, opacity: 0.5)
                        .frame(maxWidth: 60)
                        .frame(height: 56)
                        .padding(.horizontal, 10)
                })
                .overlay {
                    Image(systemName: "ellipsis")
                        .imageScale(.large)
                }
                .confirmationDialog("Select an option", isPresented: $showingOptions, titleVisibility: .hidden) {
                                Button("Share Event") {
                                    selection = "Red"
                                }

                                Button("Report") {
                                    selection = "Green"
                                }
                            }
            }
            .padding(.bottom, 90)
            .opacity(showFullFlyer ? 0 : 1)
        }
    }
    
    func fadeIn() {
        withAnimation(.easeOut.delay(0.3)) {
            appear[0] = true
        }
        withAnimation(.easeOut.delay(0.4)) {
            appear[1] = true
        }
        withAnimation(.easeOut.delay(0.5)) {
            appear[2] = true
        }
    }
    
    func fadeOut() {
        withAnimation(.easeIn(duration: 0.1)) {
            appear[0] = false
            appear[1] = false
            appear[2] = false
        }
    }
    
    var cover: some View {
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .named("scroll")).minY
            
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: scrollY > 0 ? 500 + scrollY : 500)
            .background(
//                Image(uiImage: viewModel.event.flyerImage)
                Image("theta-chi-party-poster")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "background 1", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .accessibility(hidden: true)
                    .mask(
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 370, height: 435)
                    )
                    .onLongPressGesture {
                        let impact = UIImpactFeedbackGenerator(style: .heavy)
                        impact.impactOccurred()
                        withAnimation() {
                            showFullFlyer.toggle()
                        }
                    }
            )
            .background(
                ZStack {
//                    Image(uiImage: viewModel.event.flyerImage)
                    Image("theta-chi-party-poster")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .matchedGeometryEffect(id: "background 2", in: namespace)
                        .offset(y: scrollY > 0 ? -scrollY : 0)
                        .scaleEffect(scrollY > 0 ? scrollY / 500 + 1 : 1)
                        .blur(radius: scrollY > 0 ? scrollY / 20 : 0)
                        .opacity(0.9                                    )
                        .accessibility(hidden: true)
                    
                    Rectangle()
                        .fill(Color.clear)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .backgroundBlur(radius: 10, opaque: true)
                        .ignoresSafeArea()
                }
            )
            .mask(
                RoundedRectangle(cornerRadius: 20)
            )
            .overlay(
                VStack(alignment: .leading, spacing: 3) {
                    
                    HStack {
//                        Text(viewModel.host.name)
                        Text("MIT Theta Chi")
                            .font(.title3).bold()
                            .foregroundColor(.primary.opacity(0.7))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                        
                        Spacer()
                        
                        Text("Invite Only Event".capitalized)
                            .font(.title3).bold()
                            .foregroundColor(.primary.opacity(0.7))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                    }
                    
//                    Text(viewModel.event.title)
                    Text("Neon Party")
                        .font(.title).bold()
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.65)
                    
                    HStack {
                        Image(systemName: "person.3.fill")
                            .symbolRenderingMode(.hierarchical)
                        
                        Text("156 going")
                            .font(.body.weight(.semibold))
                        
                        Spacer()
                        ShareLink(item: link, message: Text("Join this party!")) {
                            Image(systemName: "square.and.arrow.up")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.white)
                                .frame(width: 20, height: 20)
                                .padding(7)
                                .background(.ultraThinMaterial)
                                .backgroundStyle(cornerRadius: 18, opacity: 0.4)
                        }
                    }
                    .foregroundColor(.primary.opacity(0.7))
                    
                    Divider()
                        .foregroundColor(.secondary)
                        .padding(.vertical, 4)
                    
                    HStack(spacing: 30) {
                                                
                        VStack(alignment: .leading) {
                            Text("Friday, Jan 20")
                                .font(.title3.weight(.semibold))

                            Text("10:00 PM - 1:00 AM")
                                .foregroundColor(.secondary)
                        }

                        VStack(alignment: .center) {
                            Image(systemName: "drop.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 22, height: 22)
//                                .padding(10)
                                .background(.ultraThinMaterial)
                                .backgroundStyle(cornerRadius: 10, opacity: 0.6)
                                .cornerRadius(10)

                            Text("Wet")
                                .foregroundColor(.secondary)
                        }
                        
                    }
                    .font(.headline)
                }
//                    .padding(20)
                    .padding(EdgeInsets(top: 15, leading: 20, bottom: 15, trailing: 20))
                    .background(
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .backgroundStyle(cornerRadius: 30)
                    )
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(20)
                    .offset(y: 100)
            )
            .overlay {
                hostLogo
            }
            .offset(y: scrollY > 0 ? -scrollY * 1.8 : 0)
        }
        .frame(height: 500)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 25) {


            Text("About this event")
                .font(.title).bold()
                .padding(.bottom, -10)
            
//            Text(viewModel.event.description)
            Text("Neon Party at Theta Chi, need we say more?")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text("Event Details")
                .font(.title).bold()
            
            VStack(alignment: .leading) {
                HStack(spacing: 12) {
                    PaddedImage(image: "clipboard.fill")
                    
                    VStack(alignment: .leading) {
//                        Text("\(viewModel.event.inviteOnly)")
                        Text("Invite Only")
                    }
                    .fontWeight(.semibold)
                }
                
                HStack(spacing: 12) {
                    PaddedImage(image: "calendar")
                    VStack(alignment: .leading) {
                        //                        Text("\(viewModel.event.startDate.formatDate(format: "EE, MMM d"))")
                        //                        Text("\(viewModel.event.startDate, style: .time) - \(viewModel.event.endDate, style: .time)")
                        Text("Fri, Jan 20")
                        Text("10:00 PM - 1:00 AM")
                            .foregroundColor(.secondary)
                    }
                    .fontWeight(.semibold)
                }
                
                HStack(spacing: 12) {
                    PaddedImage(image: "mappin")
                    
                    VStack(alignment: .leading) {
//                        Text("\(viewModel.host.name)")
                        Text("theta chi".capitalized)
                        
//                        Text("\(viewModel.host.address)")
                        Text("528 Beacon St, Boston MA")
                            .foregroundColor(.secondary)
                    }
                }
                
                HStack(spacing: 12) {
                    PaddedImage(image: "figure.dance")
                    
//                    Text("Theme: \(viewModel.event.theme)")
                    Text("Neon/Black light")
                }
                
                HStack(spacing: 12) {
                    PaddedImage(image: "drop.fill")
                    
//                    Text("\(viewModel.event.wetOrDry)")
                    Text("Wet Party")
                }
                
                HStack(spacing: 12) {
                    PaddedImage(image: "tshirt.fill")
                    
                    Text("General Party Clothes (Wear neon if possible)")
                }
            }
            .font(.headline)

            
            Text("Where you'll be")
                .font(.title).bold()
            
            MapSnapshotView(location: coordinates)
                .cornerRadius(12)
    
        }
        .padding()
    }
    
    var hostLogo: some View {
//        LogoView(image: Image(uiImage: viewModel.host.universityImage))
        LogoView(image: Image("2560px-MIT_logo.svg"))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(20)
            .padding(.top, 30)
            .ignoresSafeArea()
    }
    var closeButton: some View {
        Button {
            isAnimated ?
            withAnimation(.closeCard) {
                parentViewModel.showEventView.toggle()
                parentViewModel.showNavigationBar.toggle()
            }
            : presentationMode.wrappedValue.dismiss()
        } label: { XDismissButton() }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(20)
            .padding(.top, 30)
            .ignoresSafeArea()
    }
    
    var flyerCloseButton: some View {
        Button {
            withAnimation() {
                showFullFlyer.toggle()
            }
        } label: { XDismissButton() }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(.trailing)
            .ignoresSafeArea()
    }
}



struct EventView_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        EventView(parentViewModel: ExplorePageViewModel())
            .environmentObject(Model())
    }
}


private struct Details: View {
    var image: String
    var text: String
    
    var body: some View {
        HStack {
            Image(systemName: image)
            
            Text(text)
                .font(.title3.weight(.semibold))
            
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
                .frame(width: 22, height: 22)
                .padding(10)
                .background(.ultraThinMaterial)
                .backgroundStyle(cornerRadius: 10, opacity: 0.6)
                .cornerRadius(10)
            
        }
    }
}


