//
//  CreateEventView.swift
//  mixer
//
//  Created by Jose Martinez on 12/18/22.
//

import SwiftUI

struct CreateEventView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = CreateEventViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.mixerBackground
                    .ignoresSafeArea()
                
                    List {
                        mainDetailsSection
                        
                        addressSection
                        
                            Section(header: Text("Map Preview")) {
                                MapSnapshotView(location: viewModel.coordinates, span: 0.001, delay: 0)
                                    .cornerRadius(12)
                                    .padding(.bottom, 40)
                            }
                            .listRowBackground(Color.clear)
                    }
                    .tint(.mixerIndigo)
                    .preferredColorScheme(.dark)
                    .scrollContentBackground(.hidden)
                    .scrollIndicators(.hidden)
            }
            .overlay(alignment: .bottom, content: {
                NavigationLink(destination: EventVisibilityView()) {
                    NextButton()
                }
            })
            .navigationBarTitle(Text("Create an Event"), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.blue)
                })
            }
        }
    }
    
    var mainDetailsSection: some View {
        Section(header: Text("Main Details")) {
            TextField("Event Title*", text: $viewModel.title)
                .foregroundColor(Color.mainFont)
                .font(.body.weight(.semibold))

            TextField("Event Description/Theme*", text: $viewModel.description, axis: .vertical)
                .foregroundColor(Color.mainFont)
                .font(.body.weight(.semibold))
                .lineLimit(4)

            EventDatePicker(text: "Start date*", selection: $viewModel.startDate)
            
            EventDatePicker(text: "End date*", selection: $viewModel.endDate)
            
            Picker("Wet or Dry", selection: $viewModel.selectedWetDry) {
                Text("Dry").tag(WetOrDry.dry)
                Text("Wet").tag(WetOrDry.wet)
            }
            .pickerStyle(.segmented)
            .padding()
        }
        .listRowBackground(Color.mixerSecondaryBackground)
    }
    
    var addressSection: some View {
        Section(header: Text("Location Details")) {
            Text("Theta Chi House: 528 Beacon St")
                .font(.body.weight(.semibold))
            
            Toggle("Use different address", isOn: $viewModel.isAddress.animation())
                .font(.body.weight(.semibold))
            
            if viewModel.isAddress {
                TextField("Address", text: $viewModel.address)
                    .foregroundColor(Color.mainFont)
                    .font(.body.weight(.semibold))
            }

        }
        .listRowBackground(Color.mixerSecondaryBackground)
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
        .padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: -5))
    }
}
