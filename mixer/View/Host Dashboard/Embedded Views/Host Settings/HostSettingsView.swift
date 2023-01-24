//
//  HostSettingsView.swift
//  mixer
//
//  Created by Jose Martinez on 1/20/23.
//

import SwiftUI

struct HostSettingsView: View {
    @State var showAddMemberView = false
    
    var results: [MockUser] {
        return users
    }
    
    var body: some View {
        NavigationView {
            List {
                section
                
                membersHeaderSection
                
                preferencesSection
            }
            .scrollContentBackground(.hidden)
            .background(Color.mixerBackground)
            .navigationTitle("Host Settings")
            .scrollIndicators(.hidden)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem() {
                    Button(action: {
                        showAddMemberView.toggle()
                    }, label: {
                        Text("Add Member")
                            .foregroundColor(.blue)
                    })
                }
            }
            .sheet(isPresented: $showAddMemberView) {
                AddMemberView()
                    .presentationDetents([.medium])
                    .background(Color.red)
            }
        }
        .tint(Color.mainFont)
    }
    
    var section: some View {
        Section {
            NavigationLink {
                HostProfileSettingsView()
            } label: {
                HStack(alignment: .top, spacing: 15) {
                    Image("profile-banner-2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text("MIT Theta Chi")
                            .font(.title2.weight(.medium))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                        
                        Text("@mitthetachi")
                            .font(.body.weight(.medium))
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                }
            }
        }
        .listRowBackground(Color.mixerSecondaryBackground)
    }
    
    var membersHeaderSection: some View {
        VStack {
            HStack(spacing: -35) {
                Circle()
                    .stroke()
                    .foregroundColor(.mixerSecondaryBackground)
                    .frame(width: 80, height: 60)
                    .overlay {
                        Image("mock-user-3")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                    }
                
                Circle()
                    .stroke()
                    .foregroundColor(.mixerSecondaryBackground)
                    .frame(width: 80, height: 60)
                    .overlay {
                        Image("mock-user-4")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                    }
                
                Circle()
                    .stroke()
                    .foregroundColor(.mixerSecondaryBackground)
                    .frame(width: 80, height: 60)
                    .overlay {
                        Image("mock-user-1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                    }
                
                Circle()
                    .stroke()
                    .foregroundColor(.mixerSecondaryBackground)
                    .frame(width: 80, height: 60)
                    .overlay {
                        Image("mock-user-5")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                    }
                
                Circle()
                    .fill(Color.SlightlyDarkerBlueBackground)
                    .frame(width: 80, height: 60)
                    .overlay {
                        Text("+29")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
            }
            .frame(maxWidth: .infinity)
            
            Text("MIT Theta Chi")
                .font(.title.bold())
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .listRowBackground(Color.clear)
        .padding(.vertical, -6)
    }
    
    var preferencesSection: some View {
        Section(header: Text("Members").fontWeight(.semibold)) {
            ForEach(Array(results.enumerated().prefix(9)), id: \.offset) { index, user in
                NavigationLink(destination: UserProfileView(viewModel: ExplorePageViewModel(), user: user)) {
                    HStack(spacing: 10) {
                        Image(user.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width: 40, height: 40)
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Text(user.name)
                                    .font(.body)
                                    .lineLimit(1)
                                
                                    .foregroundColor(.white)
                                Text(user.school)
                                    .font(.body)
                                    .foregroundColor(.secondary)
                            }
                            
                            Text("Brother")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                        }
                    }
                    .padding(.vertical, -1)
                    .swipeActions {
                        Button(role: .destructive) {
                            
                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(Color.red)

                    }
                }
            }
        }
        .listRowBackground(Color.mixerSecondaryBackground)
    }
}


struct HostSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        HostSettingsView()
    }
}
