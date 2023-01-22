//
//  EventExtraSettingsView.swift
//  mixer
//
//  Created by Jose Martinez on 12/22/22.
//


import SwiftUI

struct EventExtraSettingsView: View {
    
    @StateObject var viewModel = CreateEventViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedColor = "Invite Only"
    
    var body: some View {
        ZStack {
            Color.mixerBackground
                .ignoresSafeArea()
            
            VStack {
                List {
                    
                    inviteLimitSection
                    
                    includeNoteSection
                    
                    eventAttendanceSection
                }
                .tint(.mixerIndigo)
                .preferredColorScheme(.dark)
                .scrollContentBackground(.hidden)
            }
        }
        .overlay(alignment: .bottom, content: {
            NavigationLink(destination: ReviewCreatedEventView()) {
                NextButton()
            }
        })
        .navigationBarTitle(Text("Extra Settings"), displayMode: .large)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    BackArrowButton()
                })
            }
        }
    }
    

    
    var inviteLimitSection: some View {
        Section {
            Toggle("Include attire description?", isOn: $viewModel.hasAttireDescription.animation())
                .font(.body)
            
            if viewModel.hasAttireDescription == true {
                TextField("Halloween costume required*", text: $viewModel.attireDescription)
                    .foregroundColor(Color.mainFont)
            }
        } header: {
            Text("Attire Description")
        }
        .listRowBackground(Color.mixerSecondaryBackground)
    }
    
    var includeNoteSection: some View {
        Section {
            Toggle("Include note for guests?", isOn: $viewModel.hasNote.animation())
                .font(.body)
            
            if viewModel.hasNote == true {
                TextField("Bring your own beer 🍺 or no entry", text: $viewModel.note)
                    .foregroundColor(Color.mainFont)
            }
        } header: {
            Text("Attire Description")
        }
        .listRowBackground(Color.mixerSecondaryBackground)
    }
    
    var eventAttendanceSection: some View {
        Section {
            Toggle("Event Attendance Public?", isOn: $viewModel.showAttendanceCount.animation())
                .font(.body)
                .listRowBackground(Color.mixerSecondaryBackground)

        } header: {
            Text("Attire Description")
        } footer: {
            Text("This allows mixer to make your event's attendance count public information")

        }
    }
}


struct EventFlyerUploadView_Previews: PreviewProvider {
    static var previews: some View {
        EventExtraSettingsView()
    }
}

