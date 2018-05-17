class FileCleaner
  include Sidekiq::Worker

  def perform
    puts "@@@@@@@@@@@@@@@@@@@@@@@@\n@@                    @@\n@@ Executando Limpeza @@\n@@                    @@\n@@@@@@@@@@@@@@@@@@@@@@@@"

    file_list = Dir[Rails.root.join("public/uploads/*")]
    file_list.each do |file_name|
    end

    FileUtils.rm()
  end
end
