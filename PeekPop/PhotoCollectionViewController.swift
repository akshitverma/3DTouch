//
//  PhotoCollectionViewController.swift
//  PeekPop
//
//  Created by Akshit Verma
//

import UIKit

private let reuseIdentifier = "photoCell"

class PhotoCollectionViewController: UICollectionViewController, UIViewControllerPreviewingDelegate {
    
    // Properties
    var photos: [Photo] = {
        
        return [
            Photo(caption: "Lovely piece of art", imageName: "bordeaux", city: "City 1"),
            Photo(caption: "Cosy lake beach", imageName: "lake", city: "City 2"),
            Photo(caption: "Harbour", imageName: "harbour", city: "City 3"),
            Photo(caption: "Buda beach", imageName: "buda", city: "City 4")
        ]
        
    }()
    
    // Lifecycle methods    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        //Checking availibility of 3D- Touch
        if( traitCollection.forceTouchCapability == .available) {
            
            registerForPreviewing(with: self, sourceView: view)
            
        }
        
    }
    
    //Segue to DetailView
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if( segue.identifier == "sgPhotoDetail" ){
            
            let photo = photos[(self.collectionView?.indexPathsForSelectedItems?[0].row)!]    //  (self.collectionView?.indexPathsForSelectedItems![0].row)!]indexPathsForSelectedItems
            
            let vc = segue.destination as! DetailViewController
            vc.photo = photo
            
        }
    }
    
    
    // MARK: UICollectionViewDataSource methods
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
        
    }
    
    //cellForUtemAt Here----
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
       
        //  Configure the cell
        let photo = photos[indexPath.row]
        
        if let image = UIImage(named: photo.imageName) {
            
            cell.imageView.image = image
            
        }else {
            cell.imageView.image = UIImage(named: "image-not-found")
        }
        return cell
    }
    
    
    
    // MARK: Trait collection delegate methods
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
    }
    
    // MARK: UIViewControllerPreviewingDelegate methods
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = collectionView?.indexPathForItem(at: location) else { return nil }
        
        guard let cell = collectionView?.cellForItem(at: indexPath) else { return nil }
        
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return nil }
        
        let photo = photos[indexPath.row]
        detailVC.photo = photo
        
        detailVC.preferredContentSize = CGSize(width: 0.0, height: 300)
        
        previewingContext.sourceRect = cell.frame
        
        return detailVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        show(viewControllerToCommit, sender: self)
        
    }
    
}
