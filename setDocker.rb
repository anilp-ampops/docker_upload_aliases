require_relative 'DockerSession'

cwd=ARGV[0]

result = DockerUpload.getMandatoryInfo(cwd)
mysess = DockerUpload.new(result[:username], result[:password], result[:image], result[:version])
myscript = {}
myscript["docker_image"] = "#Docker image is #{mysess.dockerimg}"
myscript["date"] = "#Date is: #{mysess.ddate}"
myscript["command1"] = mysess.createCommand("login")
myscript["command2"] = mysess.createCommand("set_tag")
myscript["command3"] = mysess.createCommand("up_tag_version")
myscript["list_aliases"] = mysess.createCommand("list_aliases")
mysess.createBashScript(myscript)
