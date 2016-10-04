//
//  ViewController.swift
//  SwiftCalcPhone
//
//  Created by артем on 01.10.16.
//  Copyright © 2016 артем. All rights reserved.
//

import UIKit

var firstValue:Double = 0
var secondValue:Double = 0
var operChoice:Int64 = -1
var activeValue = 1

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func digit(_ sender: AnyObject) {
        firstValue *= 10
        firstValue += Double(sender.tag)
        self.result.text = String(Int64(firstValue))
    }
    func printRes(Value:Double) -> Void {
        if ( Value.truncatingRemainder(dividingBy: 1.0) == 0){
            self.result.text = String(Int64(Value))
        } else {
            self.result.text = String(Value)
        }
    }
    
    @IBAction func operation(_ sender: AnyObject) {
        self.result.text = String(Int64(secondValue))
        operChoice=Int64(sender.tag)
        secondValue = firstValue // save first value
        firstValue = 0           // zeroing back
        activeValue = 2          // change № of active value
    }
    @IBAction func signChange(_ sender: AnyObject) {
        if (activeValue == 1) {
            firstValue -= 2 * firstValue
            printRes(Value: firstValue)
        }
        else {
            secondValue -= 2 * secondValue
            printRes(Value: secondValue)
        }
    }

    @IBAction func dot(_ sender: AnyObject) {
        
    }
    
    @IBAction func clear(_ sender: AnyObject) {
        self.result.text = ""
        firstValue = 0
        secondValue = 0
    }
    
    @IBAction func calculation(_ sender: AnyObject) {
        switch operChoice {
        //code include this cases because sender.tag must be int
        //inc
        case (101):
            secondValue += firstValue
        //substraction
        case (102):
            secondValue -= firstValue
        //division
        case (103):
            secondValue /= firstValue
        //multiplication
        case (104):
            secondValue *= firstValue
        //take a procent
        case (105):
            secondValue *= firstValue / 100
        default:
            break
        }
        printRes(Value:secondValue)
    }
    
    @IBOutlet weak var result: UILabel!

}

