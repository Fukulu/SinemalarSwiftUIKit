//
//  DetailViewController.swift
//  NoktaMedyaCase
//
//  Created by Furkan Tümay on 12/24/23.
//

import UIKit

class DetailView: UIViewController {

    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var orginalTitleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var commentCollectionView: UICollectionView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollDetailView: UIScrollView!
    
    var commentCount = 5
    var isLoading = false
    var movieLink: String = "https://www.sinemalar.com/api/test/v1/movies/638"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.overrideUserInterfaceStyle = .dark

        MovieManager.fetchFinalMovieDetail(from : movieLink) { [weak self] in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
        
        MovieManager.fetchFinalComments(page: 1, limit: 5, from: "https://www.sinemalar.com/api/test/v1/movies/638/comments"){ [weak self] in
            DispatchQueue.main.async {
                self?.commentCollectionView.reloadData()
            }
        }
        commentCollectionView.delegate = self
        commentCollectionView.dataSource = self
        scrollDetailView.delegate = self
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToMainView", sender: self)
    }
    
    
    func updateUI(){
        if let imageURL = URL(string: MovieManager.movieDetailList[0].image) {
            URLSession.shared.dataTask(with: imageURL) { data, _, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.topImage.image = image
                        self.topImage.contentMode = .scaleAspectFill
                        self.topImage.layer.opacity = 0.3
                    }
                }
            }.resume()
        }
        for genre in MovieManager.movieDetailList[0].genres {
            genresLabel.text! += "\(genre.name) "
        }
        titleLabel.text = MovieManager.movieDetailList[0].name
        orginalTitleLabel.text = MovieManager.movieDetailList[0].org_name
        
        if let imageURL = URL(string: MovieManager.movieDetailList[0].images[3]) {
            URLSession.shared.dataTask(with: imageURL) { data, _, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.posterImage.image = image
                        self.posterImage.contentMode = .scaleAspectFill
                        self.posterImage.layer.cornerRadius = 5
                    }
                }
            }.resume()
        }
        descriptionLabel.text = MovieManager.movieDetailList[0].summary
    }
    
    

}

extension DetailView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Main Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieManager.movieCommentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCollectionViewCell", for: indexPath) as? CommentCollectionViewCell
    
        cell?.nameLabel.text = MovieManager.movieCommentList[indexPath.row].user.username
        cell?.levelLabel.text = MovieManager.movieCommentList[indexPath.row].user.level
        cell?.dateLabel.text = MovieManager.movieCommentList[indexPath.row].date
        cell?.commentLabel.text = MovieManager.movieCommentList[indexPath.row].comment
        cell?.commentView.layer.cornerRadius = 10
        return cell!
    }

    //MARK: - PAGINATION EXAMPLE WITH COLLECTION VIEW LEARNED FROM
    /// https://www.youtube.com/watch?v=AhnlxJyYf64
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.height
        //print(offsetY, contentHeight, screenHeight)
        
        if offsetY > (contentHeight - screenHeight) &&  !isLoading {
            isLoading = true
            commentCount += 2
            print(commentCount)
            MovieManager.fetchFinalComments(page: 1, limit: commentCount, from: "https://www.sinemalar.com/api/test/v1/movies/638/comments") { [weak self] in
                DispatchQueue.main.async {
                    self?.commentCollectionView.reloadData()
                    self?.adjustBottomViewHeight()
                    self?.isLoading = false
                }
            }
        }
    }
    
    //MARK: - I Got This Idea From CHATGPT to get an outlet of bottomView Height constraint
    func adjustBottomViewHeight() {
        let newBottomViewHeight = commentCollectionView.contentSize.height
        bottomViewHeight.constant = newBottomViewHeight
        // Animate the constraint change
//        UIView.animate(withDuration: 0.3) {
//            self.view.layoutIfNeeded()
//        }
    }
    
    
    
        
}


