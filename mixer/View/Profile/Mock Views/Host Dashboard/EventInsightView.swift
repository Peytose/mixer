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
            ScrollView {
                VStack(spacing: 20) {
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
                    
                    FollowerGraphView(title: "Followers", showSegmentedControl: true, showlinebartoggle: true)
                    
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
            .background(Color.black)
            .preferredColorScheme(.dark)
            .navigationBarTitle("Neon Party AAR")
        }
    }
    
    var distributionCharts: some View {
        VStack(spacing: 20) {
            CustomStackView {
                Text("School Distribution")
                    .font(.title3.weight(.semibold))
            } contentView: {
                PieChartView(values: [200, 100, 50], names: ["BU", "Harvard", "Other"], formatter: {value in String(format: "%.f", value)},
                             colors: [Color.red, Color.harvardCrimson, Color.orange])
                .frame(height: 410)
            }
            
            CustomStackView {
                Text("Gender Distribution")
                    .font(.title3.weight(.semibold))
            } contentView: {
                PieChartView(values: [222, 113, 15], names: ["Female", "Male", "Other"], formatter: {value in String(format: "%.f", value)},
                             colors: [Color.girlPink, Color.blue, Color.gray])
                .frame(height: 410)
            }
            
            CustomStackView {
                Text("Single vs Taken Distribution")
                    .font(.title3.weight(.semibold))
            } contentView: {
                PieChartView(values: [298, 22, 30], names: ["Single", "Taken", "Complicated"], formatter: {value in String(format: "%.f", value)},
                             colors: [Color.green, Color.red, Color.yellow])
                .frame(height: 410)
            }
        }
    }
}

struct EventInsightView_Previews: PreviewProvider {
    static var previews: some View {
        EventInsightView()
    }
}
