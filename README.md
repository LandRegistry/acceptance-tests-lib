[![Build Status](https://travis-ci.org/LandRegistry/acceptance-tests.svg)](https://travis-ci.org/LandRegistry/acceptance-tests)

Frontend Acceptance Tests
===============

### Overview

This repository contains the front end tests for all the systems.

### Running the tests in the vagrant image

Navigate to the acceptance test repoistory

```
cd apps/acceptance-tests/
```

To run all the tests:

```
./run_tests.sh
```

Or to run a specific feature:

```
./run_tests.sh features/caseworker/first-registration.feature
```

Or to run a specific scenario(the 29 refers to the line in the future file that your scenario starts on):

```
./run_tests.sh features/caseworker/first-registration.feature:29
```

### Running the tests against Preview

To run against the preview enviornment, then use:

```
./run_tests_preview.sh
```
 
You will need to set the following enviornment variables:
```
HTTPAUTH_USERNAME
HTTPAUTH_PASSWORD
```

