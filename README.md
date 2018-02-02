This tool sets up 2 Linux aliases which are temporarily created to help the user define the docker image tag and upload to dockerhub repo without having to run through normal process of logging on to docker hub, setting the tag and pushing up the image.

# Usage.

1. pull project and update docker_session.yml
2. set alias setdockerup='ipath="<path where project exists>" && ruby ${ipath}/setDocker.rb ${ipath} && source /tmp/.setDockUp'
3. launch new bash shell and run command "setdockerup"
4. enter your dockerhub user password
5. Use aliases "dock_set_tag" or "dock_up_tag_version" for the image you are working on.
