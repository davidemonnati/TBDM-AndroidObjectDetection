<br />
<div align="center">
  <a href="https://github.com/othneildrew/Best-README-Template">
    <img src="https://www.omilab.org/nodes/OMiLAB_Nodes/15_University_of_Camerino/images/lab.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">TBDM-AndroidObjectDetection</h3>
</div>


<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#build-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#prepare-the-environment">Prepare the environment</a></li>
        <li><a href="#build-apk">Build APK</a></li>
      </ul>
    </li>
    <li><a href="#contacts">Contacts</a></li>
  </ol>
</details>

## About the project
![Camera screenshot][screenshots]

This project is a flutter application that allows you to perform object detection over IoT devices figures.
To use this application is first necessary to deploy [this project][objdet-be-repo] into a Docker container, then you can build and install the application in your device.

Follow the steps below to build the app.


## Build with <a name="build-with"></a>
This section list any frameworks and libraries used to bootstrap this project.

![Flutter][flutter-badge]
![Dart][dart-badge]
![Python][python-badge]
![Jupyter Notebook][jupyter-badge]
![Docker][docker-badge]

## Getting started
Follow this instructions to build the entire project.

### Prerequisites

* Install docker
* Install open JDK 21
* Install android studio
* Install and configure flutter (it is recommended to follow [this guide][flutter-guide-url])

### Prepare the environment <a name="prepare-the-environment"></a>
This application sends the photo taken to an external server which will process it and returns the picture with rectangles and labels above the recognised objects.

To deploy the following services I recomend to use the dockerfile in this repository.

1. Clone this repo
    ```sh
        $ git clone https://github.com/davidemonnati/TBDM-AndroidObjectDetection
        $ cd ./TBDM-AndroidObjectDetection
    ```

2. Clone TBDM-VGLS-2023 repo
    ```sh
        $ cd docker
        $ git clone https://github.com/PROSLab/TBDM-VGLS-2023
    ```
   This operation must be done manually because the TBDM-VGLS-2023 repository is private.

3. At this point it is necessary to create the detectron model and the .env file. To do this, please consult [this guide][be-readme].

4. Copy the newly created files inside the TBDM-VGLS-2023 directory

5. Run docker compose file
    ```sh
        $ docker compose up
    ```

### Build APK <a name="build-apk"></a>
If you have flutter installed, you can check the status of flutter installation using the following command: ```$ flutter doctor```.

![Flutter doctor][term-image]
Make sure that:
* Flutter
* Android toolchain

are correctly installed.

If you have problems check [this link][flutter-help].

Finally, to build the apk open a new terminal on the root of this project and use this commands:


```sh
  $ cd app
  $ docker build apk
```

When the build is finished you can find the apk here: ``build\app\outputs\flutter-apk\app-release.apk``


## Contacts

Davide Monnati - [@linkedin][davide-linkedin-account] - davide.monnati@studenti.unicam.it

Christopher Pinesi

Project Link: [https://github.com/davidemonnati/TBDM-AndroidObjectDetection][project-repo-link]


<!-- IMAGES & LINKS  -->
[screenshots]: images/image.png
[term-image]: images/term.png
[flutter-guide-url]: https://docs.flutter.dev/get-started/install
[davide-linkedin-account]: https://www.linkedin.com/in/davide-monnati/
[project-repo-link]: https://github.com/davidemonnati/TBDM-AndroidObjectDetection
[flutter-badge]: https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white
[dart-badge]: https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white
[python-badge]: https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54
[jupyter-badge]: https://img.shields.io/badge/jupyter-%23FA0F00.svg?style=for-the-badge&logo=jupyter&logoColor=white
[docker-badge]: https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white
[objdet-be-repo]: https://github.com/PROSLab/TBDM-VGLS-2023/tree/main/ObjectDetection
[flutter-help]: https://docs.flutter.dev/get-started/install/help#android-setup
[be-readme]: https://github.com/PROSLab/TBDM-VGLS-2023/blob/main/ObjectDetection/README.md#configuration
