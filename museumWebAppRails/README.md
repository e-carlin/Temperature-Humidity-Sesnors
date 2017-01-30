# README

I highly reccomend developing in a Linux (
preferably Ubuntu) virtual environment. I use 
Virtual Box and Ubuntu for my environment.

1) Install Ruby and Rails <br />
 **** Make sure to use Ruby 2.3.1 and Rails 5.0.1 <br />

 Just follow along with the steps on thsi page: <br />

 https://www.phusionpassenger.com/library/walkthroughs/deploy/ruby/ownserver/apache/oss/install_language_runtime.html <br />

2) Install gem dependecies <br />
	$ cd museumWebAppRails <br />
	$ bundle install <br />

3) Run the latest migrations <br />
	$ rake db:migrate <br />


4) Start the development server <br />
 	$ rails s

5) Navigate to the homepage
 
	localhost:3000
	



