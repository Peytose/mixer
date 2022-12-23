//
//  ExplorePageViewModel.swift
//  mixer
//
//  Created by Jose Martinez on 12/21/22.
//


import CloudKit
import SwiftUI

enum ExploreContext: String, CaseIterable {
    case current = "Currently Throwing"
    case upcoming = "Upcoming Events"
}

final class ExplorePageViewModel: ObservableObject {
    @Published var showSearchView = false
    @Published var showEventView = false
    @Published var showHostView = false
    @Published var contentHasScrolled = false
    @Published var showCurrentEvent = false
    @Published var expandMenu = false
    @Published var showNavigationBar = true
    @Namespace private var namespace
    @Published var exploreContext: ExploreContext = .current
    @Published var headerOffsets: (CGFloat,CGFloat) = (0,0)
    @Namespace var animation
    
    @ViewBuilder func stickyHeader() -> some View {
            HStack {
                ForEach(ExploreContext.allCases, id: \.self) { [self] context in
                    VStack(spacing: 8) {

                        Text(context.rawValue)
                            .fontWeight(.semibold)
                            .foregroundColor(exploreContext == context ? .white : .gray)

                        ZStack{
                            if exploreContext == context {
                                RoundedRectangle(cornerRadius: 4, style: .continuous)
                                    .fill(Color.mixerIndigo)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                            else {
                                RoundedRectangle(cornerRadius: 4, style: .continuous)
                                    .fill(.clear)
                            }
                        }
                        .padding(.horizontal,8)
                        .frame(height: 4)
                    }
                    .padding(.leading)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            self.exploreContext = context
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 25)
            .padding(.bottom,5)
    }
}