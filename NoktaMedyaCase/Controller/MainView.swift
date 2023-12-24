//
//  ViewController.swift
//  NoktaMedyaCase
//
//  Created by Furkan Tümay on 12/22/23.
//

import UIKit

class MainView: UIViewController {

    @IBOutlet weak var searcBarOutlet: UISearchBar!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var mainPageController: UIPageControl!
    @IBOutlet weak var theaterCollectionView: UICollectionView!
    @IBOutlet weak var newsCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.overrideUserInterfaceStyle = .dark
        
        MovieManager.fetchFinalFeatured { [weak self] in
            DispatchQueue.main.async {
                self?.mainCollectionView.reloadData()
            }
        }
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        MovieManager.fetchFinalOnTheather { [weak self] in
            DispatchQueue.main.async {
                self?.theaterCollectionView.reloadData()
            }
        }
        theaterCollectionView.delegate = self
        theaterCollectionView.dataSource = self
        
        MovieManager.fetchFinalNews{ [weak self] in
            DispatchQueue.main.async {
                self?.newsCollectionView.reloadData()
            }
        }
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        
        MovieManager.fetchFinalPopular { [weak self] in
            DispatchQueue.main.async {
                self?.popularCollectionView.reloadData()
            }
        }
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {}
    

}

extension MainView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Main Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.mainCollectionView{
            return MovieManager.movieList.count
        } else if collectionView == self.theaterCollectionView {
            return MovieManager.onTheatherList.count
        } else if collectionView == self.newsCollectionView{
            return MovieManager.newsList.count
        } else {
            return MovieManager.popularList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.mainCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as? CustomCollectionViewCell
            
            cell?.title.text = MovieManager.movieList[indexPath.row].name
            cell?.subtitle.text = MovieManager.movieList[indexPath.row].org_name
            
            if let imageURL = URL(string: MovieManager.movieList[indexPath.row].image) {
                URLSession.shared.dataTask(with: imageURL) { data, _, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async { [weak cell] in
                            cell?.mainImage.image = image
                            cell?.mainImage.contentMode = .scaleAspectFill
                            cell?.mainImage.layer.opacity = 0.3
                            cell?.subImage.image = image
                            cell?.subImage.layer.cornerRadius = 5
                            cell?.subImage.contentMode = .scaleAspectFill
                        }
                    }
                }.resume()
            }
            return cell!
        } else if collectionView == self.theaterCollectionView {
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "TheaterCollectionViewCell", for: indexPath) as? TheaterCollectionViewCell
            cell2?.theatherTitle.text = MovieManager.onTheatherList[indexPath.row].name
            if let imageURL = URL(string: MovieManager.onTheatherList[indexPath.row].image) {
                URLSession.shared.dataTask(with: imageURL) { data, _, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async { [weak cell2] in
                            cell2?.theatherImage.image = image
                            cell2?.theatherImage.contentMode = .scaleAspectFill
                            cell2?.theatherImage.layer.cornerRadius = 5
                            cell2?.theatherImage.layer.opacity = 0.8
                        }
                    }
                }.resume()
            }
            return cell2!
        } else if collectionView == self.newsCollectionView {
            let cell3 = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as? NewsCollectionViewCell
            cell3?.newsTitle.text = MovieManager.newsList[indexPath.row].title
            cell3?.newsTime.text = MovieManager.newsList[indexPath.row].ago
            if let imageURL = URL(string: MovieManager.newsList[indexPath.row].image) {
                URLSession.shared.dataTask(with: imageURL) { data, _, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async { [weak cell3] in
                            cell3?.newsImage.image = image
                            cell3?.newsImage.contentMode = .scaleAspectFill
                            cell3?.newsImage.layer.cornerRadius = 5
                            cell3?.newsImage.layer.opacity = 0.8
                        }
                    }
                }.resume()
            }
            return cell3!
        } else {
            let cell4 = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath) as? PopularCollectionViewCell
            cell4?.popularLabel.text = MovieManager.popularList[indexPath.row].name_surname
            if let imageURL = URL(string: MovieManager.popularList[indexPath.row].picture) {
                URLSession.shared.dataTask(with: imageURL) { data, _, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async { [weak cell4] in
                            cell4?.popularImage.image = image
                            cell4?.popularImage.contentMode = .scaleAspectFill
                            cell4?.popularImage.layer.cornerRadius = 50
                            cell4?.popularImage.layer.opacity = 0.8
                        }
                    }
                }.resume()
            }
            return cell4!
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.mainCollectionView{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        } else if collectionView == self.theaterCollectionView{
            return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height)
        } else if collectionView == self.newsCollectionView {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height / 2)
        } else {
            return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.mainCollectionView{
            let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
            mainPageController.currentPage = Int(pageIndex)
        }
            
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueToDetailView", sender: indexPath)
    }
    
}

