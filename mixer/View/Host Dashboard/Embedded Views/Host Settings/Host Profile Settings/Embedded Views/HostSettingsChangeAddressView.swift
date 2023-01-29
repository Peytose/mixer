//
//  HostSettingsChangeAddressView.swift
//  mixer
//
//  Created by Jose Martinez on 1/20/23.
//

import SwiftUI
import MapKit
import MapItemPicker

struct HostSettingsChangeAddressView: View {
    @State var address = ""
    @State var showingPicker = false
    @State var isPublic = false
    
    let coordinates = CLLocationCoordinate2D(latitude: 42.3507046, longitude: -71.0909822)
    
    var body: some View {
        List {
            nameSection
            mapPreview
        }
        .scrollContentBackground(.hidden)
        .background(Color.mixerBackground)
        .navigationTitle("Edit Address")
        .navigationBarTitleDisplayMode(.inline)
        .scrollIndicators(.hidden)
        .preferredColorScheme(.dark)
        .toolbar {
            ToolbarItem() {
                Button(action: {
                    showingPicker.toggle()
                }, label: {
                    Text("Edit")
                        .foregroundColor(.blue)
                })
            }
        }
        .mapItemPicker(isPresented: $showingPicker) { item in
            if let name = item?.name {
                print("Selected \(name)")
            }
        }
    }
    
    var nameSection: some View {
        Section(header: Text("Address"), footer: Text("Choosing public allows mixer to display your organization's location on the map and on your profile")) {
            Text("528 Beacon St\nBoston, MA 02215")
                .lineLimit(2)
                .minimumScaleFactor(0.2)
                .listRowBackground(Color.mixerSecondaryBackground)
            
            Toggle(isPublic ? "Public" : "Private", isOn: $isPublic.animation())
                .font(.body.weight(.medium))
                .foregroundColor(isPublic ? .white : .secondary)
                .listRowBackground(Color.mixerSecondaryBackground)
        }
    }
    
    var mapPreview: some View {
        Section {
            MapSnapshotView(location: coordinates, width: 350, height: 300)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .listRowBackground(Color.clear )
        }
    }
}

struct HostSettingsChangeAddressView_Previews: PreviewProvider {
    static var previews: some View {
        HostSettingsChangeAddressView()
    }
}
