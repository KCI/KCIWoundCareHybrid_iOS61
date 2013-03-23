Installation
============

### Clone

The first step is to clone the repository and switch to our changes from the pull request. The following terminal commands will do all of that.

```
git clone git@github.com:KCI/KCIWoundCare-Hybrid.git
cd KCIWoundCare-Hybrid
git remote add trike git@github.com:TricycleStudios/KCIWoundCare-Hybrid.git
git fetch trike
git reset --hard trike/master
```

### Initialize submodules

We have taken precautions to include necessary files with the project in order to ease building in different environments and to control which versions of the dependencies everyone is using. 

In order to pull in dependencies plese run the following commands:

1. `git submodule init`
2. `git submodule update`

This process will pull in the necessary version of phonegap and link it to the project so the app will run.


### Build

This should be all that is needed to build the app.

`open KCIExternalApp.xcodeproj/`

`CTRL+R`

