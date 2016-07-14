# bitrise-scripts

- The purpose is automation of building, storing and deploying.

## Define branches
- master
 - Use for storing all of the original codes of binary for submitting.
- develop
 - This branch should be branched from master branch.  
 - Use for working on Sprint.  
 - Codes on this branch are basically not passed user test.  
- feature 
 - This branch should be branched from develop branch.  
 - Use for developing new features or deal with existing issues.  
- release 
 - This branch should be branched from develop branch.  
 - Use for preparing to release the app.  
 - We will do user test on this branch.  
- fix
 - This branch should be branched from release branch.  
 - Use for fixing bugs and adjusting behaviour.  

## What CI works

### When pushed
- master
 - Archive release binary and store that on Bitrise.
 - Create release. (https://help.github.com/articles/creating-releases/)
 - Upload release binary to GitHub release.
 - Upload release binary to iTunes connect. (for iOS)
- feature
 - Run unit test
- develop
 - Run unit test
 - Archive in-house binary and store that on Bitrise.
- fix
 - Run unit test
- release
 - Run unit test

### When comment is pushed and there is Pull Request
Following tasks will run in addition to the above.

- master
 - No operation
- feature
 - Archive in-house binary and store that on Bitrise.
- develop
 - No operation
- fix
 - Archive in-house binary and store that on Bitrise.
- release
 - Archive in-house binary and store that on Bitrise.
 - Deploy in-house binary with Beta on Fabric.
