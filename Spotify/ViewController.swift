//
//  ViewController.swift
//  Spotify
//
//  Created by Mehmet Eroğlu on 22.03.2017.
//  Copyright © 2017 Mehmet Eroğlu. All rights reserved.
//

import UIKit
import Alamofire

struct post {
    let mainImage : UIImage!
    let name : String!
}

class TableViewController: UITableViewController {

    var posts = [post]()
    
    var searchURL = "https://api.spotify.com/v1/search?q=Shawn+Mendes&type=track"
    typealias JSONStandard = [String : AnyObject]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        callAlamo(url: searchURL)
    }

    func callAlamo (url : String){
        Alamofire.request(url).responseJSON(completionHandler: {
            
            response in
            self.parseData(JSONData: response.data!)
            
        })
    }
    
    func parseData (JSONData: Data){
        do {
            let readableJSON = try JSONSerialization.jsonObject(with: JSONData, options: .mutableContainers) as! JSONStandard
            if let tracks = readableJSON["tracks"] as? JSONStandard {
                if let items = tracks["items"]{
                    for i in 0..<items.count{
                        let item = items[i] as! JSONStandard
                        print(item)
                        let name = item["name"] as! String
                        
                        if let album = item["album"] as? JSONStandard{
                            if let images = album["images"] as? [JSONStandard] {
                                let imageData = images[0]
                                let mainImageURL = URL(string: imageData["url"] as! String)
                                let mainImageData = NSData(contentsOf: mainImageURL!)
                                let mainImage = UIImage(data: mainImageData as! Data)
                                
                                posts.append(post.init(mainImage: mainImage, name: name))
                                
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
        catch {
            print(error)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        let mainImageView = cell?.viewWithTag(2) as! UIImageView
        mainImageView.image = posts[indexPath.row].mainImage
        let mainLabel = cell?.viewWithTag(1) as! UILabel
        mainLabel.text = posts[indexPath.row].name
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = self.tableView.indexPathForSelectedRow?.row
        
        let vc = segue.destination as! AudioVC
        
        vc.image = posts[indexPath!].mainImage
        vc.mainSongTitle = posts[indexPath!].name
    }
}

