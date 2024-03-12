# ADK - Automation-Development-Kit

## Intent

ADK (Automation Development Kit) is a small codebase that would help set up selenium grid on kubernetes.
The idea is to have the selenium hub deployed in one pod and the browser driver instances deployed in
the other pods. Have a kubernetes service created that would help in interaction between the hub and the
nodes.

## Selenium Grid

For further information you can have a look at this [documentation](SeleniumGrid4.pdf)

## Execution

To run follow the steps:

- Clone the repository
- Give execute permission to `setup.sh`.
- Add `--install` as argument if you want to run installations.
- Add `--deploy` as argument if you want to deploy grid to kubernetes.
