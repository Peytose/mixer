//
//  EventCardView.swift
//  mixer
//
//  Created by Jose Martinez on 12/20/22.
//

import SwiftUI

struct EventCard: View {
//    var event: EventRecord
//    var host: HostOrganization
    
    var namespace: Namespace.ID
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State var showActionSheet = false
    @State private var selection = "None"
    let link = URL(string: "https://mixer.llc")!

    var body: some View {
        CustomStickyStackView {
            Label {
                Rectangle()
                    .fill(Color.mixerBackground)
                    .ignoresSafeArea()
                    .overlay {
                        VStack {
//                            Text(event.startDate.formatDate(format: "MMM").capitalized)
                            Text("Jan")
                                .foregroundColor(.secondary)
                                .font(.title3.weight(.semibold))
                            
//                            Text(event.startDate.formatDate(format: "d"))
                            Text("24")
                                .font(.title3.weight(.black))
                            
//                            LogoView(image: Image(uiImage: host.universityImage), padding: 6)
                            Image("mit-logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 26, height: 26)
                                .cornerRadius(10)
                                .padding(6)
                                .background(.ultraThinMaterial)
                                .backgroundStyle(cornerRadius: 18, opacity: 0.4)
                        }
                        .padding(.top, 10)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    }
            } icon: {
            }
        } contentView: {
            VStack {
                VStack {
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Party")
                            .font(.body.weight(.semibold))
                            .foregroundColor(.white.opacity(0.7))
//                            .matchedGeometryEffect(id: "description\(event.id)", in: namespace)
                            .matchedGeometryEffect(id: "description1", in: namespace)
                        
//                        Text(event.title)
                        Text("Neon Party")
                            .font(.title).bold()
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
//                            .matchedGeometryEffect(id: "title\(event.id)", in: namespace)
                            .matchedGeometryEffect(id: "description2", in: namespace)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                    .background(
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                            .cornerRadius(30)
                            .blur(radius: 10)
                            .padding(.horizontal, -20)
                            .padding(.bottom, -10)
//                            .matchedGeometryEffect(id: "blur\(event.id)", in: namespace)
                            .matchedGeometryEffect(id: "description3", in: namespace)

                    )
                }
                .background(
//                    Image(uiImage: event.flyerImage)
                    Image("theta-chi-party-poster")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .disabled(true)
//                        .matchedGeometryEffect(id: "background\(event.id)", in: namespace)
                        .matchedGeometryEffect(id: "description4", in: namespace)

                )
                .mask(
                    RoundedRectangle(cornerRadius: 20)
//                        .matchedGeometryEffect(id: "mask\(event.id)", in: namespace)
                        .matchedGeometryEffect(id: "description5", in: namespace)

            )
                HStack {
//                    Text("Hosted by \(host.name.capitalized)")
                    Text("Hosted by Theta Chi")
                        .font(.body.weight(.semibold))
//                        .matchedGeometryEffect(id: "subtitle\(event.id)", in: namespace)
                        .matchedGeometryEffect(id: "description6", in: namespace)
                        .foregroundColor(.white.opacity(0.7))
                    Spacer()
                    ZStack {
                        UsersAttending(offset: -60, image: "Albert Headshot")
                        UsersAttending(offset: -40, image: "Andre Headshot")
                            .opacity(0.9)
                        UsersAttending(offset: -20, image: "default-crest-asset")
                            .opacity(0.8)
                        Image("default-avatar")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(Color.mixerIndigo)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 35, height: 35)
                            .clipShape(Circle())
                            .overlay {
                                Text("+45")
                                    .foregroundColor(.white)
                                    .font(.system(size: 11).weight(.semibold))
                            }
                    }
                    
                    
                }
            }
            //MARK: Suggestion: Will this maket the animation smoother?
            //                    .onTapGesture {
            //                        withAnimation(.openCard) {
            //                            model.showDetail = true
            //                            model.selectedCourse = futureParty.index
            //                        }
            //                }
        }
    }
}

struct EventCard_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        EventCard(namespace: namespace)
    }
}



private struct UsersAttending: View {
    var offset: CGFloat = 0
    var image: String = "default-avatar"
    var body: some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 35, height: 35)
            .clipShape(Circle())
            .offset(x: offset)
    }
}
