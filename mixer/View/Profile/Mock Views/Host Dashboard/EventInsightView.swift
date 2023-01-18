//
//  EventInsightView.swift
//  mixer
//
//  Created by Jose Martinez on 1/16/23.
//

import SwiftUI
//
//  HostDashboardView.swift
//  mixer
//
//  Created by Jose Martinez on 1/14/23.
//

import SwiftUI

struct EventInsightView: View {
    @Namespace var namespace
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    Text("After Action Report")
                        .font(.title.bold())
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 4)
                    
                    HStack(spacing: 30) {
                        VStack {
                            Text("$0")
                                .font(.largeTitle.weight(.medium))
                            
                            Text("Total Revenue")
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                        
                        VStack {
                            Text("389")
                                .font(.largeTitle.weight(.medium))
                            
                            Text("Guests")
                                .font(.headline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.top)
                    
                    FollowerGraphView(title: "Guests", itemTitle: "Guests", showSegmentedControl: true, showlinebartoggle: true)
                    
                    distributionCharts
                    
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
            .background(Color.mixerBackground)
            .preferredColorScheme(.dark)
            .navigationBarTitle("Neon Party")
        }
    }
    
    var distributionCharts: some View {
        VStack(spacing: 20) {
            CustomStackView {
                Text("Universities")
                    .font(.title2.weight(.semibold))
            } contentView: {
                PieChartView(values: [128, 95, 49, 31, 19, 67], names: ["BU", "NEU", "Wellesely", "MIT", "Harvard", "Other"], formatter: {value in String(format: "%.f", value)}, colors: [Color.green, Color.red, Color.blue, Color.red.opacity(0.7), Color.harvardCrimson, Color.gray], title: "Total Guests", showChartRowText: true, chartRowText: "from")
                    .frame(height: 580)
            }
            
            CustomStackView {
                Text("Gender Distribution")
                    .font(.title2.weight(.semibold))
            } contentView: {
                PieChartView(values: [242, 128, 19], names: ["Female", "Male", "Other"], formatter: { value in String(format: "%.f", value)}, colors: [Color.girlPink, Color.blue, Color.gray], title: "Total Guests", showChartRowText: true, chartRowText: "were")
                    .frame(height: 420)
            }
            
            CustomStackView {
                Text("Single vs Taken")
                    .font(.title2.weight(.semibold))
            } contentView: {
                PieChartView(values: [318, 28, 45], names: ["Single", "Taken", "Complicated"], formatter: {value in String(format: "%.f", value)}, colors: [Color.green, Color.red, Color.yellow], title: "Total Guests", showChartRowText: true, chartRowText: "were")
                    .frame(height: 420)
            }
        }
    }
}

struct EventInsightView_Previews: PreviewProvider {
    static var previews: some View {
        EventInsightView()
    }
}
