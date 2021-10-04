# Coding_Challenge_Sailpoint

# Task
Using the language of your choice, write code that will use the GitHub API to retrieve a summary of all opened, closed, and in progress pull requests in the last week for a given repository and send a summary email to a configurable email address. Choose any public target GitHub repository you like that has had at least 3 pull requests in the last week. Format the content email as you see fit, with the goal to allow the reader to easily digest the events of the past week. If sending email is not an option, then please print to console the details of the email you would send (From, To, Subject, Body).

# Chosen Implementation
For this Challenge, I thought the most practical route was a CLI tool that triggered a serverless aws lambda function 

# Feature (and their respective techologies)
- Call Github API and Parse Records within the last week => AWS Lambda, API Gateway
- Send a summary email => Amazon SES Originally, but transitioned to Ruby Mail Gem
- Configurable Email Address => Ruby script interfacing with the Command Prompt
- CI / CD => Github
- Metrics and Logging => AWS Cloudwatch

# Project Startup
- Clone the repository
- CD into your local project repository
- run 'bundle install'
- run the following command in the project folder 
    - ruby cli.rb request_mail "email"

# Project Files / Folders
- cli.rb: parse command line argument methods and send trigger
- lambda_scripts: a copy of all the AWS lambda scripts used under my accont

# Future Integrations
- One implementation that could be really useful is for slack. Although there already is a slack bot, it would be quite fascinating to run the command in slack and have it sent to your email. 

# Extra Information
- The scripts in the lambda_scripts repository are not executable by command line, but to show you the code that is written via lambda functions over AWS
- Original implementation required using Amazon SES, but since I couldn't get out of their sandbox requirements in time, I decided to transition to the Ruby Mail Gem
    - Regarding the point above, if you were to configure to send this yourself you would need to:
        1. Go to mail/network/delivery_methods/smtp.rb 
        2. Configure what smtp.rb setting you will need
    - I used gmail for my smtp server, so a few things to note are:
        1. Make sure you allow less secure apps
        2. Comment out anything regarding enabling starttls
- Emails will always be sent from raghutrav@gmail.com
    
    
# See it in Action 
    
![CodingChallenge](https://user-images.githubusercontent.com/26878417/135803992-1adc9ea7-254d-48e4-bdcd-2910ecc9f028.gif)
