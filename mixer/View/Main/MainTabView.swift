//
//  MainTabView.swift
//  mixer
//
//  Created by Peyton Lyons on 11/12/22.
//

import SwiftUI

struct MainTabView: View {
    let user: User
    
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            
            MapView()
                .tabItem {
                    Image(systemName: "map")
                }
            
            ExploreView()
                .tabItem {
                    Image(systemName: "balloon.2")
                }
            
            ProfileView(user: user)
                .tabItem {
                    Image(systemName: "person")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView(user: Mockdata.user)
    }
}
