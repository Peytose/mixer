//
//  HostDashboardView.swift
//  mixer
//
//  Created by Jose Martinez on 1/14/23.
//

import SwiftUI

struct HostDashboardView: View {
    var body: some View {
        VStack {
            CustomStackView {
                Label {
                    Text("Dog")
                } icon: {
                    Image(systemName: "person")
                }
            } contentView: {
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 15) {
                        
                        ForecastView(time: "12 PM",celcius: 94,image: "sun.min")
                        
                        ForecastView(time: "1 PM",celcius: 95,image: "sun.min")
                        
                        ForecastView(time: "2 PM",celcius: 96,image: "sun.min")
                        
                        ForecastView(time: "3 PM",celcius: 97,image: "cloud.sun")
                        
                        ForecastView(time: "4 PM",celcius: 99,image: "sun.haze")
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct HostDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        HostDashboardView()
    }
}


struct ForecastView: View {
    var time: String
    var celcius: CGFloat
    var image: String
    
    var body: some View {
        VStack(spacing: 15){
            
            Text(time)
                .font(.callout.bold())
                .foregroundStyle(.white)
            
            Image(systemName: image)
                .font(.title2)
            // MultiColor...
                .symbolVariant(.fill)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.yellow, .white)
            // max Frame...
                .frame(height: 30)
            
            Text("\(Int(celcius))˚")
                .font(.callout.bold())
                .foregroundStyle(.white)
        }
        .padding(.horizontal,10)
    }
}
