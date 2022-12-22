//
//  MainTabView.swift
//  mixer
//
//  Created by Peyton Lyons on 11/12/22.
//

import SwiftUI

struct MainTabView: View {
//    let user: User
    
    var body: some View {
        TabView {
            ExplorePageView()
                .tabItem { TabViewItem(type: .social) }

            
            MapView()
                .tabItem { TabViewItem(type: .map) }

            
            
            SearchPageView()
                .tabItem { TabViewItem(type: .search) }

//            ProfileView(user: user)
//                .tabItem { TabViewItem(type: .profile) }
            
            UserProfilePrototypeView()
                .tabItem { TabViewItem(type: .profile) }

        }
        .preferredColorScheme(.dark)
        .accentColor(Color.mainFont)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
//        MainTabView(user: Mockdata.user)
        MainTabView()
            .environmentObject(Model())
    }
}

struct TabViewItem: View {
    
    enum TabViewItemType: String {
        case social  = "Social"
        case map   = "Map"
        case search = "Search"
        case profile = "Profile"

        var image: Image {
            switch self {
            case .social:  return Image(systemName: "person.3.fill")
            case .map:  return Image(systemName: "map.fill")
            case .search:  return Image(systemName: "magnifyingglass")
            case .profile:  return Image(systemName: "person.fill")
            }
        }

        var text: Text {
            Text(self.rawValue)
        }
    }
    
    var type: TabViewItemType

    var body: some View {
        VStack {
            type.image
                .renderingMode(.template)
                .foregroundColor(.white)
            type.text

        }
    }
}
