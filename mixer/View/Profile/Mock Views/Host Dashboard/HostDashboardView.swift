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
    @StateObject private var eventManager = EventManager()

    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    var eventList: [MockEvent] {
        return events
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    quickStatsSection
                    
                    FollowerGraphView(sampleAnalytics: followers, title: "Followers", itemTitle: "Followers")
                    
                    recentEventsSection

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
                .padding(.horizontal, 5)
            }
            .background(Color.mixerBackground)
            .preferredColorScheme(.dark)
            .navigationBarTitle("MIT Theta Chi")
            .fullScreenCover(isPresented: $showEventInsightView) {
                EventInsightView(event: eventManager.selectedEvent!)
                    .overlay(alignment: .topTrailing) {
                        XDismissButton()
                            .onTapGesture {
                                showEventInsightView.toggle()
                            }
                            .padding(.trailing)
                    }
            }
        }
    }
    var recentEventsSection: some View {
        CustomStackView {
            Text("Recent Events")
                .font(.title3.weight(.semibold))
        } contentView: {
            ScrollView {
                ForEach(Array(eventList.enumerated().prefix(7)), id: \.offset) { index, event in
                        EventRow(flyer: event.flyer, title: event.title, date: event.date, attendance: event.attendance)
                        .onTapGesture {
                            showEventInsightView.toggle()
                            eventManager.selectedEvent = event
                        }
                }
            }
            .frame(height: 200)
            .padding(.top, -10)
        }
    }
    
    var quickStatsSection: some View {
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
            
            VStack {
                Text("32")
                    .font(.largeTitle.weight(.medium))
                
                Text("Members")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
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
