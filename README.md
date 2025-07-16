# zweyWalker

A Flutter mobile application for controlling a spider robot via Bluetooth using the HC-05 module. The app features a web-style touch controller interface, sending directional commands to the robot based on user interaction. It is built with a forked version of the flutter_blue_serial package for Bluetooth communication and is specially designed for a spider robot project

Features

- Bluetooth Control: Easily connect to and control HC-05 Bluetooth modules.

- Intuitive Web Controller: Touch-based controller inspired by a spider web layout.

- Pre-defined Commands: Sends commands like F, FT, FL, B, BT, BL, R, L corresponding to directional movement or actions.

- Flutter UI: Modern, clean user interface.

## Getting Started

Prerequisites

- Flutter SDK installed on your development environment.

- A device with Bluetooth capability.

- Hardware: HC-05 Bluetooth module connected to a spider robot.


Installation

1. Clone the Repository

bash

    git clone https://github.com/Zweycinder/zweyWalker.git
    cd zweyWalker

2. Install Dependencies

        flutter pub get

3. Connect Your Device

        Connect your Android (or supported) device via USB and make sure developer mode is enabled.

4. Run the App

        flutter run

Usage

- Open the app on your mobile device.

- Connect to the HC-05 Bluetooth module.

- Use the web-style controller to send movement commands to the spider robot. Each touch direction sends a specific letter command:

    - F - Forward

    - FT - Forward-Right/Top

    - FL - Forward-Left

    - B - Backward

    - BT - Backward-Right/Top

    - BL - Backward-Left

    - R - Right

    - L - Left

Project Structure

- lib/ - Main application code.

- pubspec.yaml - Project dependencies and metadata.

Customization

- To modify or expand command structure, update the relevant touch mapping logic in the controller widget.

- To customize the Bluetooth logic or use a different module, refer to the forked flutter_blue_serial package implementation.

License

- This project is licensed under the MIT License.

Acknowledgments

- Thanks to the developers of the flutter_blue_serial package and the open-source Flutter community.
