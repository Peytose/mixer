//
//  CourseItem.swift
//  mixer
//
//  Created by Jose Martinez on 1/24/23.
//

//
//  CourseItem.swift
//  DesignCodeiOS15
//
//  Created by Meng To on 2021-12-10.
//

import SwiftUI

struct CourseItem: View {
    
    var namespace: Namespace.ID
    var course: Course = courses[0]
    @State var showMore = false
    @State var showAlert = false
    @State var isFollowing = false
    let link = URL(string: "https://mixer.llc")!

    @Binding var show: Bool
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 7) {
                    Text(course.title)
                        .font(.largeTitle).bold()
                        .lineLimit(1)
                        .minimumScaleFactor(0.6)
                        .matchedGeometryEffect(id: "title\(course.id)", in: namespace)

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
                        .matchedGeometryEffect(id: "checkmark\(course.id)", in: namespace)

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
                        .matchedGeometryEffect(id: "follow\(course.id)", in: namespace)
                    
                }
                
                HStack(alignment: .center, spacing: 10) {
                    Text(course.subtitle)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white.opacity(0.8))
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                        .matchedGeometryEffect(id: "subtitle\(course.id)", in: namespace)

                    Text("1845 Followers")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                        .matchedGeometryEffect(id: "subtitle2\(course.id)", in: namespace)


                    Spacer()
                    
                    Link(destination: URL(string: "https://instagram.com/mitthetachi?igshid=Zjc2ZTc4Nzk=")!) {
                        Image("Instagram-Icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.white)
                            .frame(width: 22, height: 22)
                    }
                    .matchedGeometryEffect(id: "instagram\(course.id)", in: namespace)

                    
                    Link(destination: URL(string: "http://ox.mit.edu/main/")!) {
                        Image(systemName: "globe")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.white)
                            .frame(width: 22, height: 22)
                    }
                    .matchedGeometryEffect(id: "website\(course.id)", in: namespace)

                    ShareLink(item: link) {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .fontWeight(.medium)
                            .frame(width: 22, height: 22)
                    }
                    .buttonStyle(.plain)
                    .matchedGeometryEffect(id: "share\(course.id)", in: namespace)

                }
                
//                HStack(alignment: .center, spacing: 10) {
//                    Text(course.subtitle)
//                        .font(.subheadline)
//                        .fontWeight(.semibold)
//                        .foregroundColor(.white.opacity(0.8))
//                        .matchedGeometryEffect(id: "subtitle\(course.id)", in: namespace)
//
//
//                    Text("1845 Followers")
//                        .font(.subheadline)
//                        .fontWeight(.semibold)
//                        .foregroundColor(.secondary)
//                        .matchedGeometryEffect(id: "subtitle2", in: namespace)
//                }
                Text(course.text)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.8))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .matchedGeometryEffect(id: "text\(course.id)", in: namespace)
            }
            .padding(20)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .padding(-10)
                    .blur(radius: 30)
                    .matchedGeometryEffect(id: "blur\(course.id)", in: namespace)
            )
        }
        .foregroundStyle(.white)
        .background(
            Image(course.background)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "background\(course.id)", in: namespace)
        )
        .mask(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .matchedGeometryEffect(id: "mask\(course.id)", in: namespace)
        )
        .frame(width: 350, height: 300)
        .padding(20)
        .preferredColorScheme(.dark)
    }
}

struct CourseItem_Previews: PreviewProvider {
    @Namespace static var namespace
    
    static var previews: some View {
        CourseItem(namespace: namespace, show: .constant(true))
    }
}
