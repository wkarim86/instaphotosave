//
//  ViewController.swift
//  InstaPhotoSave
//
//  Created by Waqas Karim on 21/02/2018.
//  Copyright © 2018 Waqas Karim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var clipboardUrl: URL?
    var imageArray = [URL]()
    let loader: UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    var selectedIndex: Int = Int()
    var refreshControl: UIRefreshControl!
    var session: URLSession!
    var task: URLSessionDownloadTask!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(getUrl), name: Notification.Name("getUrl"), object: nil)
        
        //Setup Activity Indicator
        loader.center = view.center
        loader.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        loader.backgroundColor = UIColor.darkGray.withAlphaComponent(0.95)
        self.view.addSubview(loader)
        getUrl()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc public func getUrl(){
        showLoader()
        //assign new url from clipboard when app comes in foreground
        clipboardUrl = UIPasteboard.general.url
        
        if(clipboardUrl != nil && (clipboardUrl?.absoluteString.contains("instagram.com"))!) {
            imageArray.append((clipboardUrl)!)
            print("getUrl: \(imageArray)")
        }
        
        self.collectionView.reloadData()
        hideLoader()
    }
    
    func storeImage(index: Int){
        //download and store image in photo library
//        let alert = UIAlertController(title: "Alert", message: "URL: (/imageArray[index])", preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
//        self.present(alert, animated: true, completion: nil)
        showLoader()
        print("image url:\(imageArray[selectedIndex])")
        let imgData = try? Data(contentsOf: imageArray[selectedIndex])
        let imagetoSave = UIImage(data: imgData!)
        UIImageWriteToSavedPhotosAlbum(imagetoSave!, nil, nil, nil)
        hideLoader()
        
    }
    
    @objc func downloadImage(){
        print("SelectedIndex: \(selectedIndex)")
    }
 
    
    func showLoader(){
        loader.startAnimating()
    }
    
    func hideLoader(){
        loader.stopAnimating()
    }


}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "thumbnailView", for: indexPath) as! CustomCell
        let imageData = try? Data(contentsOf: imageArray[indexPath.row])
        cell.thumbnail.image = UIImage(data: imageData!)
        cell.instaUrl = imageArray[indexPath.row]
        selectedIndex = indexPath.row
        
        cell.downloadBtn.addTarget(self, action: #selector(downloadImage), for: UIControlEvents.touchUpInside)
        //cell.downloadBtn.addTarget(self, action: #selector(storeImage(index:indexPath.row)), for: UIControlEvents.touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        print(imageArray[indexPath.row])
    }
    
    
}

