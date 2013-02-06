class Build

  ROOT = Dir.pwd

  def self.clean

    # clean css files
    shell = "rm -rdf #{ROOT}/public/js/ &&";
    shell += "mkdir #{ROOT}/public/js/ && ";

    # clean css files
    shell += "rm -rdf #{ROOT}/public/css/ && ";
    shell += "mkdir #{ROOT}/public/css/ && ";
    shell += "cp -r #{ROOT}/development/css/themes/default/images #{ROOT}/public/css/"
    
    system shell

  end

  def self.compile
    
    compressList = {
        "commonJS" => {"src" => ["development/js/jquery.js", "development/js/jquery.mobile-1.2.0.js","development/js/app-logic.js"], "dest" => "public/js/all.min.js"},
        "allCSS" => {"src" => ["development/css/themes/default/common.css","development/css/themes/default/jquery.mobile-1.2.0.css","development/css/themes/default/app.css"], "dest" => "public/css/all.css"}
    }

    compressList.each do |name, source|
      inputFiles = source["src"].collect { |x| "#{ROOT}/"+x }.join(" ").to_s
      outputFile = source["dest"]
      shell = "touch #{ROOT}/#{outputFile} && "
      shell += "cat #{inputFiles} > #{ROOT}/#{outputFile} && "
      shell += "java -jar #{ROOT}/build/yuicompressor-2.4.7.jar --charset utf-8 #{ROOT}/#{outputFile} -o #{ROOT}/#{outputFile}";
      system shell
    end

  end

  # def self.test
  #   system "cd #{ROOT} && mocha"
  # end

  def self.launch_app(env=development)
    puts env
    system "cd #{ROOT} && NODE_ENV=#{env} node app"
  end

end
