//
//  EventFlyerUploadView.swift
//  mixer
//
//  Created by Jose Martinez on 12/22/22.
//


import SwiftUI

struct EventFlyerUploadView: View {
    @StateObject var viewModel = CreateEventViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color.mixerBackground
                .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("A flyer is an effective way to get the word out about your party.")
                        .font(.title3).fontWeight(.medium)
                        .padding(.horizontal, 11)
                }
                .padding(.top, 50)
                
                Text("Touch to Change")
                    .font(.largeTitle.weight(.bold))
                    .padding(.top, 0)
                
                flyerChooser
            }
        }
        .preferredColorScheme(.dark)
        .ignoresSafeArea()
        .overlay(alignment: .bottom, content: {
                NextButton(text: "Create Event")
        })
        .navigationBarTitle(Text("Upload a flyer"), displayMode: .large)
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
        .sheet(isPresented: $viewModel.isShowingPhotoPicker) { PhotoPicker(image: $viewModel.flyer) }
    }
    
    var flyerChooser: some View {
            VStack {
                Image(uiImage: viewModel.flyer)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
                    .frame(width: 350, height: 420)
                    
            }
            .foregroundColor(.white)
            .padding()
            .onTapGesture {
                let impact = UIImpactFeedbackGenerator(style: .medium)
                impact.impactOccurred()
                
                viewModel.isShowingPhotoPicker = true
            }
    }
    
}


struct EventFlyerUploadView_Previews: PreviewProvider {
    static var previews: some View {
        EventFlyerUploadView()
    }
}

