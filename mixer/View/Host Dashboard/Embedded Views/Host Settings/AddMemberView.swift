//
//  AddMemberView.swift
//  mixer
//
//  Created by Jose Martinez on 1/22/23.
//

import SwiftUI

struct AddMemberView: View {
    @State var text = ""
    @State var selectedUser = users[0]
    @State var showAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                
                List {
                    content
                }
                .preferredColorScheme(.dark)
                .listStyle(.plain)
                .searchable(text: $text, prompt: "Search Users") {
                    ForEach(suggestions) { suggestion in
                        Text(suggestion.text)
                            .searchCompletion(suggestion.text)
                    }
                }
            }
            .navigationBarTitle("Add Member")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Add user to organization?", isPresented: $showAlert, actions: {
                // 1
                Button("Cancel", role: .cancel, action: {})
                
                Button("Add Member", action: {})
            }, message: {
                Text("Choose add member to add this user to your organization")
            })
        }
    }
    
    var content: some View {
        ForEach(Array(results.enumerated()), id: \.offset) { index, user in
            HStack(spacing: 15) {
                Image(user.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    HStack(spacing: 2) {
                        Text(user.name)
                            .font(.callout.weight(.semibold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Image(systemName: "graduationcap.fill")
                            .imageScale(.small)
                            .foregroundColor(.secondary)
                        
                        Text("\(user.school)")
                            .font(.subheadline.weight(.medium))
                            .foregroundColor(.secondary)
                    }
                    
                    HStack {
                        Text("@\(user.username)")
                            .font(.subheadline)
                            .foregroundColor(.secondary.opacity(0.7))
                        
                        Spacer()
                        
                        Text("Friend")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .listRowSeparator(.hidden)
            .onTapGesture {
                showAlert.toggle()
            }
        }
    }
    
    var results: [MockUser] {
        if text.isEmpty {
            return []
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

struct AddMemberView_Previews: PreviewProvider {
    static var previews: some View {
        AddMemberView()
    }
}
