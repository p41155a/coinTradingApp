//
//  CrypocurrencyListTableViewCell.swift
//  CryptocurrencyExchange
//
//  Created by Yoojin Park on 2022/03/01.
//

import UIKit

final class CrypocurrencyKRWListTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.currencyNameLabel.text = nil
        self.currentPriceLabel.text = nil
        self.changeRateLabel.text = nil
        self.changeAmountLabel.text = nil
        self.transactionAmountLabel.text = nil
    }
    
    func setData(data: CryptocurrencyListTableViewEntity, isInterest: Bool) {
        let currentPrice: String = "\(data.currentPrice)".setNumStringForm(isDecimalType: true)
        let changeRate: String = "\(data.changeRate.displayDecimal(to: 2).setNumStringForm(isMarkPlusMiuns: true))%"
        let changeAmount: String = "\(data.changeAmount)".setNumStringForm(isDecimalType: true, isMarkPlusMiuns: true)
        let transactionAmount: String = "\(Int(data.transactionAmount / 1000000).decimalType ?? "")백만"
        
        self.currencyNameLabel.text = data.symbol
        self.currencyNameSubNameLabel.text = data.payment.value
        self.currentPriceLabel.text = currentPrice
        self.changeRateLabel.text = changeRate
        self.changeAmountLabel.text = changeAmount
        self.transactionAmountLabel.text = transactionAmount
        self.interestButton.isSelected = isInterest
        setColor(updown: UpDown(rawValue: changeAmount.first ?? "0") ?? .zero)
    }
    
    private func setColor(updown: UpDown) {
        currentPriceLabel.textColor = updown.color
        changeRateLabel.textColor = updown.color
        changeAmountLabel.textColor = updown.color
    }
    
    @IBAction func interestButtonTap(_ sender: StarButton) {
        sender.isSelected.toggle()
        guard let currencyName = self.currencyNameLabel.text else {
            return
        }
        delegate?.setInterestData(
            interest: InterestCurrency(
                currency: "\(currencyName)_KRW",
                interest: interestButton.isSelected
            )
        )
    }
    
    // MARK: - Property
    weak var delegate: CrypocurrencyListTableViewCellDelegate?
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var currencyNameSubNameLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var changeRateLabel: UILabel!
    @IBOutlet weak var changeAmountLabel: UILabel!
    @IBOutlet weak var transactionAmountLabel: UILabel!
    @IBOutlet weak var interestButton: StarButton!
}
