# Description: This file is handling CLI-parsing, Email Configuration, and Triggering

# Project Imports 
require 'httparty'
require 'thor'
require 'json'

class MailMe < Thor
   
    # case for sending email
    desc "request_mail <EMAIL>", "request an email of pull requests for the last 7 days"

    def request_mail(email)
        if(email != nil)
            response = HTTParty.post("https://hjezzcnhh8.execute-api.us-east-1.amazonaws.com/LIVE/list_pulls", :body =>{"email": email}.to_json)
            puts(response.body)
        else
            puts('Please specify an email and request again')
        end

    end

end 
    
    
    
    
    
    


    MailMe.start(ARGV)
