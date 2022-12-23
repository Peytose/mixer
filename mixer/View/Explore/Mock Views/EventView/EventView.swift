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
            .coordinateSpace(name: "scroll")
            .background(Color.mixerBackground)
            .ignoresSafeArea()
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
                VStack(alignment: .leading, spacing: 8) {
                    
                    HStack {
//                        Text(viewModel.host.name)
                        Text("theta chi".capitalized)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.title3).bold()
                            .foregroundColor(.primary.opacity(0.7))
                        
                        Spacer()
                        
                        Image(systemName: "person.3.fill")
                            .symbolRenderingMode(.hierarchical)
                        
                        Text("156 going")
                            .font(.body.weight(.semibold))
                    }
                    
//                    Text(viewModel.event.title)
                    Text("Neon Party")
                        .font(.title).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.primary)
                    
                    HStack {
//                        Text("\(viewModel.event.inviteOnly) Party")
                        Text("invite only".capitalized)
                            .font(.body.weight(.semibold))
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
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
                    
                    HStack {
//                        LogoView(image: Image(uiImage: viewModel.host.crestImage))
                        LogoView(image: Image("theta-chi-crest"))
                        
//                        Text("Party organized by \(viewModel.event.creatorName)")
                        Text("Party organized by Jose Martinez")
                            .font(.footnote.weight(.medium))
                            .foregroundStyle(.secondary)
                    }
                }
                    .padding(20)
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
            
            HStack(spacing: 30) {
                VStack(alignment: .leading) {
                    Text("20")
                        .font(.title3.weight(.semibold))

                    Text("January")
                        .foregroundColor(.secondary)
                }
                
                VStack(alignment: .leading) {
                    Text("Tuesday")
                        .font(.title3.weight(.semibold))

                    Text("10:00 PM - 1:00 AM")
                        .foregroundColor(.secondary)
                }
                                
                Image(systemName: "drop.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .backgroundStyle(cornerRadius: 10, opacity: 0.6)
                    .cornerRadius(10)
                    .padding(.leading, 35)
            }
            .font(.headline)

            Text("About this event")
                .font(.title).bold()
                .padding(.bottom, -10)
            
//            Text(viewModel.event.description)
            Text("Neon Party at Theta Chi, need I say more?")
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
            
            HStack {
                Button(action: {
                    let impact = UIImpactFeedbackGenerator(style: .light)
                    impact.impactOccurred()
                    
                }, label: {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.mixerPurpleGradient)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .padding(.horizontal, 10)
                })
                .overlay {
                    Text("Get on the Guestlist")
                        .font(.title3.weight(.semibold))
                }
                .padding(.top, 20)
                .padding(.bottom, 10)
                
                Button(action: {
                    let impact = UIImpactFeedbackGenerator(style: .light)
                    impact.impactOccurred()
                    showingOptions.toggle()
                    
                }, label: {
                    Image(systemName: "ellipsis")
                        .imageScale(.large)
                        .foregroundColor(.mixerIndigo)
                        .bold()
                        .padding(26)
                        .padding(.horizontal, -5)
                        .background(.ultraThinMaterial)
                        .backgroundStyle(cornerRadius: 10, opacity: 0.5)
//                        .background {
//                            RoundedRectangle(cornerRadius: 12, style: .continuous)
//                                .fill(Color.lifXLightGray)
//                                .frame(height: 60)
//                                .padding(.horizontal, -20)
//
//                        }

                   
                })
                .confirmationDialog("Select a color", isPresented: $showingOptions, titleVisibility: .visible) {
                                Button("Share Event") {
                                    selection = "Red"
                                }

                                Button("Report") {
                                    selection = "Green"
                                }
                                .foregroundColor(.red)
                            }
                .padding(.top, 20)
                .padding(.bottom, 10)
            }
            
            
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


