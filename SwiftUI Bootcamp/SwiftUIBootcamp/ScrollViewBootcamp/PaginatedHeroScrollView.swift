//
//  PaginatedHeroScrollView.swift
//  SwiftUIBootcamp
//
//  Created by Max on 10/06/2024.
//

import SwiftUI

struct PaginatedHeroScrollView: View {
    
    let hero: [CreditCard] = CreditCard.mock
    let content: [CreditCard] = CreditCard.mock
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(hero) { card in
                        CardView(card)
                            .containerRelativeFrame(.horizontal, count: 2, spacing: 0)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
            .frame(height: 180)
            
            Spacer()
        }
        .safeAreaPadding(.horizontal)
    }
        
    @ViewBuilder
    func CardView(_ card: CreditCard) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(card.color.gradient)
            
            // card details
            VStack(alignment: .leading, spacing: 10) {
                Image("visa")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 50)
                Spacer(minLength: 0)
                HStack(spacing: 0) {
                    ForEach(0..<3, id: \.self) { _ in
                        Text("****")
                        Spacer(minLength: 0)
                    }
                    Text(card.number)
                }
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .padding(.bottom, 10)
                
                HStack {
                    Text(card.name)
                    Spacer(minLength: 0)
                    Text(card.date)
                }
                .font(.caption.bold())
                .foregroundStyle(.white)
            }
            .padding(25)
        }
    }
}

#Preview {
    PaginatedHeroScrollView()
}
