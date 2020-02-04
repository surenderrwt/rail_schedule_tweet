echo "# rail_schedule_tweet" >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/surenderrwt/rail_schedule_tweet.git
git push -u origin master

…or push an existing repository from the command line

git remote add origin https://github.com/surenderrwt/rail_schedule_tweet.git
git push -u origin master

…or import code from another repository

You can initialize this repository with code from a Subversion, Mercurial, or TFS project.




Install the Heroku CLI

Download and install the Heroku CLI.

If you haven't already, log in to your Heroku account and follow the prompts to create a new SSH public key.

$ heroku login

Create a new Git repository

Initialize a git repository in a new or existing directory

$ cd my-project/
$ git init
$ heroku git:remote -a instweet

Deploy your application

Commit your code to the repository and deploy it to Heroku using Git.

$ git add .
$ git commit -am "make it better"
$ git push heroku master

Existing Git repository

For existing repositories, simply add the heroku remote

$ heroku git:remote -a instweet

