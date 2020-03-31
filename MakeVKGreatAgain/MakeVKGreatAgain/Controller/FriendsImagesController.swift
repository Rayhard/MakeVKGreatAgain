//
//  FriendsImagesController.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 09.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit
import Kingfisher

class FriendsImagesController: UICollectionViewController {
    let getDataService: DataServiceProtocol = DataService()
    
    var friend: User!
    var profilePhoto: [Photo] = []
    
    let cache = ImageCache.default

    override func viewDidLoad() {
        super.viewDidLoad()
        let parameters: [String : Any] = [
            "owner_id" :  friend.id,
            "rev" : 1,
            "album_id" : "profile",
        ]

        
        getDataService.loadPhotos(additionalParameters: parameters) { (photo) in
            self.profilePhoto = photo
            self.collectionView.reloadData()
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profilePhoto.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FriendImagesCell
        
        if let url = URL(string: profilePhoto[indexPath.row].imageUrl){
            cell.friendImageView.kf.indicatorType = .activity
            let resource = ImageResource(downloadURL: url, cacheKey: profilePhoto[indexPath.row].imageUrl)
            cell.friendImageView.kf.setImage(with: resource)
        }

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFullScreenImages"{
            if let indexPath = collectionView.indexPathsForSelectedItems{
                (segue.destination as? AllFriendsImagesController)?.friendImagesArray = profilePhoto
                collectionView.deselectItem(at: indexPath[0], animated: true)
            }
        }
    }
}

extension FriendsImagesController {
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let view = collectionView
                .dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                  withReuseIdentifier: "CellHeader",
                                                  for: indexPath) as! HeaderFriendImagesView
            
            cache.retrieveImage(forKey: friend.photo) { result in
                switch result {
                case .success(let value):
                    view.friendAvatarImage.image = value.image

                case .failure(let error):
                    print(error)
                }
            }
            
            view.friendName.text = friend.name
            return view
        } else {
            let view = collectionView
                .dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                  withReuseIdentifier: "CellFooter",
                                                  for: indexPath) as! FooterFriendImagesView
            return view
        }
    }
}
