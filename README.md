# UserLAnd-Assets-Support
A repository for holding assets used by all distros/apps for UserLAnd

After cloning this repo, you simply do the following...

`./scripts/buildArch.sh $desiredArch` 
`./scripts/installArch.sh $desiredArch`

where `desiredArch` can be `arm`, `arm64`, `x86`, `x86_64`, `all`
`all` does not mean all of the previous.  It just relates to the files under assets/all

Note: When proot is built, we pull and build from the code found [here](https://github.com/CypherpunkArmory/proot).
