//
//  MapView.swift
//  mixer
//
//  Created by Peyton Lyons on 11/12/22.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        ZStack {
            Color.lifXBackground
                .ignoresSafeArea()
            
            Text("Map View")
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
