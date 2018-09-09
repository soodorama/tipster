//
//  ViewController.swift
//  tipsterv2
//
//  Created by Neil Sood on 9/6/18.
//  Copyright © 2018 Neil Sood. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var subtotalAmount: UILabel!
    @IBOutlet var percentTitles: [UILabel]!
    @IBOutlet var tipSubtotal: [UILabel]!
    @IBOutlet var tipTotalPayment: [UILabel]!
    @IBOutlet var tipPercentageTitle: [UILabel]!
    @IBOutlet weak var tipSliderOutlet: UISlider!
    @IBOutlet weak var groupSizeLabel: UILabel!
    @IBOutlet weak var groupSizeOutlet: UISlider!
    
    var decimalPlaces = 0
    var hasDecimal = false
    var user_input = 0.0
    var tip_first = 10
    var tip_second = 15
    var tip_third = 20
    var groupsize = 1.0
    
    
    @IBAction func numberPressed(_ sender: UIButton) {
        let num = Double(sender.tag)
        if hasDecimal {
            if decimalPlaces == 0 {
                user_input += num / 10.0
                decimalPlaces += 1
            }
            else if decimalPlaces == 1 {
                user_input += num / 100.0
                decimalPlaces += 1
            }
            else {
                print("no more decimal places to add")
            }
        }
        else {
            if user_input == 0.0 {
                user_input = num
            }
            else {
                user_input *= 10.0
                user_input += num
            }
        }
        updateUserInput()
        updateTip()
    }
    
    @IBAction func zeroPressed(_ sender: UIButton) {
        if user_input == 0.0 {
            print("no need to add zero")
        }
        else if hasDecimal {
            if decimalPlaces < 2 {
                decimalPlaces += 1
            }
            else {
                print("no more decimal places to add")
            }
        }
        else {
            user_input *= 10
        }
        updateUserInput()
        updateTip()
    }
    
    @IBAction func decimalPressed(_ sender: UIButton) {
        if hasDecimal {
            print("cannot add another decimal")
        }
        else {
            hasDecimal = true
        }
        updateUserInput()
        updateTip()
    }
    
    func updateTip() {
        let first = user_input * Double(tip_first) / 100
        let second = user_input * Double(tip_second) / 100
        let third = user_input * Double(tip_third) / 100
        
        tipSubtotal[0].text = String(first / groupsize)
        tipSubtotal[1].text = String(second / groupsize)
        tipSubtotal[2].text = String(third / groupsize)
        
        tipTotalPayment[0].text = String((first + user_input) / groupsize)
        tipTotalPayment[1].text = String((second + user_input) / groupsize)
        tipTotalPayment[2].text = String((third + user_input) / groupsize)
    }
    
    func updateUserInput() {
        if !hasDecimal {
            var s_input = String(user_input)
            s_input = String(s_input.dropLast(2))
            subtotalAmount.text? = s_input
        }
        else {
            if decimalPlaces == 0 {
                var s_input = String(user_input)
                s_input = String(s_input.dropLast(2))
                subtotalAmount.text? = s_input + "."
            }
            else if decimalPlaces == 1 {
                var d_input = user_input * 100
                let i_input = Int(d_input)
                d_input = Double(i_input) / 100
                subtotalAmount.text? = String(d_input)
            }
            else if decimalPlaces == 2 {
                var d_input = user_input * 100
                let i_input = Int(d_input)
                d_input = Double(i_input) / 100
                subtotalAmount.text? = String(d_input)
            }
        }
    }

    
    @IBAction func clearPressed(_ sender: UIButton) {
        subtotalAmount.text = "0"
        user_input = 0
        hasDecimal = false
        decimalPlaces = 0
        tipSubtotal[0].text = "0.0"
        tipSubtotal[1].text = "0.0"
        tipSubtotal[2].text = "0.0"
        tipTotalPayment[0].text = "0.0"
        tipTotalPayment[1].text = "0.0"
        tipTotalPayment[2].text = "0.0"
    }
    
    @IBAction func changePercents(_ sender: UISlider) {
        let tip = Int(tipSliderOutlet.value)
        let groupSize = Int(groupSizeOutlet.value)
        
        if sender.tag == 100 {
            // tip slider changed
            tip_first = tip
            tip_second = tip + 5
            tip_third = tip + 10
            
            percentTitles[0].text = String(tip_first) + "%"
            percentTitles[1].text = String(tip_second) + "%"
            percentTitles[2].text = String(tip_third) + "%"
        }
        else if sender.tag == 101 {
            // groupsize slider changed
            groupsize = Double(groupSize)
            groupSizeLabel.text? = "GroupSize: " + String(groupSize)
        }
        else {
            print("wtf3")
        }
        
        updateTip()
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
