//
//  ViewController.swift
//  BaitapJSON
//
//  Created by trinh truong vu on 6/20/18.
//  Copyright © 2018 TRUONGVU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var tuongs : [tuongInfo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let fileUrl = Bundle.main.url(forResource: "lolJson", withExtension: "json")
        if let fileUrl = fileUrl,
        let fileData = try? Data.init(contentsOf: fileUrl),
        let jsonArray = try? JSONSerialization.jsonObject(with: fileData, options: .mutableLeaves) as? [[String: Any]]
        {
            for json in jsonArray! {
                let name = json["name"] as? String ?? ""
                let nickname = json["nickname"] as? String ?? ""
                let address = json["address"] as? String ?? ""
                let url = json["url"] as? String ?? ""
                let tieudiemUrl = json["tieudiemUrl"] as? String ?? ""
                let tuong = tuongInfo(name: name, nickname: nickname, address: address, url: url, tieudiemUrl: tieudiemUrl)
                tuongs.append(tuong)
        }
            tableview.reloadData()
    }

    }
}
extension ViewController : UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tuongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "TuongTableViewCell", for: indexPath) as! TuongTableViewCell
        let tuong = tuongs[indexPath.row]
        cell.bindingUi(tuong)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 385
    }

}
