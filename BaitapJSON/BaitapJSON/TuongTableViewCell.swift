//
//  TuongTableViewCell.swift
//  BaitapJSON
//
//  Created by trinh truong vu on 6/20/18.
//  Copyright © 2018 TRUONGVU. All rights reserved.
//

import UIKit

class TuongTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLable : UILabel!
    @IBOutlet weak var nicknameLable : UILabel!
    @IBOutlet weak var addressLable : UILabel!
    @IBOutlet weak var tuongImg : UIImageView!
    @IBOutlet weak var tuongWebview : UIWebView!
    var task: URLSessionTask?
    func bindingUi (_ tuong : tuongInfo){
        nameLable.text = tuong.name
        nicknameLable.text = tuong.nickname
        addressLable.text = tuong.address
        
        
        guard let url = URL(string: tuong.url) else
        {
            return
            
        }
        self.task =  URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let data = data,
                let image = UIImage(data: data) {
                // refresh collection
                DispatchQueue.main.async {
                    self.tuongImg.image = image
                }
            }
        }
        
        if let tieudiemUrl = URL(string: tuong.tieudiemUrl) {
            let req:URLRequest = URLRequest(url: tieudiemUrl)
            tuongWebview.loadRequest(req)
        }
  
        task?.resume()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.task?.cancel()
    }
    

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
