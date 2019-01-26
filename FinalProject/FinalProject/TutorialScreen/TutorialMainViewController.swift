//
//  TutorialMainViewController.swift
//  FinalProject
//
//  Created by Shkolnyk Leonid on 12/12/18.
//  Copyright © 2018 Shkolnyk Leonid. All rights reserved.
//

import Foundation
import UIKit

class TutorialMainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var button: UIButton!
    
    enum TutorialPage {
        case first
        case second
        case third
        
        var title: String {
            switch self {
            case .first:
                return "Заощаджуйте кошти"
            case .second:
                return "Заробляйте"
            case .third:
                return "Аналізуйте"
            }
        }
        
        var description: String {
            switch self {
            case .first:
                return "Переглядайте інформацію щодо банківських курсів та вибирайте оптимальний варіант"
            case .second:
                return "Отримайте вигідний відсоток з вигідним вкладом"
            case .third:
                return "Повна інформація про грошові курси та банки"
            }
        }
        
        var imageName: String {
            switch self {
            case .first:
                return "piggy-bank"
            case .second:
                return "money"
            case .third:
                return "analysis"
            }
        }
    }
    
    var pages = [TutorialPage.first, .second, .third]
    @IBOutlet weak var coinBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInterface()
        button.layer.cornerRadius = button.frame.height / 2
    }
    
    private func configureInterface() {
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        
        let nib = UINib(nibName: "TutorialCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "TutorialCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            collectionView.collectionViewLayout.invalidateLayout()
        } else {
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MainScreen", bundle: nil)
        let mainScreen = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        navigationController?.setViewControllers([mainScreen], animated: true)
        UserDefaults.standard.set(true, forKey: "tutorialWasShown")
    }
}

// MARK: - UICollectionViewDataSource
extension TutorialMainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TutorialCollectionViewCell", for: indexPath) as! TutorialCollectionViewCell
        let page = pages[indexPath.item]
        cell.tutorialTitle.text = page.title
        cell.tutorialDescription.text = page.description
        cell.tutorialImageView.image = UIImage(named: page.imageName)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TutorialMainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return collectionView.bounds.size
    }
}

// MARK: - UIScrollViewDelegate
extension TutorialMainViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x
        let page = Int(offset / scrollView.bounds.width)
        pageControl.currentPage = page
        UIView.animate(withDuration: 0.05) {
            self.coinBottomConstraint.constant = CGFloat((page * 80) - 240)
            self.view.layoutIfNeeded()
        }
    }
}
