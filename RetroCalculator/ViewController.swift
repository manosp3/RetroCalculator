import UIKit
import AVFoundation

class ViewController: UIViewController {
    

    @IBOutlet weak var outputLbl: UILabel!
    
    
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    
    var runningNumber = ""
    
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        outputLbl.text = "0"
    
    }
    
    
    @IBAction func clearBtnPressed(_ sender: Any) {
        
        playSound()
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        result = ""
        currentOperation = Operation.Empty
        outputLbl.text = "0"
        
        
    }
    
    
    

    @IBAction func numberPressed(sender: UIButton) {
        
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
        outputLbl.textColor = UIColor.blue
        
    
    }
    
    @IBAction func onDividePressed(sender: Any){
        processOperation(operation: .Divide)
    }
    @IBAction func onMultiplyPressed(sender: Any){
        processOperation(operation: .Multiply)
    }
    @IBAction func onSubtractPressed(sender: Any){
        processOperation(operation: .Subtract)
    }
    @IBAction func onAddPressed(sender: Any){
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: Any){
        processOperation(operation: currentOperation)
    }
    
    func playSound (){
        
        
        if btnSound.isPlaying{
            btnSound.stop()
            
        }
        
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        
        playSound()
        
        if currentOperation != Operation.Empty {
            
            //A user selected an operator, but then selected another operator
            //without first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
        
            
            currentOperation = operation
        } else {
            
            //This is the first time an operator is pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        
        }
    }

}
