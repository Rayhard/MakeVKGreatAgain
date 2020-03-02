//
//  FriendsImagesController.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 09.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FriendsImagesController: UICollectionViewController {
    
    var friendImagesArray: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friendImagesArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FriendImagesCell

        cell.friendImageView.image = friendImagesArray[indexPath.row]

        return cell
    }
}

extension FriendsImagesController {
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let view = collectionView
                .dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                  withReuseIdentifier: "id1",
                                                  for: indexPath)
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
