# OSS PM STATS CALC HANDLING

[TOC]


## Introduction
This repo contains the OSS PM Statistics Calculation Handling chart and its associated tests and CI.
Please follow this documentation for further details.

### Repo Structure
This is the directory structure of the repo.
Below is a description of the contents of each of the upper level directories.
```
oss-pm-stats-calc-handling/
├── bob
├── charts
│ └── eric-oss-pm-stats-calc-handling
│     ├── charts
│     └── templates
├── ci
│ ├── jenkinsfiles
│ ├── rulesets
│ └── scripts
├── dev
├── docs
└── testsuite
├── helm-chart-validator
│ └── src
└── schematests
  └── tests
     ├── negative
     └── positive
```
#### Bob
This is a submodule and contains the latest ADP BOB tool used to power the CI automation
See the [ADP BOB Documentation](https://gerrit.ericsson.se/plugins/gitiles/adp-cicd/bob).

#### Charts
This directory contains the OSS  Integration Chart.
See the [OSS PM STATS CALC HANDLING Docs](docs/oss_pm-stats-calc-handling_chart.md)
for more details

#### CI
This directory contains the jenkinsfiles and bob rulesets used to run the CI automation for this repository.
See the [OSS PM STATS CALC HANDLING CI Docs](docs/ci/oss_pm-stats-calc-handling_ci.md)
for more details

#### Dev
This directory contains useful utility scripts for developers when contributing to this repo.
See the [OSS PM STATS CALC HANDLING Dev Docs](docs/dev/developer_guide.md)
for more details.

#### Docs
This directory contains all the documentation describing this repository.

#### Testsuite
This directory contains the tests created for the OSS PM STATS CALC HANDLING
See the [OSS PM STATS CALC HANDLING Testsuite Docs](docs/testsuite/test_overview.md)
for more details.

## Release Notes

## Community
### Key people of the project
  - PO: <team_po>
  - Guardians: (Code reviews, approvals, house rules etc.)
    - <team_mail>)
### Contact
  - <team_contact>
### Contributing
We're an inner source project and welcome contributions. See our [Contribution
Guide](CONTRIBUTION_GUIDE.md) for more details.

## FAQ
Please see [FAQ](docs/faq.md)
