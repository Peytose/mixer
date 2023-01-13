//
//  EventRowView.swift
//  mixer
//
//  Created by Jose Martinez on 1/12/23.
//
import SwiftUI

struct EventRow: View {
    var flyer: String
    var title: String
    var date: String
    var attendance: String
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(spacing: 15) {
                Image(flyer)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(title)
                            .fontWeight(.semibold)
                        
                        Text(date)
                            .fontWeight(.semibold)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    HStack {
                        Image(systemName: "person.3.fill")
                            .imageScale(.small)
                            .symbolRenderingMode(.hierarchical)
                        
                        Text("\(attendance) Attended")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                    }
                }
                .lineLimit(1)
                .minimumScaleFactor(0.75)
                
                Spacer()
                                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.white.opacity(0.7))
                })
            }
        }
        .frame(height: 60)
    }
}
