//
//  CustomItemForCollectionView.swift
//  Calculator
//
//  Created by Ashot Hovhannisyan on 05.08.23.
//

import UIKit

extension CalculatorItemView {
    
    func getTheLabeltext() -> String {
        return self.itemFromEnum.rawValue
    }
    
    func setLabelSign(sign:String) {
        self.labelForSign.text = sign
        self.itemFromEnum = OperandsOperatorsBracesAndSigns(rawValue: sign)
    }
    
    func setLabelsTextColor(color:UIColor) {
        self.labelForSign.textColor = color
    }
    
    func labelFontSize(size:CGFloat) {
        self.labelForSign.font = .systemFont(ofSize: size)
    }
}

final class CalculatorItemView: UICollectionViewCell {
    
    var staticAnimationPerformance: Bool = false {
        didSet {
            switch !oldValue {
            case true:
                UIView.animate(withDuration: 0.2) {
                    self.backgroundColor = .white
                    self.labelForSign.textColor = .black
                }
            case false:
                UIView.animate(withDuration: 0.2) {
                    self.backgroundColor = .orange
                    self.labelForSign.textColor = .white
                }
            }
        }
    }
    
    private var itemFromEnum:OperandsOperatorsBracesAndSigns!
    
    private let labelForSign:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuarer()
    }
   
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configuarer()
    }
    
    private func configuarer() {
        self.clipsToBounds = true
        self.labelForSign.font = .systemFont(ofSize: 20)
        self.contentView.addSubview(labelForSign)
        NSLayoutConstraint.activate([
            labelForSign.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            labelForSign.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
