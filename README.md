# Title

**Type:** Master's Thesis

**Author:** Yi Lei Jiang

**Supervisor:** N/A

**1st Examiner:** Dr. Alona Zharova

**2nd Examiner:** Prof. Dr. Stefan Lessmann


## Table of Content

- [Summary](#summary)
- [Working with the repo](#Working-with-the-repo)
    - [Dependencies](#Dependencies)
    - [Setup](#Setup)
- [Reproducing results](#Reproducing-results)
- [Results](#Results)
- [Project structure](-Project-structure)


## Summary

The main contribution of the thesis is the design and development of an artifact consisting of an Android mobile application, which addresses the complexities and challenges commonly associated with the data collection process within smart home environments. 

The application leverages the Home Assistant WebSocket API to faciliate an effortless and streamlined data collection process for smart plug usage data. Notably, the application provides users with the ability to conveniently assign activity labels for smart plug usage data in real time, thus enhancing the contextual understanding of the collected smart plug data. Moreover, users can download and share the collected data and have granular control over the entire data collection and sharing process.

This Repository includes the artifact resulting from the development process, which is an APK that can be downloaded and installed on any Android smart phone. It also contains the source code for the application.

**Keywords**: Smart Home, Smart Plug, Data Collection, Home Assistant API, Mobile Application, Activity Labels


## Working with the repo

### Dependencies
All application dependencies are included in the artifact. 
The following dependencies/third libraries were used:
  - drift: ^2.16.0
  - encrypted_drift:
    git:
      url: https://github.com/simolus3/drift.git
      path: extras/encryption
  - path_provider: ^2.1.2
  - path: ^1.9.0
  - cupertino_icons: ^1.0.6
  - flutter_foreground_task: ^6.1.3
  - get_it: ^7.6.7
  - flutter_bloc: ^8.1.4
  - fluttertoast: ^8.2.4
  - sqflite_sqlcipher: ^2.2.1
  - web_socket_channel: ^2.4.4
  - flutter_local_notifications: ^17.0.0
  - share_plus: ^7.2.2
  - aes_crypt_null_safe: ^3.0.0
  - encrypted_shared_preferences: ^3.0.1
  - uuid: ^4.3.3

### Setup
Disclaimer: The artifact leverages the Home Assistant WebSocket API and thus requires the user to set up their Home Assistant instance and to integrate their smart plugs within the platform. 

To install the application on an Android smart phone:
1. Download the APK file 'app-release.apk' from the release section of this repository.
2. Enable installations from unknown sources on the device in the device settings. 
3. Navigate to the directory where the APK file is located and install the APK.


## Reproducing Results

The following steps describe how to set up and use the application, to collect smart plug data.

1. Set up a Home Assistant instance and integrate all smart plugs, for which data should be collected, to the platform. The integration may vary for different smart plug models.

2. Open the application and navigate to the "Registered Smart Plugs" page, tap the add button and register all smart plugs entities you wish to collect data for. For each smart plug, provide the Home Assistant entity Id of the smart plug and its device class attribute. Information on the entity Id and device class attribute can be found on your Home Assistant under Developer Tools->State. The device class attribute is under the column attributes and should usually be called "device_class". The Device Class Attribute should be something like "device_class" and NOT the value of the device class, i.e. is should NOT be "power"

![picture1](https://github.com/yileijiang/smart-plug-data-flutter-app/assets/71334281/565f3199-fb13-454e-8333-b520d1579476)




4. 
Provide the entity Id of the smart plug.
Provide the attribute key of the attribute that specifies the device class of the sensor. 
The default is set to the value "device_class", but this attribute may differ between smart plug brands and HA integrations.
To find the entity Id and device class attribute key, go to the Home Assistant Instance and navigate to Developer Tools > States
The entity Id can be found under the column "Entity".
The device class attribute key can be found under the column "Attributes".
5. Navigate to the settings page and add the address of the Home Assistant instance, as well as the Long Lived Access Token.
The Home Assistant address should include the port.
Example of a Home Assistant address format: "10.42.17.9:8123"
The Long Lived Access Token can be generated in the profile page of Home Assistant under the section "Long-Lived Access Tokens"
6. Connect to the Home Assistant API in the Settings page. Upon successful connection and authentication, a foreground service and the data collection process will be started.
7. Enter labels to smart plug usage entries in the home page, or by clicking on the notifications (if the notification setting was enabled).
8. Navigate to the home page and download the smart plug usage data. Provide an encryption password. Make sure to remember or store the password somewhere safely, as there will be no way to retrieve it.
The .aes file can be found in the "Downloads" file in the device's external storage.
9. The encrypted file can be shared and decrypted using any software employing the AES Crypt standard file format and the previously specified encryption password.
https://www.aescrypt.com/aes_file_format.html#:~:text=AES%20Crypt%20reads%20and%20writes,is%20easily%20identifiable%20by%20software.


## Results

Does a repository contain a table/plot of main results and a script to reproduce those results?

## Project structure

```bash
├── README.md                                        -- Read Me file
├── pubspec.yaml                                     -- configuration file for flutter application
├── android                                          -- Android-specific files and configurations
  ├── ...                                           
├── ios                                              -- iOS-specific files and configurations
  ├── ...                                                        
├── lib                                              -- application code
  ├── main.dart                                      -- entry point of the application
  ├── constants                                      -- strings used throughout the application
  ├── data                                           -- data related classes
    ├── ...
  ├── services                                       -- service classes (encryption, notifications, webSocket connections)
    ├── ...
  ├── styles                                         -- UI theme styles
  └── ui                                             -- UI related widgets and classes
    └── blocs                                        -- blocs without widgets
    └── pages                                        -- application pages                                              
    └── utils                                        -- utility classes 
    └── widgets                                      -- ui widgets
      ├── web_socket_connection_widget
        ├── web_socket_connection_foreground_task    -- foreground service  
        ├── ...  
      ├── ...                  
```
