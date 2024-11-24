//
//  SocialMediaCardView.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 29/09/2023.
//

import SwiftUI

struct SocialMediaCardView: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                Image("avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40)
                    .clipShape(Circle())
                VStack (alignment: .leading) {
                    Text("Max Ward")
                        .font(.headline)
                    Text("@maxward")
                        .font(.footnote)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(alignment: .topTrailing) {
                Image("twitter-icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32)
            }
            Text("Lorem ipsum dolor sit amet illiet es ail consectetur adipiscing elit. Ultrices et pulvinar id convallis quis luctus forza http://ows.lly/95IZ50z3bQP")
                .font(.subheadline)
        }
        .padding()
        .overlay(content: {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color("SocialBg").gradient, lineWidth: 1)
        })
        .foregroundStyle(Color("SocialText"))
        .background(Color("SocialBg"))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    SocialMediaCardView()
        .padding(.horizontal)
}
