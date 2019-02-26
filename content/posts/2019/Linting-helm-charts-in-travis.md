---
title: "Linting Helm Charts in Travis"
date: 2019-02-25T21:11:16+02:00
description: "Because even helm deserves some CI love..."
categories: ['CI', 'Continuous Integration', 'Travis CI', 'kubernetes', 'helm-charts', 'YAML']
---

## Helm charts makes even kubernetes sane, However...

![YAML](/images/yaml.jpg)

Like any YAML based tooling, it's pretty darn easy to break it.

Here's a small snippet of how you can integrate `helm lint` to your CI build in [Travis CI](https://travis.com) quite seamlessly:

```yaml
---
sudo: false
group: travis_latest
jobs:
  include:
    - name: Lint
      language: minimal
      services: docker
      install:
        # This spins up our helm and kubectl docker image
        - docker run -d --name travis-helm -v ~/.kube:/root/.kube -v ${PWD}:/root/helm -e HELM_DIR=/root/helm -w /root/helm dtzar/helm-kubectl:2.12.3 /bin/sh -c "while true; do sleep 1; date; done" 
      script:
        # Optional, but needed in most cases
        - docker exec travis-helm bash -c "helm init --client-only" 
        # El Magico
        - ls ./**/Chart.yaml | xargs dirname | xargs -I % docker exec travis-helm bash -c "helm lint %" 
        # Bonus: Run any helm/kubectl command
        - docker exec travis-helm bash -c "kubectl --namespace ${NAMESPACE} wait --for=condition=complete job/${NAMESPACE}-initializer-ftw --timeout=30s"
      # Yet another bonus: tear down your env, this runs even if the build fails
      after_script: 
        - docker exec travis-helm bash -c "kubectl delete namespace ${NAMESPACE} --wait=false && helm delete ${NAMESPACE} --purge"
```

### Kudos to [David Tesar](https://github.com/dtzar) for making the [helm-kubectl image](https://github.com/dtzar/helm-kubectl)
