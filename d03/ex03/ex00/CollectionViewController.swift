//
//  CollectionViewController.swift
//  ex00
//
//  Created by Melkozavr on 16.03.2020.
//  Copyright © 2020 Melkozavr. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    @IBOutlet var imageCollectionView: UICollectionView!
    
    let imagesArr : [URL] = [
        URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/florence.jpeg")!,
        URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/45025340661_7b9f8f9402_k.jpg")!,
        URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/8.22-396o5017lane.jpg")!,
        URL(string: "https://www.nasa.gov/sites/default/files/thumbnails/image/43656168861_3c30e55b14_o.jpg")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imagesArr.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageCollectionViewCell
        let imgUrl = imagesArr[indexPath.row]
        
        DispatchQueue.global().async {
            //UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let imgData = try? Data(contentsOf: imgUrl)
            if imgData == nil {
                let urlName = self.imagesArr[indexPath.row]
                
                let alert = UIAlertController(title: "Error", message: "Cannot acces to \(urlName)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                //UIApplication.shared.isNetworkActivityIndicatorVisible = false
            } else {
                //UIApplication.shared.isNetworkActivityIndicatorVisible = false
                DispatchQueue.main.async {
                    cell.loader.hidesWhenStopped = true
                    cell.loader.stopAnimating()
                    cell.imageView.image = UIImage(data: imgData!)
                }
            }
        }
        
        cell.loader.startAnimating()
        cell.loader.color = (UIColor.white)
        cell.layer.borderColor = (UIColor.black.cgColor)
        cell.layer.backgroundColor = (UIColor.black.cgColor)
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
        // Configure the cell
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let seg = segue.destination as! ViewController
        let cell = sender! as! ImageCollectionViewCell
        if cell.imageView.image == nil {
            let alertController = UIAlertController(title: "Error", message: "Cannot acces to this image", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        } else {
            seg.image = cell.imageView.image!
        }
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
