//
//  FeaturedHostCard.swift
//  mixer
//
//  Created by Jose Martinez on 1/24/23.
//

import SwiftUI

struct FeaturedHostCard: View {
    
    var namespace: Namespace.ID
    var host: MockHost = hosts[0]
    @State var showMore = false
    @State var showAlert = false
    @State var isFollowing = false
    let link = URL(string: "https://mixer.llc")!

    @Binding var show: Bool
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 7) {
                    Text(host.name)
                        .font(.largeTitle).bold()
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                        .matchedGeometryEffect(id: "title\(host.id)", in: namespace)

                    Image(systemName: "checkmark.seal.fill")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white, .blue)
                        .onTapGesture {
                            let impact = UIImpactFeedbackGenerator(style: .light)
                            impact.impactOccurred()
                            withAnimation(.spring()) {
                                showAlert.toggle()
                            }
                            
                        }
                        .alert("Verified Host", isPresented: $showAlert, actions: {}) {
                                Text("Verified badges are awarded to hosts that have provided proof of identity and have demonstrated that they have the necessary experience and qualifications to host a safe event")
                        }
                        .matchedGeometryEffect(id: "checkmark\(host.id)", in: namespace)

                    Spacer()
                    
                    Text(isFollowing ? "Following" : "Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(EdgeInsets(top: 5, leading: 8, bottom: 5, trailing: 8))
                        .background {
                            Capsule()
                                .stroke()
                        }
                        .onTapGesture {
                            let impact = UIImpactFeedbackGenerator(style: .light)
                            impact.impactOccurred()
                            withAnimation(.spring()) {
                                isFollowing.toggle()
                            }
                        }
                        .matchedGeometryEffect(id: "follow\(host.id)", in: namespace)
                    
                }
                
                HStack(alignment: .center, spacing: 10) {
                    Text(host.username)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white.opacity(0.8))
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                        .matchedGeometryEffect(id: "subtitle\(host.id)", in: namespace)

                    Spacer()
                    
                    Link(destination: URL(string: host.instagramLink)!) {
                        Image("Instagram-Icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.white)
                            .frame(width: 22, height: 22)
                    }
                    .matchedGeometryEffect(id: "instagram\(host.id)", in: namespace)

                    
                    Link(destination: URL(string: host.websiteLink)!) {
                        Image(systemName: "globe")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.white)
                            .frame(width: 22, height: 22)
                    }
                    .matchedGeometryEffect(id: "website\(host.id)", in: namespace)

                    ShareLink(item: link) {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .fontWeight(.medium)
                            .frame(width: 22, height: 22)
                    }
                    .buttonStyle(.plain)
                    .matchedGeometryEffect(id: "share\(host.id)", in: namespace)

                }
                
                Text("\(host.followerCount) Followers")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .matchedGeometryEffect(id: "subtitle2\(host.id)", in: namespace)
                
                Text(host.oneLiner)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.8))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .matchedGeometryEffect(id: "text\(host.id)", in: namespace)
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial.opacity(0.8))
                    .background(Color.mixerBackground.opacity(0.2))
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .padding(-10)
                    .padding(.horizontal, -15)
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur\(host.id)", in: namespace)
            )
        }
        .foregroundStyle(.white)
        .background(
            Image(host.background)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .mask(Color.profileGradient) /// mask the blurred image using the gradient's alpha values
                .matchedGeometryEffect(id: "background\(host.id)", in: namespace)
        )
        .mask(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .matchedGeometryEffect(id: "mask\(host.id)", in: namespace)
        )
        .frame(width: 350, height: 300)
        .padding(20)
        .preferredColorScheme(.dark)
    }
}

struct FeaturedHostCard_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        FeaturedHostCard(namespace: namespace, show: .constant(true))
    }
}
