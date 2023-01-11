////
////  EventCardView.swift
////  mixer
////
////  Created by Jose Martinez on 12/20/22.
////
//
import SwiftUI

struct EventCard: View {
    @EnvironmentObject var model: Model

    var event: MockEvent
    var namespace: Namespace.ID
    let link = URL(string: "https://mixer.llc")!

    var body: some View {
        CustomStickyStackView {
            Label {
                Rectangle()
                    .fill(Color.mixerBackground)
                    .ignoresSafeArea()
                    .overlay {
                        VStack(alignment: .center, spacing: 8) {
                            VStack {
                                Text(event.stickyMonth)
                                    .font(.headline.weight(.regular))
                                    .foregroundColor(.secondary)

                                Text(event.stickyDay)
                                    .font(.title.weight(.bold))
                            }

//                            VStack(spacing: 2) {
//                                Text(event.wetOrDry)
//                                    .font(.title3.weight(.bold))
//                                    .minimumScaleFactor(0.9)
//                            }
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
                        HStack(alignment: .center) {
                            Text(event.title)
                                .font(.title).bold()
                                .foregroundColor(.white)
                                .lineLimit(2)

                             Spacer()

                            Text(event.shortDate)
                                .font(.title3.weight(.semibold))
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                        }
                        .minimumScaleFactor(0.75)

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
                    )
                }
                .background(
                    Image(event.flyer)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                )
                .mask(
                    RoundedRectangle(cornerRadius: 20)
                )
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("\(event.wetOrDry) \(event.type)")
                                .font(.title2.weight(.semibold))
                                .minimumScaleFactor(0.75)

                            Text("By \(event.hostName)")
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
                            
                            Text("\(event.attendance) Going")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .offset(y: 1)
                        }
                        
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
                        }
                        .buttonStyle(.plain)
                    }
                    
                    Text(event.description)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.7))
                        .lineLimit(3)
                        .minimumScaleFactor(0.75)
                }
                .padding(.trailing)
            }
        }
    }
}
//
struct RandomItem_Previews: PreviewProvider {
    @Namespace static var namespace

    static var previews: some View {
        EventCard(event: events[1], namespace: namespace)
            .environmentObject(Model())
    }
}
