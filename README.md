[![Build Status](https://travis-ci.org/LandRegistry/acceptance-tests.svg)](https://travis-ci.org/LandRegistry/acceptance-tests)

Frontend Acceptance Tests
===============

### Overview

This repository contains the front end tests for all the systems.

### Installing

Install Phantomjs using homebrew

```
brew update && brew install phantomjs
```

Then install bundle:

```
gem install bundler
```

Then run bundler (this will install all required gems)

```
bundle install
```

### Running the tests

To run all the tests:

```
sh run_tests.sh
```

Or to run a specific feature:

```
cucumber -r features features/caseworker/first-registration.feature
```

Or to run a specific scenario(the 29 refers to the line in the future file that your scenario starts on):

```
cucumber -r features features/caseworker/first-registration.feature:29
```
