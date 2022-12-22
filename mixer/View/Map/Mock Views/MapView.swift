//
//  MapView.swift
//  mixer
//
//  Created by Peyton Lyons on 11/12/22.
//

import SwiftUI
import UIKit
import MapKit
import CoreLocationUI

struct MapView: View {
    @StateObject private var viewModel = LocationMapViewModel()
    @Namespace var namespace
    
    var body: some View {
        ZStack(alignment: .top) {
            MapClusterView()
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                AddEventButton()
                    .onTapGesture {
                        viewModel.isShowingAddEventView.toggle()
                    }
                
                EventUsersListButton()
            }
            .frame(maxWidth:.infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(EdgeInsets(top: 60, leading: 0, bottom: 0, trailing: 6))
            
            BlurredStatusBar()
            
            UserQRCodeButton()
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, 30)
                .onTapGesture {
                    withAnimation() {
                        viewModel.isShowingQRCodeView.toggle()
                    }
                }
            
        }
        .overlay(alignment: .bottomTrailing, content: {
            LocationButton(.currentLocation) {
                withAnimation() {
                }
            }
            .foregroundColor(.white)
            .symbolVariant(.fill)
            .tint(.mixerIndigo)
            .labelStyle(.iconOnly)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 20))
        })
        //        .sheet(isPresented: $viewModel.isShowingQRCodeView, content: { QRCodeView(viewModel: QRCodeViewModel(user: UserProfile(record: viewModel.existingProfileRecord!), hostManager: hostManager, eventManager: eventManager, isHost: viewModel.isHost)) })
        //        .sheet(isPresented: $viewModel.isShowingHostView, content: { HostOrganizationView(viewModel: HostOrganizationViewModel(host: hostManager.selectedHost!, namespace: namespace)) })
                .fullScreenCover(isPresented: $viewModel.isShowingAddEventView, content: { CreateEventView() })
        //        .sheet(isPresented: $viewModel.isShowingEventUsersListView, content: { EventListHostView(viewModel: EventListHostViewModel(host: viewModel.hostOrganization!)) })
    }
}


struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .preferredColorScheme(.dark)
    }
}


fileprivate struct AddEventButton: View {
    var body: some View {
        Image(systemName: "plus.app")
            .font(.system(size: 20, weight: .bold))
            .frame(width: 40, height: 40)
            .foregroundColor(.secondary)
            .background(.ultraThinMaterial)
            .backgroundStyle(cornerRadius: 14, opacity: 0.4)
    }
}


fileprivate struct EventUsersListButton: View {
    var body: some View {
        Image(systemName: "list.bullet.clipboard")
            .font(.system(size: 20, weight: .bold))
            .frame(width: 40, height: 40)
            .foregroundColor(.secondary)
            .background(.ultraThinMaterial)
            .backgroundStyle(cornerRadius: 14, opacity: 0.4)
    }
}


fileprivate struct UserQRCodeButton: View {
    var body: some View {
        
        Rectangle()
            .fill(Color.mixerPurpleGradient)
            .cornerRadius(30)
            .frame(width: 150, height: 50)
            .shadow(radius: 5, y: 10)
            .overlay(content: {
                HStack(spacing: 15) {
                    Image(systemName: "qrcode")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 26, height: 26)
                        .foregroundColor(Color.white)
                }
            })
    }
}


fileprivate struct BlurredStatusBar: View {
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.clear)
                .frame(maxWidth: .infinity, maxHeight: 50, alignment: .top)
                .backgroundBlur(radius: 5, opaque: true)
                .ignoresSafeArea()
            
            Spacer()
        }
    }
}
