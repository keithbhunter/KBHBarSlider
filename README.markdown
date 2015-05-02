# KBHBarSlider

A vertical or horizontal bar slider view. Functions similarly to `UISlider`. 

![Alt text](https://github.com/keithbhunter/KBHBarSlider/blob/master/Images/Bottom-To-Top-90.png "Vertical KBHBarSlider with minimum of 30 and maximum of 100")
![Alt text](https://github.com/keithbhunter/KBHBarSlider/blob/master/Images/Left-To-Right-45.png "Horizontal KBHBarSlider with minimum of 30 and maximum of 100")

## Usage

```
// Create a UIView in the storyboard and set the class to KBHBarSlider,
// or create it in code
let barSlider = KBHBarSlider(aFrame)

barSlider.backgroundColor = .lightGrayColor()
barSlider.backgroundBarColor = .yellowColor()
barSlider.barColor = view.tintColor
barSlider.barWidth = view.frame.size.width / 2.0
barSlider.direction = .LeftToRight

barSlider.minimumValue = 30.0
barSlider.maximumValue = 100.0
barSlider.value = 50.0

barSlider.addTarget(self, action: "barSliderValueChanged:", forControlEvents: .ValueChanged)
``` 

## License

KBHBarSlider is available under the MIT license. See the LICENSE file for more info.