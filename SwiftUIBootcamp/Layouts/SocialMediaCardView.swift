//
//  SocialMediaCardView.swift
//  SwiftUIBootcamp
//
//  Created by Max Ward on 29/09/2023.
//

import SwiftUI

struct SocialMediaCardView: View {
    var body: some View {
        VStack {
            HStack {
                Image("avatar")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40)
                    .clipShape(Circle())
                VStack (alignment: .leading) {
                    Text("Max Ward")
                        .font(.system(size: 16)).fontWeight(.medium)
                    Text("@maxward")
                        .font(.system(size: 14)).fontWeight(.medium)
                }
                Spacer()
                Image("twitter-icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24)
            }
            Text("Lorem ipsum dolor sit amet illiet es ail consectetur adipiscing elit. Ultrices et pulvinar id convallis quis luctus forza http://ows.lly/95IZ50z3bQP")
                .padding(.top, 8)
        }
        .padding()
        .overlay(content: {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("SocialBg").gradient, lineWidth: 1)
        })
        .foregroundStyle(Color("SocialText"))
        .background(Color("SocialBg"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    SocialMediaCardView()
}
