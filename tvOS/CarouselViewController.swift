import Foundation
import UIKit

final class ViewController: UIViewController {
    let colors: [UIColor] = [
        UIColor(red: 19.0/255.0, green: 51.0/255.0, blue: 76.0/255.0, alpha: 1.0),
        UIColor(red: 0.0/255.0, green: 87.0/255.0, blue: 46.0/255.0, alpha: 1.0),
        UIColor(red: 253.0/255.0, green: 95.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    ]
    
    let pageControl = UIPageControl()
    let collectionView = CarouselCollectionView(frame: .zero, collectionViewFlowLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        pageControl.numberOfPages = colors.count
        pageControl.tintColor = .black
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier:"id")
        collectionView.reloadData()
        collectionView.carouselDataSource = self
        collectionView.isAutoscrollEnabled = true
        collectionView.autoscrollTimeInterval = 3.0
        let size = UIScreen.main.bounds.size
        collectionView.flowLayout.itemSize = CGSize(width: size.width, height: size.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.frame = view.bounds
        pageControl.frame.origin.y = view.bounds.maxY - 80 - pageControl.frame.height
        pageControl.sizeToFit()
    }
}

extension ViewController: CarouselCollectionViewDataSource {
    var numberOfItems: Int {
        return colors.count
    }
    
    func carouselCollectionView(_ carouselCollectionView: CarouselCollectionView, cellForItemAt index: Int, fakeIndexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: fakeIndexPath)
        cell.backgroundColor = colors[index]
        return cell
    }
    
    func carouselCollectionView(_ carouselCollectionView: CarouselCollectionView, didSelectItemAt index: Int) {
        print("Did select item at \(index)")
    }
    
    func carouselCollectionView(_ carouselCollectionView: CarouselCollectionView, didDisplayItemAt index: Int) {
        pageControl.currentPage = index
    }
}
