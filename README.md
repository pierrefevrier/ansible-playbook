This Docker image is for those who want to play Ansible from Docker container.

# Examples

## GitLab CI
- Create `SSH_PRIVATE_KEY` environment variable in your GitLab project and copy/paste your SSH private key as value.
- Add the public SSH key to the file `~/.ssh/authorized_keys`, in this target host.
- Run your playbook with the following gitlab-ci snippet:
```yml
image: alpine:latest

stages:
  - deploy

deploy:
  stage: deploy
  image: pierrefevrier/ansible-playbook:2.9.4.1
  before_script:
    ## Run ssh-agent (inside the build environment)
    - eval $(ssh-agent -s)
    ## Add the SSH key stored in SSH_PRIVATE_KEY variable to the agent store
    ## We're using tr to fix line endings which makes ed25519 keys work
    ## without extra base64 encoding.
    ## https://gitlab.com/gitlab-examples/ssh-private-key/issues/1#note_48526556
    - echo "$SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add -
    ## Create the SSH directory and give it the right permissions
    - mkdir -p ~/.ssh
    - chmod 700 ~/.ssh
  script:
    - ansible-playbook -i "host.docker.internal," deploy.yml --extra-vars "ansible_user=YOUR_TARGET_SSH_USER"

```
