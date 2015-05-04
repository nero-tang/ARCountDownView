# ARCountDownView
A simple animated countdown timer view written in Swift.

![](https://github.com/nero-tang/ARCountDownView/blob/master/Screenshots/ARCountDownViewDemo.gif)


## Installation

Drag the source file `ARCountDownView/ARCountDownView.swift` into your project.


## Customization

ARCountDownView can be customized in numerous way:

```swift
/// Time to countdown, in second
var duration: UInt! 

/// Color of central text
var textColor: UIColor! 

/// Font of central text
var font: UIFont! 

/// Color of the animated ring
var strokeColor: UIColor! 
```

ARCountDownView also supports delegation:
```swift
protocol ARCountDownViewDelegate: class {
    
    /**
    Delegate method when every second passed
    
    :param: countDownView countDownView
    :param: second        total second elapsed since start
    :param: flag          Did finish flag
    */
    func countDownView(countDownView: ARCountDownView, timeElapsed second: UInt, didFinish flag: Bool)
}
```

## LICENSE
Copyright (c) 2015 Yufei Tang

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

