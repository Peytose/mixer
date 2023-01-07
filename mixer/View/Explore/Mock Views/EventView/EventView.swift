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
    
    @State private var currentAmount = 0.0
    @State private var finalAmount = 1.0
    
    let coordinates = CLLocationCoordinate2D(latitude: 42.3507046, longitude: -71.0909822)
    let link = URL(string: "https://mixer.llc")!
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                ZStack {
                    ScrollView(showsIndicators: false) {
                        cover
                        
                        content
                            .padding(.vertical, 80)
                        //                HostOrganizationView()
                    }
//                    .padding(.bottom, 120)
                    .coordinateSpace(name: "scroll")
                    .background(Color.mixerBackground)
                    .ignoresSafeArea()
                    
                    if showFullFlyer {
                        FlyerPopUpView()
                            .transition(.scale(scale: 0.3).combined(with: .opacity))
                            .zIndex(1)
                    }
                    
                }
                .zIndex(1)
                .preferredColorScheme(.dark)
                .onAppear { fadeIn() }
                
//                .customPopupView(isPresented: $showFullFlyer, popupView: { FlyerPopUpView() })
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
                                
                                Text("Get On The Guest List")
                                    .font(.title3.weight(.semibold))
                            }
                        }
                    }
                    .padding(.bottom, 10)
                    .opacity(showFullFlyer ? 0 : 1)
                }
            }
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
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "background 1", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .accessibility(hidden: true)
                    .mask(
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 370, height: 435)
                    )
                    .modifier(ImageModifier(contentSize: CGSize(width: proxy.size.width, height: proxy.size.height)))
                    .scaleEffect(finalAmount + currentAmount)
                    .onLongPressGesture(minimumDuration: 0.1) {
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
                        .opacity(0.9)
                    
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
                        
                        Text("Invite Only Party".capitalized)
                            .font(.title3).bold()
                            .foregroundColor(.primary.opacity(0.7))
                            .lineLimit(2)
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
                        
                        Button {
                            let impact = UIImpactFeedbackGenerator(style: .light)
                            impact.impactOccurred()
                            showingOptions.toggle()
                        } label: {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.white)
                                .frame(width: 19, height: 19)
                                .padding(7)
                                .background(.ultraThinMaterial)
                                .backgroundStyle(cornerRadius: 18, opacity: 0.4)
                        }
                        .confirmationDialog("Select an option", isPresented: $showingOptions, titleVisibility: .hidden) {
                            Button("Report") {
                                selection = "Green"
                            }
                        }
                    }
                    .foregroundColor(.primary.opacity(0.7))
                    
                    Divider()
                        .foregroundColor(.secondary)
                        .padding(.vertical, 4)
                    
                    HStack {
                        
                        VStack(alignment: .leading) {
                            Text("Friday, January 20")
                                .font(.title3.weight(.semibold))
                            
                            Text("10:00 PM - 1:00 AM")
                                .foregroundColor(.secondary)
                        }
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)
                        
                        Spacer()
                        
                        VStack(alignment: .center) {
                            Image(systemName: "drop.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 22, height: 22)
                            //                                .padding(10)
                                .background(.ultraThinMaterial)
                                .backgroundStyle(cornerRadius: 10, opacity: 0.6)
                                .cornerRadius(10)
                            
                            Text("Wet Event")
                                .foregroundColor(.secondary)
                        }
                    }
                    .font(.headline)
                }
                    .padding(EdgeInsets(top: 15, leading: 15, bottom: 15, trailing: 15))
                    .background(
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .backgroundStyle(cornerRadius: 30)
                    )
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(20)
                    .offset(y: 100)
            )
            .offset(y: scrollY > 0 ? -scrollY * 1.8 : 0)
        }
        .frame(height: 500)
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 25) {
            Text("About this event")
                .font(.title).bold()
                .padding(.bottom, -10)
            //                .offset(y: -200)
            
            //            Text(viewModel.event.description)
            Text("Neon Party at Theta Chi, need we say more?")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text("Event Details")
                .font(.title).bold()
            
            VStack(alignment: .leading) {
                HStack(spacing: 12) {
                    PaddedImage(image: "person.fill")
                    
                    Text("MIT Theta Chi Fraternity")
                        .fontWeight(.semibold)
                    
                }
                
                HStack(spacing: 12) {
                    PaddedImage(image: "clipboard.fill")
                    Text("Invite Only Event")
                        .fontWeight(.semibold)
                }
                
                HStack(spacing: 12) {
                    PaddedImage(image: "calendar")
                    VStack(alignment: .leading) {
                        //                        Text("\(viewModel.event.startDate.formatDate(format: "EE, MMM d"))")
                        //                        Text("\(viewModel.event.startDate, style: .time) - \(viewModel.event.endDate, style: .time)")
                        Text("Friday, January 20")
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
            
            Text("Friends Attending")
                .font(.title).bold()
                .padding(.bottom)
            
            ForEach(Array(results.enumerated()), id: \.offset) { index, user in
                if index != 0 { Divider() }
                NavigationLink(destination: UserProfileView(user: user)) {
                    HStack(spacing: 15) {
                        Image(user.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width: 40, height: 40)
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text(user.name)
                                    .font(.system(size: 18, weight: .semibold, design: .default))
                                    .lineLimit(1)
                                
                                    .foregroundColor(.white)
                                Text(user.school)
                                    .font(.system(size: 18, weight: .semibold, design: .default))
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding(.vertical, -16)
                }
            }
            
        }
        .padding()
        .padding(.leading, 4)
        .padding(.bottom, 100)
    }
    
    var closeButton: some View {
        Button {
            if showFullFlyer {
                withAnimation() {
                    showFullFlyer.toggle()
                }
            } else {
                isAnimated ?
                withAnimation() {
                    parentViewModel.showEventView.toggle()
                    parentViewModel.showNavigationBar.toggle()
                }
                : presentationMode.wrappedValue.dismiss()
            }
            
        } label: { XDismissButton() }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(20)
            .padding(.top, 30)
            .ignoresSafeArea()
    }
    
    var results: [MockUser] {
        return users
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
    
    private struct FlyerPopUpView: View {
        var body: some View {
            GeometryReader { proxy in
                ZStack {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .backgroundBlur(radius: 10, opaque: true)
                        .ignoresSafeArea()
                    
                    Image("theta-chi-party-poster")
                        .resizable()
                        .frame(width: 370, height: 435)
                        .frame(width: proxy.size.width, height: proxy.size.height)
                        .aspectRatio(contentMode: .fit)
                        .modifier(ImageModifier(contentSize: CGSize(width: proxy.size.width, height: proxy.size.height)))
                }
            }
        }
    }
}
