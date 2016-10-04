//
//  ViewController.swift
//  SwiftCalcPhone
//
//  Created by артем on 01.10.16.
//  Copyright © 2016 артем. All rights reserved.
//

import UIKit
import Darwin

var firstValue:Double = 0
var secondValue:Double = 0
var afterDatCount:Double = 0
var operChoice:Int64 = -1
var activeValue = 1
var checkActiveOperation:Bool = false
var isFirstOperation:Bool = true
var afterCalc:Bool = false


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //my funcs
    func checkDat(Value:Double) -> Bool {
        if (Value.truncatingRemainder(dividingBy: 1.0) == 0) { return true }
        else { return false }
    }
    
    func changeActiveValue () -> Void {
        if (activeValue == 1) {
            activeValue = 2
            afterDatCount = 0
        } else {
            activeValue = 1;
        }
    }
    
    func printRes(Value:Double) -> Void {
        if ( Value.truncatingRemainder(dividingBy: 1.0) == 0){
            self.result.text = String(Int64(Value))
        } else {
            self.result.text = String(Value)
        }
    }
    
    func checkValue(Value:Double) -> Bool {
        if (abs(Value) >= 999999999){
            return false
        }
        else {
            if (Value==0) {
                return true
            }
            else {
                if (abs(Value)<=0.00000001) {
                    return false
                }
                else {
                    return true
                }
            }
            
        }
    }
    
    func makeOperation() ->Void {
            switch operChoice { //code include this cases because sender.tag must be int
            
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
                secondValue *= (firstValue / 100)
            default:
                break
            }
            printRes(Value:secondValue)
            changeActiveValue()
            checkActiveOperation = false
            afterCalc = true
    }
    
    //action
    @IBAction func digit(_ sender: AnyObject) {
        if (afterCalc) {
            firstValue = 0
            secondValue = 0
            afterCalc  = false
            isFirstOperation = true
        }
        if (afterDatCount != 0) { // when number has a fraction
            if (checkValue(Value:firstValue) ){
                firstValue += Double(sender.tag)/pow(10,afterDatCount)
                afterDatCount += 1
                printRes(Value: firstValue)
            }
        }
            
        else {                    // Simple value without fraction
            if (checkValue(Value:firstValue) ){
                firstValue *= 10
                firstValue += Double(sender.tag)
                printRes(Value: firstValue)
            }
        }
    }
    
    @IBAction func operation(_ sender: AnyObject) {
        if (checkValue(Value: secondValue) ) {
            if(checkActiveOperation) {   // reactive operation button
                makeOperation()
            } else {                    // simple active operation button
                checkActiveOperation=true
                printRes(Value: secondValue)
                if (isFirstOperation) {
                    isFirstOperation = false
                    secondValue = firstValue // save first value
                }
            }
            operChoice=Int64(sender.tag)
            firstValue = 0           // zeroing back
            changeActiveValue()      // change № of active value
        
        }
    }
   
    @IBAction func calculation(_ sender: AnyObject) {
        if (checkValue(Value: secondValue) ) {
            makeOperation()
        }
    }
    
    
    @IBAction func dot(_ sender: AnyObject) {
        if (checkDat(Value:firstValue) ) {
            afterDatCount = 1  // mark appearance of dat
        }
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
    
    @IBAction func clear(_ sender: AnyObject) {
        self.result.text = ""
        firstValue = 0
        secondValue = 0
        afterDatCount = 0
        isFirstOperation = true
    }
    
    //outlets
    @IBOutlet weak var result: UILabel!

}
