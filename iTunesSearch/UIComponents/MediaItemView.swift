//
//  MediaItemView.swift
//  iTunesSearch
//

import SwiftUI

struct MediaItemView: View {
    var mediaItem: Media
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 10.0) {
            HStack {
                RemoteImage(url: mediaItem.artworkUrl30 ?? "")
                    .frame(width: 50, height: 50)
                    .background(Color.gray)
                    .clipShape(Circle())
                    .padding()
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(mediaItem.artistName)
                    Text(mediaItem.trackName)
                        .bold()
                    Text(mediaItem.collectionName)
                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                
                Spacer()
            }
        }
        .cornerRadius(15)
        .background(Color.white
            .cornerRadius(15)
            .shadow(color: .gray, radius: 5)
        )
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}

struct MediaItemView_Previews: PreviewProvider {
    static var previews: some View {
        let media = Media(wrapperType: "track", kind: "song", artistId: 1563916568, collectionId: 1345530365, trackId: 1345531388, artistName: "Ferdinand fka Left Boy", collectionName: "Ferdinand", trackName: "Book Club", collectionCensoredName: "Ferdinand", trackCensoredName: "Book Club", artistViewUrl: "https://music.apple.com/de/artist/ferdinand-fka-left-boy/1563916568?uo=4", collectionViewUrl: "https://music.apple.com/de/album/book-club/1345530365?i=1345531388&uo=4", trackViewUrl: "https://music.apple.com/de/album/book-club/1345530365?i=1345531388&uo=4", previewUrl: Optional("https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/80/e9/e8/80e9e8e5-80c5-fd81-f5a8-9889656671c9/mzaf_4165290722237811385.plus.aac.p.m4a"), artworkUrl30: Optional("https://is3-ssl.mzstatic.com/image/thumb/Music118/v4/0a/0c/1a/0a0c1a55-f25a-9bc2-5872-850f7172d809/190295669157.jpg/30x30bb.jpg"), artworkUrl60: Optional("https://is3-ssl.mzstatic.com/image/thumb/Music118/v4/0a/0c/1a/0a0c1a55-f25a-9bc2-5872-850f7172d809/190295669157.jpg/60x60bb.jpg"), artworkUrl100: Optional("https://is3-ssl.mzstatic.com/image/thumb/Music118/v4/0a/0c/1a/0a0c1a55-f25a-9bc2-5872-850f7172d809/190295669157.jpg/100x100bb.jpg"), collectionPrice: Optional(10.99), trackPrice: Optional(1.29), releaseDate: Date.now, collectionExplicitness: "explicit", trackExplicitness: "explicit", discCount: 2, discNumber: 1, trackCount: 11, trackNumber: 9, trackTimeMillis: Optional(153057), country: "DEU", currency: "EUR", primaryGenreName: "Pop", isStreamable: true)
        
        MediaItemView(mediaItem: media)
    }
}
