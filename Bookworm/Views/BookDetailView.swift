//
//  BookDetailView.swift
//  Bookworm
//
//  Created by Dayton Bobbitt on 12/21/21.
//

import SwiftUI

struct BookDetailView: View {
    private let book: Book
    
    @Environment(\.managedObjectContext) private var managedObjectContext
    @Environment(\.dismiss) private var dismiss
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        return dateFormatter
    }()
    
    @State private var deleteAlertIsPresented = false
    
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
            
            VStack(alignment: .leading, spacing: 20) {
                if let title = book.title, let author = book.author {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(title)
                            .font(.title)
                        
                        Text(author)
                            .font(.subheadline)
                    }
                }
                
                if let review = book.review {
                    Text(review)
                }
                
                Group {
                    if let rating = book.rating {
                        Rating(rating: .constant(Int(rating)))
                            .font(.title2)
                    }
                    
                    if let createdAt = book.createdAt {
                        Text("Added on \(dateFormatter.string(from: createdAt))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.horizontal)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    self.deleteAlertIsPresented = true
                } label: {
                    Label("Delete book", systemImage: "trash")
                        .font(.subheadline)
                }
            }
        }
        .alert("Delete book", isPresented: $deleteAlertIsPresented) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure?")
        }
    }
    
    private func deleteBook() {
        managedObjectContext.delete(book)
        
        try? managedObjectContext.save()
        
        dismiss()
    }
}
