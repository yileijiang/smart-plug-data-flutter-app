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

The main contribution of the thesis is the design and development of a lightweight and user friendly Android mobile application, which addresses the complexities and challenges commonly associated with the data collection process within smart home environments.

The application leverages the Home Assistant WebSocket API to faciliate an effortless and streamlined data collection process for smart plug usage data. Notably, the application provides users with the ability to conveniently assign activity labels for smart plug usage data in real time, thus enhancing the contextual understanding of the collected smart plug data. Moreover, users can download and share the collected data and have granular control over the entire data collection and sharing process.

This Repository includes the result of the development process, which is an APK that can be downloaded and installed on any Android smart phone, as well as the source code for the application.

**Keywords**: Smart Home, Smart Plug, Data Collection, Home Assistant API, Mobile Application, Activity Labels


## Working with the repo

### Dependencies
All application dependencies are included in the artifact. 
Dependencies/third libraries used are:
- flutter_bloc: ^8.1.3
- web_socket_channel: ^2.4.0
- fluttertoast: ^8.2.2
- flutter_foreground_task: ^6.1.2
- hive: ^2.2.3
- hive_flutter: ^1.1.0
- flutter_secure_storage: ^9.0.0
- flutter_local_notifications: ^16.1.0
- path_provider: ^2.1.1
- aes_crypt_null_safe: ^2.0.2
- cupertino_icons: ^1.0.2

The Home Assistant Platform and the integration of smart plugs is required to be set up by the user.

### Setup

For Android:
1. Download the APK file from the release section of the github repository.
2. Enable installations from unknown sources on the device in the device settings. 
3. Navigate to the directory where the APK file is located and install the APK.


## Reproducing Results

1. Set up a Home Assistant instance and integrate all smart plugs to the platform. 
2. Navigate to the Home Assistant entities page and add all smart plugs entities you wish to collect data for.
Provide the entity Id of the smart plug.
Provide the attribute key of the attribute that specifies the device class of the sensor. 
The default is set to the value "device_class", but this attribute may differ between smart plug brands and HA integrations.
To find the entity Id and device class attribute key, go to the Home Assistant Instance and navigate to Developer Tools > States
The entity Id can be found under the column "Entity".
The device class attribute key can be found under the column "Attributes".
3. Navigate to the settings page and add the address of the Home Assistant instance, as well as the Long Lived Access Token.
The Home Assistant address should include the port.
Example of a Home Assistant address format: "10.42.17.9:8123"
The Long Lived Access Token can be generated in the profile page of Home Assistant under the section "Long-Lived Access Tokens"
4. Connect to the Home Assistant API in the Settings page. Upon successful connection and authentication, a foreground service and the data collection process will be started.
5. Enter labels to smart plug usage entries in the home page, or by clicking on the notifications (if the notification setting was enabled).
6. Navigate to the home page and download the smart plug usage data. Provide an encryption password. Make sure to remember or store the password somewhere safely, as there will be no way to retrieve it.
The .aes file can be found in the "Downloads" file in the device's external storage.
7. The encrypted file can be shared and decrypted using any software employing the AES Crypt standard file format and the previously specified encryption password.
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
