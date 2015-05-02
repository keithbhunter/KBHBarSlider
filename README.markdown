# KBHBarSlider

A vertical bar slider view. Functions similarly to `UISlider`. 

![Alt text](https://github.com/keithbhunter/KBHBarSlider/blob/master/Images/10-Percent.png "KBHBarSlider at 10%")![Alt text](https://github.com/keithbhunter/KBHBarSlider/blob/master/Images/35-Percent.png "KBHBarSlider at 35%")![Alt text](https://github.com/keithbhunter/KBHBarSlider/blob/master/Images/80-Percent.png "KBHBarSlider at 80%")

## Usage

```
// Create a UIView in the storyboard and set the class to KBHBarSlider, or create it in code
let barSlider = KBHBarSlider(aFrame)
barSlider.barColor = self.view.tintColor
self.barSlider.addTarget(self, action: "aMethod", forControlEvents: .ValueChanged)
``` 