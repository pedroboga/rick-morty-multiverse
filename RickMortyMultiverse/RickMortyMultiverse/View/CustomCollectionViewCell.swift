//
//  CustomCollectionViewCell.swift
//  RickMortyMultiverse
//
//  Created by Pedro Boga on 01/10/21.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    static let identifier = "CustomCollectionViewCell"
    
    //var cellLabel: UILabel!
    var cellAvatar: UIImageView = {
        let image = UIImageView()
        //image.layer.cornerRadius = 12
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        cellAvatar.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //cellAvatar = nil
    }
    
    private func configure(){
        //cellLabel.textAlignment = .center
        cellAvatar.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(cellAvatar)
        
    }
    
}
