//
//  HostProfileSettingsView.swift
//  mixer
//
//  Created by Jose Martinez on 1/20/23.
//

import SwiftUI
import MapKit

struct HostProfileSettingsView: View {
    var body: some View {
        List {
            imageSection
            
            nameSection
            
            aboutSection
            
            affiliationSection
            
            emailSection
            
            addressSection
        }
        .scrollContentBackground(.hidden)
        .background(Color.mixerBackground)
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .scrollIndicators(.hidden)
        .preferredColorScheme(.dark)
        .padding(.top, -25)
    }
    
    var imageSection: some View {
        VStack(alignment: .center) {
            Image("profile-banner-2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 85, height: 85)
                .clipShape(Circle())
                .padding(2)
                .background(Color.mainFont, in: Circle())
                .overlay {
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil")
                            .imageScale(.medium)
                            .foregroundColor(.white)
                            .padding(5)
                            .background(Color.mixerSecondaryBackground, in: Circle())
                            .background(Color.mainFont, in: Circle().stroke(lineWidth: 2))
                    }
                    .offset(x: 32, y: 32)
                }
            
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
        .frame(maxWidth: .infinity)
        .listRowBackground(Color.clear)
        .padding(.bottom, -5)
        
    }
    
    var nameSection: some View {
        Section(header: Text("Name")) {
            NavigationLink {
                HostSettingsChangeNameView()
            } label: {
                Text("MIT Theta Chi")
                    .font(.body)
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
                
            }
        }
        .listRowBackground(Color.mixerSecondaryBackground)
    }
    
    var aboutSection: some View {
        Section(header: Text("About").fontWeight(.semibold)) {
            HStack {
                Text("Username")
                    .font(.body)
                
                Spacer()
                
                Text("@mitthetachi")
                    .font(.body.weight(.medium))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
            }
            
            NavigationLink {
                HostSettingsChangeSocialsView()
            } label: {
                HStack {
                    Image("Instagram-Icon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                    
                    Text("Instagram")
                        .font(.body)
                    
                    Spacer()
                    
                    Text("@mitthetachi")
                        .font(.body.weight(.medium))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                }
            }
            
            NavigationLink {
                HostSettingsChangeSocialsView()
            } label: {
                HStack {
                    Image(systemName: "globe")
                    
                    Text("Website")
                        .font(.body)
                    
                    Spacer()
                    
                    Text(verbatim: "http://ox.mit.edu/main/")
                        .font(.body.weight(.medium))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                }
            }
            
            NavigationLink {
                HostSettingsDescriptionView()
            } label: {
                HStack {
                    Text("Edit Organization Description")
                        .font(.body)
                }
            }
        }
        .listRowBackground(Color.mixerSecondaryBackground)
    }
    
    var affiliationSection: some View {
        Section(header: Text("Affiliation").fontWeight(.semibold)) {
            Text("Massachusetts Institute of Technology")
                .font(.body)
                .lineLimit(1)
                .minimumScaleFactor(0.2)
        }
        .listRowBackground(Color.mixerSecondaryBackground)
    }
    
    var emailSection: some View {
        Section(header: Text("Email"), footer: Text("This information is not public")) {
            NavigationLink {
                HostSettingsChangeEmailView()
            } label: {
                Text(verbatim: "ThetaChi@mit.edu")
                    .font(.body)
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
                
            }
            .listRowBackground(Color.mixerSecondaryBackground)
            
        }
    }
    
    var addressSection: some View {
        Section(header: Text("Address"), footer: Text("")) {
            NavigationLink {
                HostSettingsChangeAddressView()
            } label: {
                HStack(spacing: 0) {
                    Text("528 Beacon St\nBoston, MA 02215")
                        .font(.body)
                        .lineLimit(2)
                        .minimumScaleFactor(0.2)
                }
            }
            .listRowBackground(Color.mixerSecondaryBackground)
        }
    }
}


struct HostProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        HostProfileSettingsView()
    }
}
