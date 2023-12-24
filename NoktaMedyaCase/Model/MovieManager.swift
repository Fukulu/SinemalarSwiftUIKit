//
//  MovieModel.swift
//  NoktaMedyaCase
//
//  Created by Furkan Tümay on 12/22/23.
//

import UIKit

struct MovieManager {
    
    static var movieList: [FeaturedMovie] = []
    static var onTheatherList: [OnTheatherMovie] = []
    static var newsList: [NewsMovie] = []
    static var popularList: [PopularArtists] = []
    static var movieDetailList: [MovieDetail] = []
    static var movieCommentList: [MovieComment] = []
    
    //MARK: - FEATURED MOVIES JSON
    
    static func fetchFinalFeatured(completion: @escaping () -> Void) {
        Task {
            do {
                movieList = try await fetchMovies()
                completion()
            } catch {
                print("Error fetching movies: \(error)")
            }
        }
    }
    
    static func fetchMovies() async throws -> [FeaturedMovie] {
        let urlString = "https://www.sinemalar.com/api/test/v1/home"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            throw NSError(domain: "InvalidURL", code: 0, userInfo: nil)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "InvalidResponse", code: 0, userInfo: nil)
        }
        
        var movieListFetching = [FeaturedMovie]()
        let decoder = JSONDecoder()
        do {
            let featuredResponse = try decoder.decode(FeaturedResponse.self, from: data)
            let featuredMovies = featuredResponse.featured
            for movie in featuredMovies {
                let id = movie.id
                let name = movie.name
                let image = movie.image
                let pub_date_formatted = movie.pub_date_formatted
                let ontheaters = movie.ontheaters
                let recurrent = movie.recurrent
                let rating = movie.rating
                let org_name = movie.org_name
                let trailers = movie.trailers
                
                let movieDataFetched = FeaturedMovie(id: id, name: name, image: image, pub_date_formatted: pub_date_formatted, ontheaters: ontheaters, recurrent: recurrent, rating: rating, org_name: org_name, trailers: trailers)
                movieListFetching.append(movieDataFetched)
            }
        } catch {
            print("Error while JSON Parsing: \(error)")
        }
        
        return movieListFetching
    }
    
    //MARK: - ONTHEATHER MOVIES JSON
    
    static func fetchFinalOnTheather(completion: @escaping () -> Void) {
        Task {
            do {
                onTheatherList = try await fetchOnTheather()
                completion()
            } catch {
                print("Error fetching movies: \(error)")
            }
        }
    }
    
    static func fetchOnTheather() async throws -> [OnTheatherMovie] {
        let urlString = "https://www.sinemalar.com/api/test/v1/home"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            throw NSError(domain: "InvalidURL", code: 0, userInfo: nil)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "InvalidResponse", code: 0, userInfo: nil)
        }
        
        var onTheatherListFetching = [OnTheatherMovie]()
        //TODO: - SHAWSHANK REDEMPTION INFO ADDED FOR EXAMPLE USAGE OF SEGUE TO DETAILVIEW
        onTheatherListFetching.append(OnTheatherMovie(name: "Esaretin Bedeli", image: "https://img01.imgsinemalar.com/images/afis_dev/e/esaretin-bedeli-1660926263.jpg"))
        let decoder = JSONDecoder()
        do {
            let featuredResponse2 = try decoder.decode(FeaturedResponse2.self, from: data)
            let onTheatherMovies = featuredResponse2.ontheaters
            for movie in onTheatherMovies[0] {
                //let id = movie.id
                let name = movie.name
                //let org_name = movie.org_name
                let image = movie.image
                //let url_name = movie.url_name
                //let url = movie.url
                //let release_status = movie.release_status
                //let recurrent = movie.recurrent
                //let duration = movie.duration
                //let actors = movie.actors
                //let genres = movie.genres
                //let countries = movie.countries
                //let produce_year = movie.produce_year
                
                let movieDataFetched = OnTheatherMovie(name: name, image: image)
                onTheatherListFetching.append(movieDataFetched)
            }
        } catch {
            print("Error while JSON Parsing: \(error)")
        }
        
        return onTheatherListFetching
    }
    
    //MARK: - NEWS MOVIES JSON
    
    static func fetchFinalNews(completion: @escaping () -> Void) {
        Task {
            do {
                newsList = try await fetchNews()
                completion()
            } catch {
                print("Error fetching movies: \(error)")
            }
        }
    }
    
    static func fetchNews() async throws -> [NewsMovie] {
        let urlString = "https://www.sinemalar.com/api/test/v1/home"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            throw NSError(domain: "InvalidURL", code: 0, userInfo: nil)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "InvalidResponse", code: 0, userInfo: nil)
        }
        
        var newListFetching = [NewsMovie]()
        let decoder = JSONDecoder()
        do {
            let featuredResponse3 = try decoder.decode(FeaturedResponse3.self, from: data)
            let onTheatherMovies = featuredResponse3.news
            for movie in onTheatherMovies {
                let id = movie.id
                let title = movie.title
                let image = movie.image
                let addDate = movie.addDate
                let publishDate = movie.publishDate
                let ago = movie.ago
                let url = movie.url
                let ts = movie.ts
                
                let movieDataFetched = NewsMovie(id: id, title: title, image: image, addDate: addDate, publishDate: publishDate, ago: ago, url: url, ts: ts)
                 newListFetching.append(movieDataFetched)
            }
        } catch {
            print("Error while JSON Parsing: \(error)")
        }
        
        return newListFetching
    }
    
    //MARK: - POPULAR MOVIES JSON
    
    static func fetchFinalPopular(completion: @escaping () -> Void) {
        Task {
            do {
                popularList = try await fetchPopular()
                completion()
            } catch {
                print("Error fetching movies: \(error)")
            }
        }
    }
    
    static func fetchPopular() async throws -> [PopularArtists] {
        let urlString = "https://www.sinemalar.com/api/test/v1/home"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            throw NSError(domain: "InvalidURL", code: 0, userInfo: nil)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "InvalidResponse", code: 0, userInfo: nil)
        }
        
        var popularListFetching = [PopularArtists]()
        let decoder = JSONDecoder()
        do {
            let featuredResponse4 = try decoder.decode(FeaturedResponse4.self, from: data)
            let popularArtists = featuredResponse4.popularArtists
            for artist in popularArtists {
                let id = artist.id
                let name = artist.name
                let surname = artist.surname
                let nameSurname = artist.name_surname
                let picture = artist.picture
                let url = artist.url
                
                let artistDataFetched = PopularArtists(id: id, name: name, surname: surname, name_surname: nameSurname, picture: picture, url: url)
                popularListFetching.append(artistDataFetched)
            }
        } catch {
            print("Error while JSON Parsing: \(error)")
        }
        
        return popularListFetching
    }
    
    //MARK: - SHAWSHANK REDEMPTION JSON
    
    static func fetchFinalMovieDetail(from movieLink: String, completion: @escaping () -> Void) {
        Task {
            do {
                movieDetailList = try await fetchMovieDetail(from: movieLink)
                completion()
            } catch {
                print("Error fetching movies: \(error)")
            }
        }
    }
    
    static func fetchMovieDetail(from movieLink: String) async throws -> [MovieDetail] {
        let urlString = movieLink
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            throw NSError(domain: "InvalidURL", code: 0, userInfo: nil)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "InvalidResponse", code: 0, userInfo: nil)
        }
        
        var movieDetailFetching = [MovieDetail]()
        let decoder = JSONDecoder()
        do {
            let detailResponse = try decoder.decode(MovieDetail.self, from: data)
            let image = detailResponse.image
            let name = detailResponse.name
            let org_name = detailResponse.org_name
            let summary = detailResponse.summary
            let images = detailResponse.images
            let genres = detailResponse.genres
                    
            let movieDetailFetched = MovieDetail(name: name, org_name: org_name, summary: summary, image: image, images: images, genres: genres)
            movieDetailFetching.append(movieDetailFetched)
        } catch {
            print("Error while JSON Parsing: \(error)")
        }
        
        return movieDetailFetching
    }
    
    //MARK: - COMMENTS JSON
    
    static func fetchFinalComments(page: Int, limit: Int, from movieLink: String, completion: @escaping () -> Void) {
        Task {
            do {
                movieCommentList = try await fetchMovieComments(from: "\(movieLink)?page=\(page)&limit=\(limit)")
                completion()
            } catch {
                print("Error fetching movies: \(error)")
            }
        }
    }
    
    static func fetchMovieComments(from movieLink: String) async throws -> [MovieComment] {
        let urlString = movieLink
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            throw NSError(domain: "InvalidURL", code: 0, userInfo: nil)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NSError(domain: "InvalidResponse", code: 0, userInfo: nil)
        }
        
        var movieCommentFetching = [MovieComment]()
        let decoder = JSONDecoder()
        do {
            let detailResponse = try decoder.decode(Comment.self, from: data)
            let comments = detailResponse.comments
            for com in comments {
                let comment = com.comment
                let user = com.user
                let date = com.date
                let movieCommentFetched = MovieComment(comment: comment, user: user, date: date)
                movieCommentFetching.append(movieCommentFetched)
            }
        } catch {
            print("Error while JSON Parsing: \(error)")
        }
        
        return movieCommentFetching
    }
}
