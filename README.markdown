# KBHBarSlider

A vertical or horizontal bar slider view. Functions similarly to `UISlider`. 

![Alt text](https://github.com/keithbhunter/KBHBarSlider/blob/master/Images/BottomToTop.gif "Vertical KBHBarSlider with minimum of 0 and maximum of 100")
![Alt text](https://github.com/keithbhunter/KBHBarSlider/blob/master/Images/LeftToRight.gif "Horizontal KBHBarSlider with minimum of 0 and maximum of 100")

## Usage

```
// Create a UIView in the storyboard and set the class to KBHBarSlider,
// or create it in code
let barSlider = KBHBarSlider(aFrame)

barSlider.backgroundColor = .lightGrayColor()
barSlider.backgroundBarColor = .cyanColor()
barSlider.barColor = .magentaColor()
barSlider.barWidth = aWidth
barSlider.direction = .BottomToTop
barSlider.alignment = .Center

barSlider.minimumValue = 0
barSlider.maximumValue = 100
barSlider.value = 50

barSlider.addTarget(self, action: "barSliderValueChanged:", forControlEvents: .ValueChanged)
``` 

## License

KBHBarSlider is available under the MIT license. See the LICENSE file for more info.