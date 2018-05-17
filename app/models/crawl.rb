class Crawl

    def login_instagram(username, password)
        @@bot = Selenium::WebDriver.for :chrome
        @@bot.navigate.to "https://www.instagram.com/accounts/login/?force_classic_login"
        sleep 1
        #using username and password to login
        @@bot.find_element(:id, 'id_username').send_keys username
        @@bot.find_element(:id, 'id_password').send_keys password
        @@bot.find_element(:class, 'button-green').click
        sleep 1
        #navigate to a account page
        
    end

    def find_user(insta_url)
        @@bot.navigate.to "#{insta_url}"
        sleep 1
        #click on follower list
        @@bot.find_element(:xpath, '/html/body/span/section/main/div/header/section/ul/li[2]/a').click
        sleep 1
        #scroll down to load 1000 followers
        @@bot.find_element(:class, '_gs38e').click
        #for i in 0..99
           # @@bot.action.send_keys(:page_down).perform
        #sleep 1
        #end
        
    end

    
    def crawl_followers   
        #read inner HTML of follower list element
        a=@@bot.find_element(:class, '_p4iax').attribute('innerHTML')
        begin
            doc = Nokogiri::HTML(a)
            #get followers by href
            user_href=doc.css('div._f5wpw a').map { |link| link['href'] }
            #remove duplicate    
            user_href=user_href.uniq
             
            for i in user_href
               @@bot.navigate.to "https://www.instagram.com#{i}"
                #follower URL
                title="https://www.instagram.com#{i}"
                #profile image
                image_url=@@bot.find_element(:class,'_rewi8')['src']
                #post number
                post_number=@@bot.find_element(:xpath,'/html/body/span/section/main/div/header/section/ul/li[1]/span/span').text.to_i
                #followers
                followers=@@bot.find_element(:xpath,'/html/body/span/section/main/div/header/section/ul/li[2]').text.to_i
                #following                             
                following=@@bot.find_element(:xpath,'/html/body/span/section/main/div/header/section/ul/li[3]').text.to_i
                #description
                description=@@bot.find_element(:class,'_tb97a').text
                #save follower
                
                users=User.new(
                    id: user_href.index(i)+1 ,
                    title: title,
                    image_url: image_url,
                    post_number: post_number,
                    followers: followers,
                    following: following,
                    description: description) 
                users.save
            end
        end
        @@bot.quit()
           
    end
end
