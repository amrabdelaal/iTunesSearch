//
//  iTunesSearchTests.swift
//  iTunesSearchTests
//

import XCTest
import Combine
@testable import iTunesSearch

class MockAPIClient<T: Decodable>: APIClientProtocol {
    var mockedMediaResponse: MediaResponse!
    func fetch<T>(_ t: T.Type, endpoint: Endpoint) -> AnyPublisher<T, Error> where T : Decodable {
        return Just(mockedMediaResponse as! T)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

final class iTunesSearchTests: XCTestCase {
    private var mockAPIClient: MockAPIClient<MediaResponse>!
    private var sut: ViewModel!
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockAPIClient = MockAPIClient<MediaResponse>()
        sut = ViewModel(client: mockAPIClient)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockAPIClient = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCorrectFetchedMedia() throws {
        let fetchedMedia = [Media(wrapperType: "track", kind: "song", artistId: 1563916568, collectionId: 1345530365, trackId: 1345531388, artistName: "Ferdinand fka Left Boy", collectionName: "Ferdinand", trackName: "Book Club", collectionCensoredName: "Ferdinand", trackCensoredName: "Book Club", artistViewUrl: "https://music.apple.com/de/artist/ferdinand-fka-left-boy/1563916568?uo=4", collectionViewUrl: "https://music.apple.com/de/album/book-club/1345530365?i=1345531388&uo=4", trackViewUrl: "https://music.apple.com/de/album/book-club/1345530365?i=1345531388&uo=4", previewUrl: Optional("https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/80/e9/e8/80e9e8e5-80c5-fd81-f5a8-9889656671c9/mzaf_4165290722237811385.plus.aac.p.m4a"), artworkUrl30: Optional("https://is3-ssl.mzstatic.com/image/thumb/Music118/v4/0a/0c/1a/0a0c1a55-f25a-9bc2-5872-850f7172d809/190295669157.jpg/30x30bb.jpg"), artworkUrl60: Optional("https://is3-ssl.mzstatic.com/image/thumb/Music118/v4/0a/0c/1a/0a0c1a55-f25a-9bc2-5872-850f7172d809/190295669157.jpg/60x60bb.jpg"), artworkUrl100: Optional("https://is3-ssl.mzstatic.com/image/thumb/Music118/v4/0a/0c/1a/0a0c1a55-f25a-9bc2-5872-850f7172d809/190295669157.jpg/100x100bb.jpg"), collectionPrice: Optional(10.99), trackPrice: Optional(1.29), releaseDate: Date.now, collectionExplicitness: "explicit", trackExplicitness: "explicit", discCount: 2, discNumber: 1, trackCount: 11, trackNumber: 9, trackTimeMillis: Optional(153057), country: "DEU", currency: "EUR", primaryGenreName: "Pop", isStreamable: true)]
        
        let expectation = XCTestExpectation(description: "Get list of media")
        
        sut.$mediaItems.dropFirst().sink { mediaList in
            XCTAssertEqual(mediaList, fetchedMedia)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        mockAPIClient.mockedMediaResponse = MediaResponse(resultCount: 1, results: fetchedMedia)
        sut.getMedia("book club")
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testWrongFetchedMedia() throws {
        let fetchedMedia = [Media(wrapperType: "track", kind: "song", artistId: 1563916568, collectionId: 1345530365, trackId: 1, artistName: "Ferdinand fka Left Boy", collectionName: "Ferdinand", trackName: "Book Club", collectionCensoredName: "Ferdinand", trackCensoredName: "Book Club", artistViewUrl: "https://music.apple.com/de/artist/ferdinand-fka-left-boy/1563916568?uo=4", collectionViewUrl: "https://music.apple.com/de/album/book-club/1345530365?i=1345531388&uo=4", trackViewUrl: "https://music.apple.com/de/album/book-club/1345530365?i=1345531388&uo=4", previewUrl: Optional("https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/80/e9/e8/80e9e8e5-80c5-fd81-f5a8-9889656671c9/mzaf_4165290722237811385.plus.aac.p.m4a"), artworkUrl30: Optional("https://is3-ssl.mzstatic.com/image/thumb/Music118/v4/0a/0c/1a/0a0c1a55-f25a-9bc2-5872-850f7172d809/190295669157.jpg/30x30bb.jpg"), artworkUrl60: Optional("https://is3-ssl.mzstatic.com/image/thumb/Music118/v4/0a/0c/1a/0a0c1a55-f25a-9bc2-5872-850f7172d809/190295669157.jpg/60x60bb.jpg"), artworkUrl100: Optional("https://is3-ssl.mzstatic.com/image/thumb/Music118/v4/0a/0c/1a/0a0c1a55-f25a-9bc2-5872-850f7172d809/190295669157.jpg/100x100bb.jpg"), collectionPrice: Optional(10.99), trackPrice: Optional(1.29), releaseDate: Date.now, collectionExplicitness: "explicit", trackExplicitness: "explicit", discCount: 2, discNumber: 1, trackCount: 11, trackNumber: 9, trackTimeMillis: Optional(153057), country: "DEU", currency: "EUR", primaryGenreName: "Pop", isStreamable: true)]
        
        let expectation = XCTestExpectation(description: "Get list of media")
        
        sut.$mediaItems.dropFirst().sink { mediaList in
            XCTAssertNotEqual(mediaList, fetchedMedia)
            expectation.fulfill()
        }.store(in: &cancellables)
        
        mockAPIClient.mockedMediaResponse = MediaResponse(resultCount: 1, results: [Media(wrapperType: "track", kind: "song", artistId: 1563916568, collectionId: 1345530365, trackId: 2, artistName: "Ferdinand fka Left Boy", collectionName: "Ferdinand", trackName: "Book Club", collectionCensoredName: "Ferdinand", trackCensoredName: "Book Club", artistViewUrl: "https://music.apple.com/de/artist/ferdinand-fka-left-boy/1563916568?uo=4", collectionViewUrl: "https://music.apple.com/de/album/book-club/1345530365?i=1345531388&uo=4", trackViewUrl: "https://music.apple.com/de/album/book-club/1345530365?i=1345531388&uo=4", previewUrl: Optional("https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/80/e9/e8/80e9e8e5-80c5-fd81-f5a8-9889656671c9/mzaf_4165290722237811385.plus.aac.p.m4a"), artworkUrl30: Optional("https://is3-ssl.mzstatic.com/image/thumb/Music118/v4/0a/0c/1a/0a0c1a55-f25a-9bc2-5872-850f7172d809/190295669157.jpg/30x30bb.jpg"), artworkUrl60: Optional("https://is3-ssl.mzstatic.com/image/thumb/Music118/v4/0a/0c/1a/0a0c1a55-f25a-9bc2-5872-850f7172d809/190295669157.jpg/60x60bb.jpg"), artworkUrl100: Optional("https://is3-ssl.mzstatic.com/image/thumb/Music118/v4/0a/0c/1a/0a0c1a55-f25a-9bc2-5872-850f7172d809/190295669157.jpg/100x100bb.jpg"), collectionPrice: Optional(10.99), trackPrice: Optional(1.29), releaseDate: Date.now, collectionExplicitness: "explicit", trackExplicitness: "explicit", discCount: 2, discNumber: 1, trackCount: 11, trackNumber: 9, trackTimeMillis: Optional(153057), country: "DEU", currency: "EUR", primaryGenreName: "Pop", isStreamable: true)])
        
        sut.getMedia("book club")
        
        wait(for: [expectation], timeout: 1)
    }
    
}
