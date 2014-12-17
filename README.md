VMNumberScrollAnimatedView
==========================

Swift port of JTNumberScrollAnimatedView

Use VMNumberScrollAnimatedView for have a nice animation for display number.
It's easy to use, easy to customize.


## Screenshots

![Example](./Screens/example.gif "Example View")

## Usage

### Basic usage

You can use `VMNumberScrollAnimatedView` like a normal view.

```Swift
@IBOutlet var animatedView:VMNumberScrollAnimatedView? = VMNumberScrollAnimatedView?()
```

You just have to call `setValue` with a NSNumber and use `startAnimation` for launch the animation.

```Swift
override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.animatedView?.textColor = UIColor.whiteColor()
        
        self.animatedView?.font = UIFont(name: "HelveticaNeue-Bold", size: 42)!
        self.animatedView?.minLenght = 3
        
    }

     @IBAction func start(){
    
        self.animatedView?.setValue(NSNumber(int: rand()%5000))
        self.animatedView?.startAnimation()
    
    }

```

### WARNING

For now the `value` must be a positive integer.

### Customization

You can easily change some properties of the animation.
Each caracter have its own `column`.

- `textColor`
- `font`
- `duration`
- `durationOffset`, delay between the end of the animation of each column
- `density`, number of characters by column for the animation
- `minLength`, you can force the minimum count of columns
- `isAscending`, the direction of the scroll

If you change one of this properties, you have to call `setValue` for update the view.

## Requirements

- iOS 7 or higher
- Automatic Reference Counting (ARC)

## Author

- Objective-C [Jonathan Tribouharet](https://github.com/jonathantribouharet) ([@johntribouharet](https://twitter.com/johntribouharet))
- Swift  Jimmy Jose (jimmy@varshyl.com)

## License

The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
