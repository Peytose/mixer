//
//  NavigationBar.swift
//  mixer
//
//  Created by Jose Martinez on 12/18/22.
//

import SwiftUI

struct NavigationBar: View {
    @EnvironmentObject var model: Model
    var title = "Explore"
    var onSocialPage: Bool = true
    @Binding var contentHasScrolled: Bool
    @Binding var showNavigationBar: Bool
    var showLocation = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .background(.ultraThinMaterial)
                .ignoresSafeArea()
                .frame(maxHeight: .infinity, alignment: .top)
                .blur(radius: contentHasScrolled ? 10 : 0)
                .padding(-20)
                .opacity(contentHasScrolled ? 1 : 0)
            
            HStack(alignment: .center, spacing: 0) {
                Text(title)
                    .animatableFont(size: contentHasScrolled ? 22 : 34, weight: .bold)
                    .foregroundStyle(.primary)
                    .padding(.leading, 20)
                    .padding(.top, 20)
                    .opacity(contentHasScrolled ? 0.7 : 1)
                
                Spacer()
                
                if showLocation {
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .imageScale(.medium)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.primary, Color.mixerIndigo)
                            .padding(.top, 26)
                            .opacity(contentHasScrolled ? 0.7 : 1)
                        Text("Boston, MA")
                            .animatableFont(size: contentHasScrolled ? 22 : 30, weight: .bold)
                            .foregroundStyle(.primary)
                            .padding(.trailing, 20)
                            .padding(.top, 24)
                            .opacity(contentHasScrolled ? 0.7 : 1)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .offset(y: showNavigationBar ? 0 : -120)
        .offset(y: contentHasScrolled ? -16 : 0)
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(contentHasScrolled: .constant(false), showNavigationBar: .constant(true))
            .environmentObject(Model())
            .preferredColorScheme(.dark)
    }
}
