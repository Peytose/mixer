//
//  HostDashboardView.swift
//  mixer
//
//  Created by Jose Martinez on 1/14/23.
//

import SwiftUI

struct HostDashboardView: View {
    @Namespace var namespace
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center) {
                    VStack {
                        Text("$142,910.88")
                            .font(.largeTitle.weight(.medium))
                        
                        Text("Total Revenue")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    
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
                    
                    CustomStackView {
                        Text("penis")
                    } contentView: {
                        FollowerGraphView()
                            .padding(-30)
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
                            .background(Color.white.opacity(0.06))
                            .cornerRadius(15)
                            .shadow(color: Color.white.opacity(0.2), radius: 10, x: 0, y: 0)
                        }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .background(Color.black)
            .preferredColorScheme(.dark)
            .navigationBarTitle("MIT Theta Chi")
        }
    }
    
    func getPercent(current : CGFloat,Goal : CGFloat)->String{
        
        let per = (current / Goal) * 100
        
        return String(format: "%.1f", per)
    }
    
    // calculating Type...

    func getType(val: String)->String{
        
        switch val {
        case "Water": return "L"
        case "Sleep": return "Hrs"
        case "Running": return "Km"
        case "Cycling": return "Km"
        case "Steps": return "stp"
        default: return "Kcal"
        }
    }
    
    // converting Number to decimal...
    
    func getDec(val: CGFloat)->String{
        
        let format = NumberFormatter()
        format.numberStyle = .decimal
        
        return format.string(from: NSNumber.init(value: Float(val)))!
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

struct RoundedShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        

        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 5, height: 5))
        
        return Path(path.cgPath)
    }
}

struct Stats : Identifiable {
    
    var id : Int
    var title : String
    var currentData : CGFloat
    var goal : CGFloat
    var color : Color
}

var stats_Data = [

    Stats(id: 0, title: "Running", currentData: 6.8, goal: 15, color: Color("running")),
    
    Stats(id: 1, title: "Water", currentData: 3.5, goal: 5, color: Color("water")),
    
    Stats(id: 2, title: "Energy Burn", currentData: 585, goal: 1000, color: Color("energy")),
    
    Stats(id: 3, title: "Sleep", currentData: 6.2, goal: 10, color: Color("sleep")),
    
    Stats(id: 4, title: "Cycling", currentData: 12.5, goal: 25, color: Color("cycle")),
    
    Stats(id: 5, title: "Steps", currentData: 16889, goal: 20000, color: Color("steps")),
]
