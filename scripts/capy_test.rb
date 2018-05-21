def get_session driver = nil
  if driver.nil?
    Capybara.default_driver = :selenium
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app)

    end
    return Capybara::Session.new :selenium

  else
    Capybara.default_driver = :webkit
    Capybara.register_driver :webkit do |app|
      Capybara::Webkit::Driver.new(app) 

    end
    return Capybara::Session.new :webkit

  end
end

driver = (ARGV.collect.with_index{|x, i| ARGV[i+1] if x == "-d" }.compact.first rescue "selenium")
algo = (ARGV.collect.with_index{|x, i| ARGV[i+1] if x == "-q" }.compact.first rescue "Lúcifer")
algo = "Lucifer series" unless algo

session = (unless driver.blank?
  get_session( ARGV.collect.with_index{|x, i| ARGV[i+1] if x == "-d" }.compact.first )
else
  get_session()
end)

session.visit("https://google.com.br/")
sleep 1

session.find("input[name='q']").set(algo)
sleep 0.5

if session.all(".sbsb_g").any?
  session.find("input[name='q']").send_keys :tab
  session.find("input[name='q']").send_keys :enter
  sleep 1
else
  session.find("input[name='btnK']").click
  sleep 1
end

if session.all(:xpath, "//*[text()[contains(., '#{algo}')] and text()[not[contains(., 'Images')]]]").any?
  session.all(:xpath, "//*[text()[contains(., '#{algo}')]]").first.click
  sleep 0.5

else
  puts "Tem seu resultado não, mas pego o primeiro! o/"
  session.all(".rc > .r > a").first.click
  sleep 0.5

end

sleep 20
(session.save_screenshot(Rails.root.join("tmp/capybara/#{Time.now}_capy.png")) rescue nil)
