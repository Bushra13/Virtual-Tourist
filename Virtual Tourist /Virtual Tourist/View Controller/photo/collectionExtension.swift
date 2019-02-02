//
//  collectionExtension.swift
//  Virtual Tourist
//
//  Created by Bushra on 21/01/2019.
//  Copyright © 2019 Bushra Alkhushiban. All rights reserved.
//


import Foundation
import UIKit


extension PhotosViewController: UICollectionViewDelegate , UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return fetchedResultsController.fetchedObjects!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCollectionCell", for: indexPath) as! CollectionViewCell
        
        let photo = fetchedResultsController.object(at: indexPath)
        
        if let data = photo.imageDATA {
            cell.image.image = UIImage(data: data)
        } else {
            cell.image.image = UIImage(named: "image")
            cell.contentView.alpha = 1.0
            
            //Download Image Function
            downloadImage(imagePath: photo.photoURL!) { imageData, errorString in
                if let imageData = imageData {
                    DispatchQueue.main.async {
                        cell.image.image = UIImage(data: imageData)
                    }
                    photo.imageDATA = imageData
                    try? self.dataController.viewContext.save()
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = collectionView.cellForItem(at: indexPath)
        cell?.contentView.alpha = 0.4
        
        if selectedPhotos.contains(indexPath) == false {
            selectedPhotos.append(indexPath)
        }
        selectPhotoActionButton()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
     
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.contentView.alpha = 1.0
        
        if let index = selectedPhotos.firstIndex(of: indexPath) {
            selectedPhotos.remove(at: index)
        }
        selectPhotoActionButton()
    }
    
    
    // Selected photos action button
    func selectPhotoActionButton() {
        if hasSelectedPhotos() {
            toolBar.title = "Delete Selected Photos"
            toolBar.tintColor = .red
        }
        else {
            toolBar.title = "Update Collection"
            toolBar.tintColor = .blue
        }
    }
    
    //Function that check selected photo
    func hasSelectedPhotos() -> Bool {
        if selectedPhotos.count == 0 {
            return false
        }
        return true
    }
    
    // To Delete selected photos
    func deleteSelectedPhotos() {
        let photos = selectedPhotos.map() { fetchedResultsController.object(at: $0) }
        photos.forEach() { photo in
            dataController.viewContext.delete(photo)
            try? dataController.viewContext.save()
        }
        
        selectedPhotos.removeAll()
        selectPhotoActionButton()
    }
}

