//
//  MovieModels.swift
//  NoktaMedyaCase
//
//  Created by Furkan Tümay on 12/23/23.
//

//MARK: - FEATURED JSON MODEL
struct FeaturedResponse: Codable {
    let featured: [FeaturedMovie]
//    let ontheaters: [OnTheatherMovie]
//        let upcoming: []
//        let topMovies: []
//        let trailers: []
//        let news: []
//        let bornToday: []
//        let recentLists: []
//        let popularArtists: []
//        let platforms: []
}

struct FeaturedMovie: Codable {
    let id: Int
    let name: String
    let image: String
    let pub_date_formatted: String
    let ontheaters: String
    let recurrent: Bool
    let rating: Double
    let org_name: String?
    let trailers: [Trailer]
}

struct Trailer: Codable {
    let title: String
    let thumbnail: String
    let info: String
    let add_date: String
    let ago: String
    let movie_id: Int
    let embed_video_id: String
    let source: [String: String]
}

//MARK: - ONTHEATERS JSON MODEL
struct FeaturedResponse2: Codable {
    let ontheaters: [[OnTheatherMovie]]
}

struct OnTheatherMovie: Codable {
    //let id: Int
    let name: String
    //let org_name: String?
    let image: String
    //let url_name: String
    //let url: String
    //let release_status: String
    //let recurrent: Bool
    //let duration: Int?
    //let actors: [Actor]
    //let genres: String
    //let countries: String
    //let produce_year: Int
    
}

//MARK: - NEWS JSON MODEL
struct FeaturedResponse3: Codable {
    let news: [NewsMovie]
}

struct NewsMovie: Codable {
    let id: Int
    let title: String
    let image: String
    let addDate: String?
    let publishDate: String?
    let ago: String
    let url: String
    let ts: Int
    //let video: VideoItem?
}

//MARK: - POPULAR JSON MODEL
struct FeaturedResponse4: Codable {
    let popularArtists: [PopularArtists]
}

struct PopularArtists: Codable {
    let id: Int
    let name: String?
    let surname: String?
    let name_surname: String
    let picture: String
    let url: String
}

//MARK: - SHAWSHANK REDEMPTION JSON MODEL
struct MovieDetail: Codable {
    //let id: Int
    let name: String
    let org_name: String
    let summary: String
    //let rating: Double
    //let rating_str: String
    //let url: String
    //let voting_enabled: Bool
    //let rating_count: Int
    let image: String
    //let onTheaters: String
    //let fav_count: String
    //let release_status: Int
    //let produce_year: Int
    //let duration: Int
    //let imdbid: String
    //let pub_date_iso: String
    //let pub_date_formatted: String
    //let pub_date: String
    //let similars: [Similars]
    let images: [String]
    let genres: [GenresMovie]
}

struct GenresMovie: Codable {
    let id: Int
    let name: String
}

//MARK: - COMMENTS JSON MODEL

struct Comment: Codable {
    let popular_comments: [MovieComment]
    let comments: [MovieComment]
}

struct MovieComment: Codable {
    //let id: Int
    let comment: String
    //let hasSpoiler: Bool
    //let spoiler: Bool
    let user: User
    //let voteUp: Int
    //let voteDown: Int
    //let timestamp: Int
    let date: String
    //let replies: [MovieComment]?
}

struct User: Codable {
    //let id: Int
    let username: String
    //let avatar: String
    let level: String
}
