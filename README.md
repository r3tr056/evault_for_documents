
# Vultair - Mobile Forensics Automation Tool

## Overview

**Vultair** is a cutting-edge mobile forensics tool designed for automated data extraction from Android apps. By leveraging Android Accessibility services and ADB (Android Debug Bridge), **Vultair** automates app navigation, input events, and collects forensic data for investigation purposes. The tool is ideal for law enforcement, cybersecurity experts, and digital forensics professionals needing efficient and reliable access to mobile data.

---

## Key Features

- **Accessibility Service for Automation**:
  - Uses Android Accessibility service to automate input actions (taps, swipes, typing) and navigate through social media, messaging, and other apps on the target device.
  
- **Android-Desktop Communication via ADB**:
  - Connect the target Android device to the investigator’s computer, and Vultair uses **ADB** for enhanced control and communication between the device and computer.
  
- **Remote Forensics**:
  - Automate the process of opening apps, scrolling through timelines, messages, and capturing screenshots without physical interaction.
  
- **App-Specific Automation**:
  - Navigate through specific apps such as **Facebook**, **Instagram**, **WhatsApp**, **Telegram**, etc., to collect relevant data for forensic analysis.

- **Data Collection and Documentation**:
  - Capture screenshots, document interactions, and organize extracted data for easy review and reporting.

- **Cross-Platform**:
  - Vultair works on both Android (via the app) and Windows desktops (for control and data storage).

---

## How It Works

1. **Install Vultair on Android**:
   - The Vultair Android app uses Accessibility services to automate inputs (taps, swipes, typing) and interact with apps installed on the device.
   
2. **Connect Android to Investigator's Computer**:
   - Using **ADB (Android Debug Bridge)**, connect the Android device to the investigator’s computer to allow remote commands and enhanced forensic control.

3. **Automated App Navigation**:
   - Vultair automates the process of opening target apps, navigating through timelines, retrieving posts, messages, and taking screenshots for documentation.

4. **Capture and Save Data**:
   - Data collected through the Accessibility service and ADB is captured and saved on the investigator's machine for further analysis. Vultair organizes this data into structured reports.

---

## Installation

### Android (Target Device)
1. Download and install the **Vultair APK** on the Android device.
2. Enable **Accessibility Service** for the app in system settings.
3. Enable **Developer Options** and **USB Debugging** on the Android device.

### Windows (Investigator’s Computer)
1. Clone the repository:
    ```bash
    git clone https://github.com/r3tr056/vultair.git
    cd vultair
    ```

2. Install ADB if not already installed:
    - Download from [ADB installation guide](https://developer.android.com/studio/command-line/adb).

3. Install dependencies and run the tool:
    ```bash
    npm install
    npm start
    ```

4. Connect the Android device via USB to the investigator's computer.

---

## Usage

1. **Launch the Vultair Android App** and ensure the Accessibility Service is active.
2. **Connect the Android device** to your computer using ADB.
3. **Run Vultair** on the investigator’s computer and initiate data collection commands.
4. The app will begin automating navigation and input actions on the target device.
5. **Screenshots and data** will be captured and organized on the investigator’s computer.

---

## Legal Disclaimer

**Vultair** is intended for use in lawful investigations only. Unauthorized access to digital devices or accounts without proper consent or legal authorization may violate local laws, including data privacy regulations. Ensure compliance with all applicable laws and regulations.

---

## Contributing

Contributions are welcome! Fork this repository and submit a pull request with improvements or new features.

---

## Contact

For questions or issues, reach out to [Ankur Debnath](dangerankur56@hotmail.com).

---