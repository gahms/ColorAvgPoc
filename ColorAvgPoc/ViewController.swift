//
//  ViewController.swift
//  ColorAvgPoc
//
//  Created by Nicolai Henriksen on 10/04/2021.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {
    let imageNames: [String] = [
        "header_alumni.jpg",
        "header_bookmarks.jpg",
        "header_education.jpg",
        "header_events.jpg",
        "header_matchmaker.jpg",
        "header_news.jpg",
        "header_podcast.jpg",
        "header_podcast_preview.jpg",
        "header_projectlibary.jpg",
        "header_research.jpg",
    ]
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let layout = collectionView.collectionViewLayout
        if let flowLayout = layout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(
                width: collectionView.widestCellWidth,
                // Make the height a reasonable estimate to
                // ensure the scroll bar remains smooth
                height: 200
            )
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderImageCell", for: indexPath) as! HeaderImageCell
        /*
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = UIImage(named: imageNames[indexPath.item])
         */
        let img = UIImage(named: imageNames[indexPath.item])!
        cell.imageView.image = img
        cell.textLabel.text = imageNames[indexPath.item] + "\n" + imageNames[indexPath.item]
        cell.bgColor = img.findAverageColor()!
        cell.textBackgroundView.backgroundColor = UIColor.clear
        //cell.textBackgroundView.backgroundColor = cell.bgColor
        
        return cell
    }
}

// ref: https://www.advancedswift.com/autosizing-full-width-cells/
extension UICollectionView {
    var widestCellWidth: CGFloat {
        let insets = contentInset.left + contentInset.right
        return bounds.width - insets
    }
}
