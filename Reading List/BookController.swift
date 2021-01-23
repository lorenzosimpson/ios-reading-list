//
//  BookController.swift
//  Reading List
//
//  Created by Lorenzo on 1/20/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
  
    
    var books: [Book] = [Book(title: "A book", reasonToRead: "It's great", hasBeenRead: true)]
    
    var readBooks: [Book] {
        return books.filter { $0.hasBeenRead == true }
    }
    
    var unreadBooks: [Book] {
        return books.filter { $0.hasBeenRead == false }
    }
    
    var readingListURL: URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return nil }
        return dir.appendingPathComponent("reading.plist")
    }
    
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        guard let url = readingListURL else { return }
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Saving data failed")
        }
    }
    
    func loadFromPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let booksData = try Data.init(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            self.books = decodedBooks
        } catch {
            print("Failed to load data")
        }
    
    }
    
    func create(title: String, reasonToRead: String) {
        var book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
    }
    
    func delete(book: Book) {
        var index = 0
        for b in books {
            if b == book {
                books.remove(at: index)
                saveToPersistentStore()
                return
            }
            index += 1
        }
    }
    
    func updateHasBeenRead(book: Book) {
        // find the book and update it in the array
        var index = 0
        
        let updatedBook = Book(title: book.title, reasonToRead: book.reasonToRead, hasBeenRead: !book.hasBeenRead)
        for b in books {
            if b == book {
                books[index] = updatedBook
                saveToPersistentStore()
                return
            }
            index += 1
           
        }
    }
    
    func updateBook(book: Book, newBookTitle: String?, newReasonToRead: String?) {
        var index = 0
        

        for b in books {
            if b == book {
                if let newTitle = newBookTitle {
                    books[index].title = newTitle
                }
                if let newReason = newReasonToRead {
                    books[index].reasonToRead = newReason
                }
                saveToPersistentStore()
                return
            }
            index += 1
        }
    }
}
