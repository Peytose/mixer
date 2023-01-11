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
                        VStack(alignment: .center, spacing: 8) {
                            //                            Text(event.startDate.formatDate(format: "MMM").capitalized)
                            VStack {
                                Text("Jan")
                                    .font(.headline.weight(.regular))
                                    .foregroundColor(.secondary)
                                
                                Text("24")
                                    .font(.title.weight(.bold))
                            }
                            
                            //                            Text(event.startDate.formatDate(format: "d"))
                            
                            
                            //                            LogoView(image: Image(uiImage: host.universityImage), padding: 6)
//                            Image("mit-logo")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 26, height: 26)
//                                .cornerRadius(10)
//                                .padding(6)
//                                .background(.ultraThinMaterial)
//                                .backgroundStyle(cornerRadius: 18, opacity: 0.4)
                            VStack(spacing: 2) {
//                                Text("MIT")
//                                    .font(.title3.weight(.bold))
//                                    .foregroundColor(.secondary)
                                
                                Text("Wet")
                                    .font(.title3.weight(.bold))
                                    .minimumScaleFactor(0.9)
                            }
                            
                            
                        }
                        .padding(.top, 10)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    }
            } icon: {
            }
        } contentView: {
            VStack(spacing: 15) {
                VStack {
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 0) {
//                                                Text("Party")
//                                                    .font(.title3.weight(.semibold))
                        //                            .foregroundColor(.white.opacity(0.7))
                        ////                            .matchedGeometryEffect(id: "description\(event.id)", in: namespace)
                        //                            .matchedGeometryEffect(id: "description1", in: namespace)
                        
                        //                        Text(event.title)
                        HStack(alignment: .center) {
                            Text("Neon Party")
                                .font(.title).bold()
                                .lineLimit(2)
                                .minimumScaleFactor(0.75)
                            //                            .matchedGeometryEffect(id: "title\(event.id)", in: namespace)
                                .matchedGeometryEffect(id: "description2", in: namespace)
                                .foregroundColor(.white)
                            
                             Spacer()
                            
                            Text("Friday, 10:00 PM")
                                .font(.title3.weight(.semibold))
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                                .minimumScaleFactor(0.75)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 15)
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                    .background(
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .backgroundColor(opacity: 0.1)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                            .cornerRadius(30)
                            .blur(radius: 9)
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
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("MIT Party")
                                .font(.title2.weight(.semibold))
//                                .foregroundColor(Color.mixerIndigo)
                                .minimumScaleFactor(0.75)
                                .matchedGeometryEffect(id: "description1", in: namespace)
                            
                            Text("By MIT Theta Chi")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                                .minimumScaleFactor(0.3)

                        }
                        .padding(.trailing, -10)
                        
                        Spacer()
                        
                        VStack(spacing: 6) {
                            Image(systemName: "person.3.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 18, height: 18)
                                .symbolRenderingMode(.hierarchical)
                            
                            Text("156 Going")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .offset(y: 1)
                        }
//                        .padding(.bottom, -8)

                        ShareLink(item: link) {
                            VStack(spacing: 6) {
                                Image(systemName: "square.and.arrow.up")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 18, height: 18)
                                
                                
                                Text("Share Event")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                                    .offset(y: 1)

                            }
//                            .padding(.bottom, -8)
                        }
                        .buttonStyle(.plain)
                    }
                        //                    Text("Hosted by \(host.name.capitalized)")
                        Text("Neon Party at Theta Chi this Friday night, need we say more?")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                            .lineLimit(3)
                            .minimumScaleFactor(0.75)
                            .frame(maxWidth: .infinity, alignment: .leading)

                }
                .padding(.trailing)
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
