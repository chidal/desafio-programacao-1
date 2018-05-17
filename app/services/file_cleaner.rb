class FileCleaner
  include Sidekiq::Worker
  def self.execute; new.perform(); end

  def perform
    puts "@@@@@@@@@@@@@@@@@@@@@@@@\n@@                    @@\n@@ Executando Limpeza @@\n@@                    @@\n@@@@@@@@@@@@@@@@@@@@@@@@"

    file_list = Dir[Rails.root.join("public/uploads/*")]
    file_list.each do |path|
      date_time = path.split("_").last.split(".").first
      year, month, day, hour, minute = path.split("_").last.split(".").first.split("-").collect &:to_i
      file_date = DateTime.new(year, month, day, hour, minute)

      delete_file(path) if file_date < (DateTime.now - 15.days)
    end

    puts "@@@@@@@@@@@@@@@@@@@@\n@@                @@\n@@ Fim da Limpeza @@\n@@                @@\n@@@@@@@@@@@@@@@@@@@@"
  end

  private
  def delete_file path
    return nil if path.blank?
    puts "Destruindo arquivo #{path}"

    FileUtils.remove_file(path)
  end
end
