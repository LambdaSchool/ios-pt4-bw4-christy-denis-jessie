//
//  CatAnnotationDetailView.swift
//  CatCart
//
//  Created by denis cedeno on 6/25/20.
//  Copyright © 2020 CatCartCo. All rights reserved.
//

import UIKit

protocol MapDetailViewDelegate: AnyObject {
    func didPressButton(with cat: Cat)
}

class CatAnnotationDetailView: UIView {
    
    var cat: Cat? {
        didSet {
            updateSubviews()
        }
    }
    
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let yearLabel = UILabel()
    private let monthLabel = UILabel()
    private var viewImageButton = UIButton()
    private let latitudeLabel = UILabel()
    private let longitudeLabel = UILabel()
    
    weak var delegate: MapDetailViewDelegate?
    
    private lazy var latLonFormatter: NumberFormatter = {
        let result = NumberFormatter()
        result.numberStyle = .decimal
        result.minimumIntegerDigits = 1
        result.minimumFractionDigits = 2
        result.maximumFractionDigits = 2
        return result
    }()
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
        
        delegate?.didPressButton(with: cat!)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        latitudeLabel.setContentHuggingPriority(.defaultLow+1, for: .horizontal)
        
        viewImageButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        viewImageButton.backgroundColor = .blue
        viewImageButton.setTitle("View Image", for: .normal)
        viewImageButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        let placeDateStackView = UIStackView(arrangedSubviews: [nameLabel, priceLabel])
        placeDateStackView.spacing = UIStackView.spacingUseSystem
        let latLonStackView = UIStackView(arrangedSubviews: [latitudeLabel, longitudeLabel])
        latLonStackView.spacing = UIStackView.spacingUseSystem
        let mainStackView = UIStackView(arrangedSubviews: [placeDateStackView, latLonStackView])
        mainStackView.axis = .vertical
        mainStackView.spacing = UIStackView.spacingUseSystem
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainStackView)
        mainStackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        mainStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Private
    
    private func updateSubviews() {
        guard let cat = cat else { return }
        nameLabel.text = cat.name
        priceLabel.text = "\(cat.price)"
        latitudeLabel.text = "Lat: " + latLonFormatter.string(from: cat.latitude as NSNumber)!
        longitudeLabel.text = "Lon: " + latLonFormatter.string(from: cat.longitude as NSNumber)!
    }
    
}
