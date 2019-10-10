# Braincharter MRI Vasculature Extraction container

## Installation

This is a containarized version of the [tool](https://github.com/braincharter) developed by [Michael Bernier](https://github.com/braincharter/vasculature). Credits go to him for the great work! See also his paper:
> Bernier, M., Cunnane, S. C., & Whittingstall, K. (2018). The morphology of the human cerebrovascular system. Human Brain Mapping. https://doi.org/10.1002/hbm.24337

After cloning this repository, cd into its folder and build the Docker image using:
```
sudo docker build --no-cache -t <<YOUR PREFERED IMAGE TAG>> .
```

Or pull it from my Dockerhub repository as a Singularity container using:
```
singularity pull --name <<YOUR PREFERED IMAGE TAG>> Docker://rhaast/braincharter
```

## Running the pipeline

It's mostly the same procedure to run the pipeline as the original. Inside the folder containing your ToF or SWI data run the following command:

```
docker exec <<MOUNTING OPTIONS>> <<your image tag>> $PATH_TO/extract_vessels.sh <<PARAM1>> <<PARAM2>> <<PARAM3>>
singularity exec <<MOUNTING OPTIONS>> <<your image tag>> $PATH_TO/extract_vessels.sh <<PARAM1>> <<PARAM2>> <<PARAM3>>

Where:
- Param1: prefix of the data (ex: ToF.nii.gz -> ToF)
- Param2: suffix of the data (ex: ToF.nii.gz -> .nii.gz)
- Param3: Type of the data (ex: TOF or SWI or OTHER) -> SWI means dark vessels, ToF means bright vessels, OTHER won't skullstrip and skip some process and assume bright blood.
- (Optional) Mounting options: e.g. -B <<LOCAL FOLDER CONTAING YOUR DATA>> ...

For example: "docker exec rhaast/braincharter:latest bash extract_vessels.sh ToF 'nii.gz' TOF" or "singularity exec braincharter-vasculature.simg bash extract_vessels.sh ToF 'nii.gz' TOF"
```

## TODO
- Make it compatible with BIDS data format and convert to BIDS-app
