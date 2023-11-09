import UIKit

class CustomUnderlineTextField: UITextField {
    
    public var placeh : String? {
        didSet {
            guard let placeh = placeh else {return}
            self.placeholder = placeh
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        self.borderStyle = .none // Remove the default border style
        self.backgroundColor = UIColor.clear // Set background color to clear
    }

    override func draw(_ rect: CGRect) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor // Set your desired underline color
        self.layer.addSublayer(bottomLine)
    }
}
