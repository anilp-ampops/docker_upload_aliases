require 'io/console'
require "base64"
require "pry-byebug"
require 'yaml'

class DockerSession

  attr_accessor :dockerun, :dockerimg, :dockerver, :ddate
  def initialize(dockerun, dockerpw, dockerimg, dockerver)
    @dockerun = dockerun
    @dockerpw = dockerpw
    @dockerimg = dockerimg
    @dockerver = dockerver
    @ddate = DateTime.now.strftime("%d%m%Y%H%M")
    @script = {}
  end

  def createBashScript(iscript={})
    scriptPath="/tmp"
    scriptname=".setDockUpAliases"
    File.new "#{scriptPath}/#{scriptname}", "w"
    open("#{scriptPath}/#{scriptname}", 'w') { |file|
      file << "# !/bin/bash\n"
      iscript.each do |key, value|
        file << "#{value}\n"
      end
    }
    system( "chmod 755 #{scriptPath}/#{scriptname}" )
  end

  def createCommand(iaction)
    case iaction
    when "login"
       # cmd="docker login --username #{@dockerun} --password #{Base64.decode64(@dockerpw)}"
       cmd="docker login --username #{@dockerun} --password ${$(echo '#{@dockerpw}' | base64 --decode)}"
    when "set_tag"
       cmd="alias dock_#{iaction}=\"docker tag #{@dockerimg} #{@dockerun}/#{@dockerimg}\""
    when "set_tag_version"
       cmd="alias dock_#{iaction}=\"docker tag #{@dockerimg} #{@dockerun}/#{@dockerimg}:#{@dockerver}\""
    when "up_tag_version"
       cmd="alias dock_#{iaction}=\"docker push #{@dockerun}/#{@dockerimg}:#{@dockerver}\""
    when "up_tag"
       cmd="alias dock_#{iaction}=\"docker push #{@dockerun}/#{@dockerimg}\""
    when "list_aliases"
       cmd="alias| grep -i dock | grep -v setdockerup"
    else
      cmd="echo \"no action required\""
    end
  end

  def self.getMandatoryInfo(icwd="")

    sess_config = YAML.load_file("#{icwd}/docker_session.yml")

    docker_username = sess_config['docker_session']['username']

    puts "Please enter your docker password ?"
    docker_password = STDIN.noecho(&:gets).chomp
    dpassword = Base64.encode64(docker_password)

    docker_image = sess_config['docker_session']['image']

    docker_version = sess_config['docker_session']['image_version']

    # puts "docker username is #{docker_username}"
    # puts "docker password is #{docker_password.gsub(/./,'#')}"

    docker_img = {
      :username => docker_username,
      :password => dpassword,
      :image => docker_image,
      :version => docker_version
    }
    return docker_img
    puts "completed"
  end

end
