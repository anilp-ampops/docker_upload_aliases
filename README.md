This tool enables you to create 2 aliases, which are set tag and upload image to docker hub. The aliases are temporary in the bash shell running.


# Usage.

1. pull project and update docker_session.yml
2. set alias setdockerup='ipath="<path where project exists>" && ruby ${ipath}/setDocker.rb ${ipath} && source /tmp/.setDockUp'
3. launch new bash shell and run command "setdockerup"
4. enter your dockerhub user password
