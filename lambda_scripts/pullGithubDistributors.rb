require 'octokit'
require 'json'
require 'aws-sdk'
require 'mail'

# Class Declarations
class PullRequests
    
    # method to get the pull requests
    def self.getRequests()
        
        # Declared Variables
        issues = []
    
        # Get the array of requests
        pulls =  Octokit.list_issues('great-expectations/great_expectations', state: 'all', since: DateTime.now - 7)
        
        # Parse out the pull requests 
        pulls.each do |issue|
            if (issue["pull_request"] != nil)
                
                # Parse out the json, feed into class object, push to array
                obj = issue.to_hash.to_json
                obj = JSON.parse(obj)
                # puts(obj["created_at"])
                user = obj["user"]
                issues << Metadata.new(obj["id"], obj["title"], obj["created_at"], obj["url"], user["login"], user["url"])
            end
        end
        
        return issues
    end
    
end

# Parsed Metadata class for easier management
class Metadata
    
    # to make variables accessible by dot notation
    attr_accessor :id, :title, :date, :url, :username, :userUrl
    
    # initialization function for Metadata object
    def initialize(id, title, body, url, username, userUrl)
        @id = id
        @title = title
        @date = date
        @url = url
        @username = username
        @userUrl = userUrl
    end
        
end

# Lambda Handler
def lambda_handler(event:, context:)
    # TODO implement
    
    # Get parsed pull requests
    requests = PullRequests.getRequests()
    # puts requests[0].inspect;
    
    eventObj = event.to_hash.to_json
    eventObj = JSON.parse(eventObj)
    email = eventObj["email"]
    message = "Please check #{email}"
    
    # construct email function
    constructEmail(requests, email)
    
    # response object
    { 
        statusCode: 200, 
        body: message,
        email: email
    }
    
end

# Method to construct the email 
def constructEmail(metadata, email)
    
    # Declared Variables
    sender = 'traghubans@gmail.com'
    recipient = email
    subject = "Pull Requests for Great Expectations Repository over last 7 days"
    encoding = "UTF-8"
    
    
    # Create HTML Body
    htmlbody = 
    '
    <html>
    <head>
        <style>
            #requests {
              font-family: Arial, Helvetica, sans-serif;
              border-collapse: collapse;
              width: 100%;
            }
            
            #requests td, #customers th {
              border: 1px solid #ddd;
              padding: 8px;
            }
            
            #requests tr:nth-child(even){background-color: #f2f2f2;}
            
            #requests tr:hover {background-color: #ddd;}
            
            #requests th {
              padding-top: 12px;
              padding-bottom: 12px;
              text-align: left;
              background-color: #0457aa;
              color: white;
            }
            </style>
    </head>
    <table id="requests">
        <tr>
            <th>id</th>
            <th>title</th>
            <th>url</th>
            <th>user</th>
        </tr>'
        
    # iterate through the metadata, and append text to htmlbody
    metadata.each do |data|
       htmlbody << "<tr>
                        <td>#{data.id}</td>
                        <td>#{data.title}</td>
                        <td>#{data.url}</td>
                        <td><a href=#{data.userUrl}>#{data.username}</a></td>
                    </tr>"
    end
    
    # finish the html body
    htmlbody << '</table> </html>'
    
    
    mail = Mail.deliver do
        to      recipient
        from    'raghutrav@gmail.com'
        subject 'Pull Request in last 7 days for Great-Expectations'
  
    html_part do
      content_type 'text/html; charset=UTF-8'
      body htmlbody
    end
  end
    
end



