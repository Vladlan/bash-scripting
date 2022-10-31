About lab3:

### Sub-task 1 - Configure Continuous Integrations (CI) for local development: front-end and back-end

[x] 0. **Clone**/**pull** given [front-end](https://github.com/EPAM-JS-Competency-center/shop-angular-cloudfront/tree/feat/devops-cicd-lab) and [back-end](https://github.com/EPAM-JS-Competency-center/nestjs-rest-api/tree/feat/devops-cicd-lab) apps.
[x] (fully configured for FE and partially for BE) 1. **Configure** the following integrations for both apps and **add** appropriate npm scripts for convenience:
   - [commit linting](https://commitlint.js.org/#/?id=getting-started) 
   - linting for *.js/*.ts files with [eslint](https://eslint.org/) and [typescript-eslint](https://typescript-eslint.io/docs/)
   - running unit tests (in *.test|spec.ts|js files) with [jest](https://jestjs.io/). Optionally*, add a test coverage threshold (~5-20%)
   - dependencies check with [npm audit](https://docs.npmjs.com/cli/v6/commands/npm-audit) or [Snyk Open Source](https://snyk.io/product/open-source-security-management/)
   - static code analysis with [CodeCov](https://about.codecov.io/for/open-source/) or [SonarQube Community Edition](https://www.sonarqube.org/downloads/) and [SonarScanner](https://www.npmjs.com/package/sonarqube-scanner) (**NB: to use SonarQube you must run it locally in a Docker container**)
   - release using [standard version](https://www.npmjs.com/package/standard-version) or [release-please](https://github.com/googleapis/release-please) (**NB: in this case npm script is not needed**)
[x] 2. **Configure** the following git hooks using [husky](https://www.npmjs.com/package/husky) npm package:
   - _commit-msg_ - [commit message linting](https://git-scm.com/docs/githooks#_commit_msg)
   - _pre-commit_ - js|ts linting [before committing changes](https://git-scm.com/docs/githooks#_pre_commit)
   - _pre-push_ - running unit tests, static code analysis and dependencies audit [before the code is being pushed](https://git-scm.com/docs/githooks#_commit_msg)
   - OPTIONALLY*, **configure** [lint-staged](https://www.npmjs.com/package/lint-staged)
[x] 3.  **Update** your shell script from the lab #1 (**_quality-check.sh_**) to invoke the following quality tools and checks: _eslint_, _testing_, _dependencies check_, _static code analysis_.

### Sub-task 2 - Configure CI/CD pipeline for front-end app

_Local setup_:

[x] (done in lab2) 1. **Set** up a web server (Apache, Nginx, etc) on your VM.
[x] (and done in lab2) 2. **Create** a shell scrip (**_local_ci_cd.sh_**) which will:
    - run code quality tools
    - build your app (use **_build-client.sh_** from the lab #1)
    - using SSH and SCP tools copy and extracts app's files into web server's website hosting folder
[] 2. **Add** npm script (**cicd:local**) which will execute the script from previous step.

_Cloud setup_:

[] 1. **Build** CI/CD pipeline using any of CI/CD or cloud providers and their tools.
Pipeline should have the following stages:
   - _source code check out_
   - _code quality checks_: linting, testing, dependencies audit, app's build, and optionally static code analysis
   - _build_: build the app with production configuration
   - _deployment_: publishes your static web app to any content delivery network (CDN)

### Sub-task 3 - Configure CI/CD pipeline for back-end app

_Local setup_:

[x] 1. **Dockerize** the back-end app:
   - **add** _Dockerfile_ which will build an image with the back-end app
   - **add** _.dockerignore_ to prevent unnecessary files from getting into the final Docker image
   - **try** to make your final image as minimal as possible by applying some [Dockerfile optimisation techniques](https://www.codewall.co.uk/writing-an-optimized-dockerfile/)
[x] 2. **Publish** your image to any [free private or public Docker registry](https://www.slant.co/topics/2436/~best-docker-image-private-registries) based on your preference.




### Prerequisites for deploy to vagrant:

1. Install vagrant
2. Ran `vagrant up` to up virtual ubuntu server on your local machine
3. Ran `vagrant ssh` to connect to virtual ubuntu server over ssh
4. You will have to install nodejs, zip, unzip on your ubuntu server
5. Ran `sudo ./deploy.sh` to deploy be and fe to your virtual ubuntu server
6. If everything is fine than you will be able to access API on vagrant virtual server ip on port written in ./nestjs-rest-api/.env.prod
7. In the end run `vagrant halt`


### Prerequisites to run build_docker_image.sh:

1. docker login
2. Than you will have to change `registry-name` in  `registry-name/nestjs-rest-api` in `build_docker_image.sh`