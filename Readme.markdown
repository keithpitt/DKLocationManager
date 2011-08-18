# DKLocationManager

DKLocationManager is a wrapper around CLLocationManager that allows for
location stubbing and usage via blocks.

It is used in the apps written by [Mostly Disco](http://www.mostlydisco.com)

## Installation

Copy the files into to your project folder, and add them to your Xcode project.

You will also need to add "CoreLocation" as a Framework to your project.

## Usage

1. Include [DKLocationManager.h][] somewhere in application

2. Create an instance of the DKLocationManager class:

        DKLocationManager * locationManager = [[DKLocationManager alloc] init];

3. At the time of writing, CLLocationManager doesn't quite work under
   Lion in the iPhone simulator. Here is a way of using the stubbing
   feature of DKLocationManager to stub out the location request:

        #if TARGET_IPHONE_SIMULATOR
          CLLocation * stubbedLocation = [[CLLocation alloc] initWithLatitude:-31.950524 longitude:115.835825];
          locationManager.stubbedLocation = stubbedLocation;
          [stubbedLocation release];
        #endif

4. Add your callbacks:

        locationManager.locationUpdatedBlock = ^(CLLocation * location) {

          NSLog(@"Location change to: %@", location);

        }

        locationManager.locationErrorBlock = ^(NSError * error) {

          NSString * errorMessage;

          switch ([error code]) {

            case kCLErrorLocationUnknown:
              errorMessage =
              NSLocalizedString(@"We could not determine your location. Please try again later.", nil);
              break;

            case kCLErrorDenied:
              errorMessage =
              NSLocalizedString(@"We could not access your current location.", nil);
              break;

            default:
              errorMessage =
              NSLocalizedString(@"An unexpected error occured when trying to determine your location.", nil);
              break;

          }

          NSLog(@"Error: %@", errorMessage);

        };

5. When you're ready to start finding the users location:

        [locationManager findLocation];

6. And, don't forget to release at the end:

        [locationManager release];

## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Send me a pull request. Bonus points for topic branches.

## Contributers

* [Keith Pitt](http://www.keithpitt.com)
* [Mario Visic](http://www.mariovisic.com)

## License

DKLocationManager is licensed under the MIT License:

  Copyright (c) 2011 Keith Pitt (http://www.keithpitt.com/)

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.

[DKLocationManager.h]: https://github.com/keithpitt/DKLocationManager/blob/master/DKLocationManager.h
