//Recursive multiplication using karatsuba algorithm
// x = 10^n/2 * a + b
// y = 10^n/2 * c + d
// x * y = 10^n * ac + 10^(n/2) (ad+bc) + bd
// where (ad+bc) = (a+b)(c+d) - ac - bd


import UIKit

struct KaratsubaConstants {
    static let minLength = 1000
}

extension Int {
    var array: [Int] {
        return description.characters.map{Int(String($0)) ?? 0}
    }
}

func karatsuba(a: Int, b: Int) -> Double{
    var result: Double = 0
    if (a < KaratsubaConstants.minLength) || (b < KaratsubaConstants.minLength) {
        result = Double(a * b)
    } else {
         var aArray: [Int]? = [a].flatMap{$0.array}
         var bArray: [Int]? = [b].flatMap{$0.array}
        
         let n = max(aArray!.count,bArray!.count)
         let n2 = n/2
        
         var aHigh = 0
         var aLow = 0
         var bHigh = 0
         var bLow = 0
        
        if let aHighArray = aArray?[0...(n2-1)]{
            aHigh = getIntFromArray(aHighArray)
        }
        
        if let aLowArray = aArray?[n2...n-1]{
            aLow = getIntFromArray(aLowArray)
        }
        
        if let bHighArray = bArray?[0...(n2-1)]{
            bHigh = getIntFromArray(bHighArray)
        }
        
        if let bLowArray = bArray?[n2...n-1]{
            bLow = getIntFromArray(bLowArray)
        }
    
        
        let z0 = Double(karatsuba(aHigh,b: bHigh))
        
        let z1 = Double(karatsuba((aHigh + aLow),b:(bHigh+bLow)))
        let z2 = Double(karatsuba(aLow,b: bLow))
        let z3 = Double(z1-z0-z2)
        return pow(Double(10),Double(n))*z0+pow(Double(10),Double(n2))*z3+z2
    }
    
    return result
}


func getIntFromArray(digitsArray: ArraySlice <Int>) -> Int {
    var digit: Int = 0
    for (_, element) in digitsArray.enumerate() {
        digit = 10 * digit + element
    }
    return digit
}



karatsuba(1234, b: 5678)
//7006652

assert(karatsuba(5, b: 5) == 25, "small numbers")
assert((karatsuba(2, b: 21) == 42), "different size small numbers")
assert(karatsuba(103, b: 3097) == 318991, "different size numbers")
assert(karatsuba(50, b: 50) == 2500, "two digits simple numbers")
assert(karatsuba(19, b: 21) == 399, "two digits numbers")
assert(karatsuba(500, b: 500) == 250000, "three digits simple numbers")
assert(karatsuba(223, b: 321) == 71583, "three digits")
assert(karatsuba(1234, b: 4321) == 5332114, "four digits")


