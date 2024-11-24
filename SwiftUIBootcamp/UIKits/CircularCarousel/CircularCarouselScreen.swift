//
//  CircularCarousel.swift
//  SwiftUIBootcamp
//
//  Created by Max on 04/06/2024.
//

import SwiftUI

struct CreditCard: Identifiable {
    var id: UUID = .init()
    var number: String
    var name: String = "Max Ward"
    var date: String = "12/24"
    var color: Color
}

extension CreditCard {
    static var mock: [CreditCard] = [
        .init(number: "1234", color: .blue1),
        .init(number: "7821", color: .blue2),
        .init(number: "8871", color: .blue3),
        .init(number: "9981", color: .blue4),
        .init(number: "4435", color: .blue5),
        .init(number: "9001", color: .green1),
        .init(number: "1121", color: .green2)
    ]
}

struct CircularCarouselScreen: View {
    
    @Environment(\.dismiss) var dismiss
    private let generator = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            ScrollView {
                LazyVStack(spacing: 0){
                    ForEach(CreditCard.mock) { card in
                        CardView(card)
                            .frame(width: 220, height: 150)
                            .visualEffect { content, geometryProxy in
                                content
                                    //.scaleEffect(geometryProxy.frame(in: .global).minY < 100 ? 0.1 : 1.0)
                                    .offset(x: -150)
                                    /*
                                     when we use the rotation modifier, the view simply spins at the same spot.
                                     However, if we apply an offset before applying the rotation modifier, the view will
                                     rotate in a circular form with the circle radius equal to the moved offset. By using this
                                     concept, we can convert the vertica carousel into a circular one.
                                     */
                                    .rotationEffect(
                                        .init(degrees: cardRotation(geometryProxy, card: card)),
                                        anchor: .trailing
                                    )
                                    .offset(x: 100, y: -geometryProxy.frame(in: .scrollView(axis: .vertical)).minY)
                                    .scaleEffect(cardScale(geometryProxy, card: card))
                                    
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            
                    }
                }
                .scrollTargetLayout()
            }
            .toolbar(.hidden, for: .navigationBar)
            .safeAreaPadding(.vertical, (size.height * 0.5) - 75) // 75 es la mitad de cada cardview
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
            .background(
                Circle()
                    .fill(.ultraThinMaterial)
                    .frame(width: size.height, height: size.height)
                    .offset(x: size.height / 2)
            )
            
            VStack(alignment: .leading, spacing: 12) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "arrow.left")
                        .font(.title3.bold())
                        .foregroundStyle(Color.primary)
                })
                
                Text("Total")
                    .font(.title3.bold())
                    .padding(.top, 10)
                Text("998.45")
                    .font(.largeTitle)
                Text("Choose a card")
                    .font(.caption2)
                    .foregroundStyle(.gray)
                
            }
            .padding(15)
        }
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
                    .frame(width: 40)
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
    
    func cardScale(_ proxy: GeometryProxy, card: CreditCard) -> CGSize {
        let minY = proxy.frame(in: .scrollView(axis: .vertical)).minY
        let height = proxy.size.height
        let progress = minY / height
        
        // Cap the progress to be between -1 and 1
        let cappedProgress = min(max(progress, -1), 1)
        
        // Calculate the scale factor, where the center item has a scale of 1.3
        let scaleFactor = 0.6 + (0.6 * (1 - abs(cappedProgress)))
        
        if card.number == "7821" {
            print(scaleFactor)
        }
        
        return CGSize(width: scaleFactor, height: scaleFactor)
    }
    
    func cardRotation(_ proxy: GeometryProxy, card: CreditCard) -> CGFloat {
        let minY = proxy.frame(in: .scrollView(axis: .vertical)).minY
        let height = proxy.size.height
        let progress = minY / height
        let angleForEachCard: CGFloat = -58
        let cappedProgress = progress < 0 ? min(max(progress, -3), 0) : max(min(progress, 3), 0)
        let totalProgress = cappedProgress * angleForEachCard
        
        return totalProgress
        /*
         the result is not circular. this is because, when all the views are in one position,
         applying a rotation modifier will give us a circular patter view. Nevertheless, we
         can use the same visualEffect API to ensure that every card remains at the top
         of the scrollView.
         */
    }
}

#Preview {
    CircularCarouselScreen()
}
