require "resque/tasks"

task "resque:setup" => :environment

task "resque:restart" => :environment do
    system("sudo for i in `ls /tmp/| grep resqueworkers_`; do kill -9 `cat /tmp/$i`; done");

end