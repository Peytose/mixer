//
//  NavigationBar.swift
//  mixer
//
//  Created by Jose Martinez on 12/18/22.
//

import SwiftUI

struct NavigationBar: View {
    @EnvironmentObject var model: Model
    var title = ""
    @Binding var showSearchView: Bool
    var onSocialPage: Bool = true
    @Binding var contentHasScrolled: Bool
    @Binding var showNavigationBar: Bool
    
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

            
            Text(title)
                .animatableFont(size: contentHasScrolled ? 22 : 34, weight: .bold)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .opacity(contentHasScrolled ? 0.7 : 1)
        }
        .offset(y: showNavigationBar ? 0 : -120)
        .offset(y: contentHasScrolled ? -16 : 0)
        .sheet(isPresented: $showSearchView) {
            SearchView()
        }
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(showSearchView: .constant(false), contentHasScrolled: .constant(false), showNavigationBar: .constant(true))
            .environmentObject(Model())
            .preferredColorScheme(.dark)
    }
}
