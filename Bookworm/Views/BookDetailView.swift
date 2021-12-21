//
//  BookDetailView.swift
//  Bookworm
//
//  Created by Dayton Bobbitt on 12/21/21.
//

import SwiftUI

struct BookDetailView: View {
    private let book: Book
    
    init(for book: Book) {
        self.book = book
    }
    
    var body: some View {
        ScrollView {
            if let genre = book.genre {
                ZStack(alignment: .bottomTrailing) {
                    Image(genre)
                        .resizable()
                        .scaledToFit()
                    
                    Text(genre.uppercased())
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
            }
            
            VStack(alignment: .leading, spacing: 16) {
                if let title = book.title, let author = book.author {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(title)
                            .font(.title)
                        
                        Text(author)
                            .font(.subheadline)
                    }
                }
                
                if let rating = book.rating {
                    Rating(rating: .constant(Int(rating)))
                }
                
                if let review = book.review {
                    Text(review)
                }
            }
            .padding(.horizontal)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
