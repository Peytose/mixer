//
//  HostSettingsDescriptionView.swift
//  mixer
//
//  Created by Jose Martinez on 1/22/23.
//

import SwiftUI

struct HostSettingsDescriptionView: View {
    @State var name = ""
    var body: some View {
        List {
            oneLineDescription
            
            description
        }
        .scrollContentBackground(.hidden)
        .background(Color.mixerBackground)
        .navigationTitle("Edit Description")
        .navigationBarTitleDisplayMode(.inline)
        .scrollIndicators(.hidden)
        .preferredColorScheme(.dark)
        .toolbar {
            ToolbarItem() {
                Button(action: {}, label: {
                    Text("Done")
                        .foregroundColor(.blue)
                })
            }
        }
    }
    
    var oneLineDescription: some View {
        Section(header: Text("One Line Description"), footer: Text("Keep it short, e.g. Tallest Frat at MIT!")) {
                TextField("", text: $name)
                    .placeholder(when: name.isEmpty) {
                        Text("Your number one spot for college parties!")
                            .foregroundColor(.white)
                    }
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .listRowBackground(Color.mixerSecondaryBackground)
        }
    }
    
    var description: some View {
        Section(header: Text("One Line Description"), footer: Text("Describe your organization")) {
                TextField("", text: $name)
                    .placeholder(when: name.isEmpty) {
                        Text("Established in 1902, Theta Chi Beta Chapter is the oldest active Theta Chi chapter in the country, and is one of the first fraternities founded at MIT. We have a storied history of developing leaders: our alumni go on to start companies, build self-driving cars, cure diseases, get involved in politics, serve in the military, and change the world. The brothers of Theta Chi are dedicated to helping each other achieve their goals and give back to the community.")
                            .foregroundColor(.white)
                    }
                    .listRowBackground(Color.mixerSecondaryBackground)
        }
    }
}

struct HostSettingsDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        HostSettingsDescriptionView()
    }
}
