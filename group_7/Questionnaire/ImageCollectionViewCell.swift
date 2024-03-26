//
//  ImageCollectionViewCell.swift
//  group_7
//
//  Created by 李长鸿 on 29/02/2024.
//

import UIKit

 
class ImageCollectionViewCell: UICollectionViewCell {

   override init(frame: CGRect) {
       super.init(frame: frame)
       self.myImageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
       self.contentView.backgroundColor = .clear
       self.contentView.addSubview(self.myImageView)
       
       // 设置cell的图片
       self.myImageView.contentMode = .scaleAspectFit
       self.myImageView.backgroundColor = .clear
       
   }
    
    var imgUrl: String {
        get {
            return ""
        }
        set {
            self.myImageView.sd_setImage(with: URL(string: newValue), placeholderImage: UIImage(named: "1"))
        }
    }

   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    
   var myImageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
   
}
