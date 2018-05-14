class FileReader
  def self.execute(file = nil, options = {}, &block)
    return if file.nil?
    instance = FileReader.new(file, options = {})

    instance.process()
  end

  def initialize(file, options = {}, &block)
    @file    = file
    @options = options
    @content = @file.read
  end

  def process()
    save_original_io()
    load_info_from_file()

    yield if block_given?
  end

  private
  def save_original_io()
    File.open(Rails.root.join('public', 'uploads', "#{File.basename(@file.path, ".tab")}_#{Time.now.strftime("%Y-%m-%d-%H_%M")}.tab"), 'wb') do |file|
      file.write @content
    end
  end

  def load_info_from_file()
    return if @content.nil?

    #### ANALISE DO CONTENT AQUI ####
    if @content.include?("\n")
      guide_lines =
      (
        ( @content.split("\n").first.include?("purchaser name") ?
          @content.split("\n").first.split("\t").collect{|x| x.gsub(" ", "_")} :
          Purchase.column_names.reject{|x| x == "id" }
        ) rescue []
      )
      actual_content, model_hash = @content.split("\n").reject{|x| x.include?("purchaser name") }, Hash.new()

      actual_content.each do |line|
        line.split("\t").each_with_index do |cell, i|
          model_hash.merge!(guide_lines[i] => cell)
        end

        generate_purchase model_hash
      end
    end
  end

  def generate_purchase model
    puts "Criando Purchase ~> #{model.to_s}"
    Purchase.create(model)
  end
end
