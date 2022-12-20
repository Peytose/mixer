//
//  SearchPageView.swift
//  mixer
//
//  Created by Jose Martinez on 12/20/22.
//

import SwiftUI

struct SearchPageView: View {
    @State var text = ""
    @State var selectedUser = users[0]
    @Namespace var namespace
    @EnvironmentObject var model: Model
//    @EnvironmentObject private var hostManager: HostManager
    
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    Color.lifXBackground
                        .ignoresSafeArea()
                        
                    Image("Blob 1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 300, alignment: .top)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                        .opacity(0.8)
                        .offset(x: -40, y: -355)
                        .ignoresSafeArea()
                        .zIndex(0)
                    
                    content
                        .padding(.top, 10)
                }
                .navigationTitle("Search Users")
                .navigationBarTitleDisplayMode(.automatic)
                .searchable(text: $text, prompt: "Search Mixer") {
                    ForEach(suggestions) { suggestion in
                        Button {
                            text = suggestion.text
                        } label: {
                            Text(suggestion.text)
                        }
                        .searchCompletion(suggestion.text)
                    }
                }
            .preferredColorScheme(.dark)
            }
            .background(Color.lifXBackground)
        }
        .accentColor(.white)
        
    }
}

struct SearchPageView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPageView()
            .environmentObject(Model())
//            .environmentObject(HostManager())
    }
}

extension SearchPageView {
    var content: some View {
        VStack(alignment: .leading, spacing: 20) {
            
                    ForEach(Array(results.enumerated()), id: \.offset) { index, user in
                        if index != 0 { Divider() }
                        NavigationLink(destination: UserProfileView(user: user)) {
                            HStack(spacing: 22) {
                                Image(user.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(Circle())
                                    .frame(width: 45, height: 45)
                                
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(user.name)
                                            .font(.system(size: 18, weight: .semibold, design: .default))
                                        Text(user.school)
                                            .font(.system(size: 18, weight: .semibold, design: .default))
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Text("@\(user.username)")
                                    .font(.system(size: 16, weight: .semibold, design: .default))
                                    .foregroundColor(.secondary.opacity(0.7))
                                }
                                
                                Spacer()
                            }
                            .padding(.vertical, -8)
                        }
                    }
                    if results.isEmpty {
                        Text("No results found")
                    }
            
                Rectangle()
                    .fill(.clear)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)

        }
        .padding(.leading)
    }
    
//    var results: [Host] {
//
//        if text.isEmpty {
//            return Hosts
//        } else {
//            return Hosts.filter { $0.title.contains(text) }
//        }
//
//    }
    
    var results: [MockUser] {
        
        if text.isEmpty {
            return users
        } else {
            return users.filter { $0.name.localizedCaseInsensitiveContains(text) }
        }
        
    }
    
    var suggestions: [Suggestion2] {
        
        if text.isEmpty {
            return suggestionsData2
        } else {
            return suggestionsData2.filter { $0.text.localizedCaseInsensitiveContains(text) }
        }
        
    }
}

struct Suggestion2: Identifiable {
    let id = UUID()
    var text: String
}

var suggestionsData2 = [
    Suggestion2(text: ""),

]


