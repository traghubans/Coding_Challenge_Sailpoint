# Coding_Challenge_Sailpoint

# Task
Using the language of your choice, write code that will use the GitHub API to retrieve a summary of all opened, closed, and in progress pull requests in the last week for a given repository and send a summary email to a configurable email address. Choose any public target GitHub repository you like that has had at least 3 pull requests in the last week. Format the content email as you see fit, with the goal to allow the reader to easily digest the events of the past week. If sending email is not an option, then please print to console the details of the email you would send (From, To, Subject, Body).

# Feature (and their respective techologies)
- Call Github API and Parse Records within the last week => AWS Lambda, API Gateway
- Send a summary email => Amazon SES
- Configurable Email Address => Ruby script interfacing with the Command Prompt
- Containerizing the application => Docker 
- CI / CD => Github

# Project Installation

# Future Integrations
- One implementation that could be really useful is for slack. Although there already is a slack bot, it would be quite fascinating to run the command in slack and have it sent to your email. 