////
////  EventCardView.swift
////  mixer
////
////  Created by Jose Martinez on 12/20/22.
////
//
import SwiftUI

struct EventCard: View {

    var namespace: Namespace.ID
    let link = URL(string: "https://mixer.llc")!

    @EnvironmentObject var model: Model

    var body: some View {
        CustomStickyStackView {

            Label {
                Rectangle()
                    .fill(Color.mixerBackground)
                    .ignoresSafeArea()
                    .overlay {
                        VStack(alignment: .center, spacing: 8) {
                            VStack {
                                Text("Jan")
                                    .font(.headline.weight(.regular))
                                    .foregroundColor(.secondary)

                                Text("24")
                                    .font(.title.weight(.bold))
                            }

                            VStack(spacing: 2) {
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
                        HStack(alignment: .center) {
                            Text("Neon Party")
                                .font(.title).bold()
                                .lineLimit(2)
                                .minimumScaleFactor(0.75)
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
                    )
                }
                .background(
                    Image("theta-chi-party-poster")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                )
                .mask(
                    RoundedRectangle(cornerRadius: 20)
                )
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 20) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("MIT Party")
                                .font(.title2.weight(.semibold))
                                .minimumScaleFactor(0.75)

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
                    
                    Text("Neon Party at Theta Chi this Friday night, need we say more?")
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
        EventCard(namespace: namespace)
            .environmentObject(Model())
    }
}
