//
//  FriendsImagesController.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 09.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

class FriendsImagesController: UICollectionViewController {
    
    var friend: User!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4//friend.images.count > 4 ? 4 : friend.images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FriendImagesCell

        //cell.friendImageView.image = friend.images[indexPath.row]

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToFullScreenImages"{
//            if let indexPath = collectionView.indexPathsForSelectedItems{
//                (segue.destination as? AllFriendsImagesController)?.friendImagesArray = friend.images
//                collectionView.deselectItem(at: indexPath[0], animated: true)
//            }
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
            //view.friendAvatarImage.image = friend.images[0]
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
