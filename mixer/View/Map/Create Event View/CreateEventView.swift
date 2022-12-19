//
//  CreateEventView.swift
//  mixer
//
//  Created by Jose Martinez on 12/18/22.
//

import SwiftUI

struct CreateEventView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = CreateEventViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.lifXBackground
                    .ignoresSafeArea()
                
                List {
                    mainDetailsSection
                    
                    visibilitySection
                    
                    if viewModel.isInviteOnly == InviteOnly.yes {
                        inviteLimitSection
                        
                        guestInviteLimitSection
                    }
                    
                    flyerSection
                }
                .tint(.mixerIndigo)
                .preferredColorScheme(.dark)
                .scrollContentBackground(.hidden)
                
//                if viewModel.isLoading { LoadingView() }
            }
            .overlay(alignment: .bottom, content: {
                Button {
                    let impact = UIImpactFeedbackGenerator(style: .light)
                    impact.impactOccurred()
//                    viewModel.createEvent()
                    
                } label: { CreateEventButton() }
            })
            .navigationBarTitle(Text("Create an Event"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.secondary)
                    .padding(7)
                    .background(.ultraThinMaterial, in: Circle())
                    .backgroundStyle(cornerRadius: 18)
            }))
//            .sheet(isPresented: $viewModel.isShowingPhotoPicker) { PhotoPicker(image: $viewModel.flyer) }
            .alert(item: $viewModel.alertItem, content: { $0.alert })
        }
    }
    
    var mainDetailsSection: some View {
        Section(header: Text("Main Details")) {
            TextField("Event name*", text: $viewModel.title)
                .foregroundColor(Color.mainFont)
            
            TextField("Event theme/description*", text: $viewModel.description)
                .foregroundColor(Color.mainFont)
            
            EventDatePicker(text: "Start date*", selection: $viewModel.startDate)
            
            EventDatePicker(text: "End date*", selection: $viewModel.endDate)
            
            Picker("Wet or Dry", selection: $viewModel.selectedWetDry) {
                Text("Dry").tag(WetOrDry.dry)
                Text("Wet").tag(WetOrDry.wet)
            }
            .pickerStyle(.segmented)
            .padding()
        }
        .listRowBackground(Color.lifXLightGray)
    }
    
    var visibilitySection: some View {
        Section(header: Text("Visibility")) {
            
            Picker("Invite only", selection: self.$viewModel.isInviteOnly.animation()) {
                Text("Public").tag(InviteOnly.no)
                Text("Invite Only").tag(InviteOnly.yes)
            }
            .pickerStyle(.segmented)
            .padding()
            
            //MARK: Archive: Event theme input field
        }
        .listRowBackground(Color.lifXLightGray)
    }
    
    var inviteLimitSection: some View {
        Section {
            Toggle("Invite Limit?", isOn: $viewModel.isInviteLimit.animation())
            
            if viewModel.isInviteLimit == true {
                TextField("Maximum Guest Invites*", text: $viewModel.guestLimit)
                    .foregroundColor(Color.mainFont)
                    .keyboardType(.numberPad)
            }
        } header: {
            Text("Invites per brother")
        }
        .listRowBackground(Color.lifXLightGray)
    }
    
    var guestInviteLimitSection: some View {
        Section {
            Toggle("Guest Invites?", isOn: $viewModel.isGuestInviteLimit.animation())

            if viewModel.isGuestInviteLimit {
                TextField("Maximum Invites per Guest*", text: $viewModel.guestLimitForGuests)
                    .foregroundColor(Color.mainFont)
                    .keyboardType(.numberPad)
            }
        } header: {
            Text("Allow guests to invite guests")
        }
        .listRowBackground(Color.lifXLightGray)
    }
    
    var flyerSection: some View {
        Section(header: Text("Flyer")) {
            HStack {
                Image("kingfisher-2.jpg")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                
                Spacer()
                
                HStack {
                    Text("Choose image")
                    Image(systemName: "chevron.right")
                }
            }
            .foregroundColor(.secondary)
        }
        .listRowBackground(Color.lifXLightGray)
        .onTapGesture { viewModel.isShowingPhotoPicker = true }
    }
}


struct AddEventView_Previews: PreviewProvider {
    static var previews: some View {
        CreateEventView()
    }
}


fileprivate struct EventDatePicker: View {
    var text: String
    var selection: Binding<Date>
    
    var body: some View {
        DatePicker(text,
                   selection: selection,
                   displayedComponents: [.date, .hourAndMinute])
        .datePickerStyle(.automatic)
        .padding(EdgeInsets(top: 15, leading: 0, bottom: 15, trailing: 0))
    }
}


fileprivate struct CreateEventButton: View {
    var body: some View {
        Rectangle()
            .fill(Color.mixerPurpleGradient)
            .cornerRadius(30)
            .frame(width: 160, height: 50)
            .shadow(radius: 15)
            .shadow(radius: 5, y: 10)
            .overlay(content: {
                Text("Create Event")
                    .foregroundColor(Color.white)
                    .font(.system(size: 22, weight: .medium, design: .rounded))
            })
    }
}
