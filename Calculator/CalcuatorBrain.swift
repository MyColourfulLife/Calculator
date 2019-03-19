//
//  CalculationBrain.swift
//  Calculator
//
//  Created by JiaShu Huang on 2019/3/19.
//  Copyright © 2019 JiaShu Huang. All rights reserved.
//

import Foundation

struct CalcuatorBrain {
    
    private enum Operation {
        case constant(Double)
        case unaryOperation((Double)->Double)
        case binaryOperation((Double,Double)->Double)
        case equals
    }
    
    private var operations:Dictionary<String,Operation> =
        ["π":Operation.constant(Double.pi),
         "e":Operation.constant(M_E),
         "√":Operation.unaryOperation(sqrt),
         "cos":Operation.unaryOperation(cos),
         "⁺∕₋":Operation.unaryOperation({-$0}),
         "+":Operation.binaryOperation({$0 + $1}),
         "-":Operation.binaryOperation({$0 - $1}),
         "÷":Operation.binaryOperation({$0 / $1}),
         "×":Operation.binaryOperation({$0 * $1}),
         "=":Operation.equals]
    
    private var accumualtor:Double?
    var result:Double? {
        get{return accumualtor}
    }
    
    mutating func performOperation(_ symbol:String) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value):
                accumualtor = value
            case .unaryOperation(let function):
                if accumualtor != nil {
                    accumualtor = function(accumualtor!)
                }
            case .binaryOperation(let f):
                if accumualtor != nil {
                    pbo = PendingBinaryOperation(function: f, firstOperand:accumualtor!)
                    accumualtor = nil
                }
            case .equals:
                performPendingBinaryOperation()
                
        }
    }
    }
    
    mutating private func performPendingBinaryOperation() {
        if pbo != nil && accumualtor != nil {
            accumualtor = pbo!.perform(with: accumualtor!)
            pbo = nil
        }
    }
    
    private var pbo:PendingBinaryOperation?
    
    private struct PendingBinaryOperation {
        let function:(Double,Double)->Double
        let firstOperand:Double
        func perform(with secondOperand:Double)->Double {
            return function(firstOperand,secondOperand)
        }
    }
        
   mutating func setOperand(_ operand:Double) {
        accumualtor = operand
    }

}
