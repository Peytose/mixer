//
//  HostDashboardView.swift
//  mixer
//
//  Created by Jose Martinez on 1/14/23.
//

import SwiftUI

struct HostDashboardView: View {
    @Namespace var namespace
    
    @State var showEventInsightView = false
    
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center) {
                    HStack(spacing: 30) {
                        VStack {
                            Text("$0")
                                .font(.largeTitle.weight(.medium))
                            
                            Text("Total Revenue")
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                        
                        VStack {
                            Text("589")
                                .font(.largeTitle.weight(.medium))
                            
                            Text("Followers")
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    recentEventsSection
                        .onTapGesture {
                            showEventInsightView.toggle()
                        }
                    
                    CustomStackView {
                        Text("graph")
                    } contentView: {
                        FollowerGraphView(title: "Followers")
                    }

                    
                    CustomStackView {
                        Label {
                            Text("Dog")
                        } icon: {
                            Image(systemName: "person")
                        }
                    } contentView: {
                        LazyVGrid(columns: columns,spacing: 30) {
                            ForEach(1..<5) { x in
                            VStack(spacing: 32) {
                                
                                HStack{
                                    
                                    Text("Running")
                                        .font(.system(size: 22))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    
                                    Spacer(minLength: 0)
                                }
                                
                                // Ring...
                                
                                ZStack {
                                    
                                    Circle()
                                        .trim(from: 0, to: 1)
                                        .stroke(Color.blue.opacity(0.05), lineWidth: 10)
                                        .frame(width: (UIScreen.main.bounds.width - 150) / 2, height: (UIScreen.main.bounds.width - 150) / 2)
                                    
                                    Circle()
                                        .trim(from: 0, to: 7/15)
                                        .stroke(Color.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                                        .frame(width: (UIScreen.main.bounds.width - 150) / 2, height: (UIScreen.main.bounds.width - 150) / 2)
                                    
                                    Text("45 %")
                                        .font(.system(size: 22))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.blue)
                                        .rotationEffect(.init(degrees: 90))
                                }
                                .rotationEffect(.init(degrees: -90))
                                
                                Text("6.8 KM")
                                    .font(.system(size: 22))
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                            .padding()
                            .background(Color.mixerSecondaryBackground.opacity(0.5))
                            .cornerRadius(15)
//                            .shadow(color: Color.white.opacity(0.1), radius: 4, x: 0, y: 0)
                        }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .background(Color.black)
            .preferredColorScheme(.dark)
            .navigationBarTitle("MIT Theta Chi")
            .fullScreenCover(isPresented: $showEventInsightView) {
                EventInsightView()
                    .overlay(alignment: .topTrailing) {
                        XDismissButton()
                            .onTapGesture {
                                showEventInsightView.toggle()
                            }
                    }
            }
        }
    }
    var recentEventsSection: some View {
        CustomStackView {
            Text("Recent Events")
                .font(.title3.weight(.semibold))
        } contentView: {
            VStack(alignment: .trailing) {

                Spacer()
                
                VStack(alignment: .leading, spacing: 0) {
                        Text("Neon Party")
                            .font(.title).bold()
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 15)
                .padding(.bottom, 5)
                .padding(.top, 8)
                .background(
                    Rectangle()
                        .fill(.ultraThinMaterial.opacity(0.98))
                        .background(Color.mixerBackground.opacity(0.1))
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .padding(-1)
                        .blur(radius: 9)
                        .padding(.horizontal, -20)
                        .padding(.bottom, -10)
                        .padding(.top, 3)
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
            .frame(height: 250)
        }
    }
}

struct HostDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        HostDashboardView()
    }
}


struct RoundedShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        

        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 5, height: 5))
        
        return Path(path.cgPath)
    }
}
