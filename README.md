#  SC2006-One.Zero

<p align="center">
  <img src="https://user-images.githubusercontent.com/97502375/231726159-d77b8d3d-72e6-4692-8030-bbb8f789b45a.png" alt="flatfinder" style="width: 600px; height: 100px;">
</p>

> Project for SC2006 Software Engineering: One-stop E-commerce housing mobile application

## Getting Started

> From your command line go to the folder directory and run the following scripts in the terminal.

1\. Go to folder directory

```terminal
cd <FOLDER-NAME>
```

2\. Clone the repo

```terminal
git clone https://github.com/qtxbryan/onezero.git
```

3\. Go to project directory

```terminal
cd onezero
```

4\. Install required dependencies

```terminal
flutter pub get
```
5\. Add in Android API Keys for Google Maps in AndroidMainifest.xml (android/app/main/AndroidManifest.xml)

``` terminal
<meta-data android:name="com.google.android.geo.API_KEY"
               android:value="API KEY HERE"/>
```

6\. Add in IOS API Keys for Google Maps in AppDelegate.swift (ios/Runner/AppDelegate.swift)

``` terminal
GMSServices.provideAPIKey("API KEY HERE")
```

7\. Run the application

```terminal
flutter run 
```

8\. Test Account

``` terminal
email: sc2006@gmail.com
password: Testing1!
```

## Project Folder Structure

#### Top Level Directory Layout

```terminal
.
├── android 
├── assets  
├── deliverables         # lab deliverables
├── ios  
├── lib                  # flutter app
├── linux  
├── macos
├── web
├── windows  
├── .gitignore
└── README.md
```



## Tech Stacks
<p>
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" >
  <img src="https://img.shields.io/badge/Firebase-F29D0C?style=for-the-badge&logo=firebase&logoColor=white" >
</p>

## Contributors - Team One.Zero

- [Bryan Tan](https://github.com/qtxbryan)
- [Glendon Goh](https://github.com/Glendon123)
- [Jabez Ng](https://github.com/jabezng2)
- [Wei Hao](https://github.com/weihaooooo)
- [Yupei](https://github.com/FAN0020)
