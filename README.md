<<<<<<< HEAD
# Rails 4 Sample App on OpenShift #
Quickstart rails 4 application for openshift.

The easiest way to install this application is to use the [OpenShift
Instant Application][template]. If you'd like to install it
manually, follow [these directions](#manual-installation).

## OpenShift Considerations ##
These are some special considerations you may need to keep in mind when
running your application on OpenShift.

### Database ###
Your application is configured to use your OpenShift database in
Production mode.
Because it addresses these databases based on [OpenShift Environment
Variables](http://red.ht/NvNoXC), you will need to change these if you
want to use your application in Production mode outside of
OpenShift.

By default the development and test environment is configured to use
the sqlite3 database adapter.

You can also speed up the `git push` process by excluding gems you don't need,
based on the database you use in OpenShift. You can use the `BUNDLE_WITHOUT`
environment variable for that:

```
$ rhc env set BUNDLE_WITHOUT="development test postgresql"
```

Use the command above if you don't want to install any development gems and you
are using OpenShift MySQL cartridge.

### Assets ###
Your application is set to precompile the assets every time you push
to OpenShift. Any assets you commit to your repo will be preserved
alongside those which are generated during the build.

By adding `disable_asset_compilation` marker, you will disable asset compilation upon application deployment.

### Security ###
Since these quickstarts are shared code, we had to take special
consideration to ensure that security related configuration variables
was unique across applications.
To accomplish this, we modified some of the configuration files (shown
in the table below).
Now instead of using the same default values, your application will
generate it's own value using the `initialize_secret` function from `lib/openshift_secret_generator.rb`.

This function uses a secure environment variable that only exists on
your deployed application and not in your code anywhere.
You can then use the function to generate any variables you need.
Each of them will be unique so `initialize_secret(:a)` will differ
from `initialize_secret(:b)` but they will also be consistent, so any
time your application uses them (even across reboots), you know they
will be the same.

TLDR: You should copy/link the `.openshift/lib/openshift_secret_generator.rb`
file into `./lib` folder and link the `secret_token.rb` and `session_store.rb`
files into `./config/initializers` folder. Look at this quickstart for an
example.

### Development mode ###
When you develop your Rails application in OpenShift, you can also enable the
'development' environment by setting the `RAILS_ENV` environment variable,
using the `rhc` client, like:

```
$ rhc env set RAILS_ENV=development
```

If you do so, OpenShift will run your application under 'development' mode.
In development mode, your application will:

* Show more detailed errors in browser
* Skip static assets (re)compilation
* Skip web server restart, as the code is reloaded automatically
* Skip `bundle` command if the Gemfile is not modified

Development environment can help you debug problems in your application
in the same way as you do when developing on your local machine.
However, we strong advise you to not run your application in this mode
in production.

##### Modified Files #####

<table>
  <tr>
    <th>File</th>
    <th>Variable</th>
  </tr>
  <tr>
    <td>config/initializers/secret_token.rb</td> 
    <td>Railsapp::Application.config.secret_token</td>
  </tr>
  <tr>
    <td>config/initializers/session_store.rb</td>
    <td>Railsapp::Application.config.session_store</td>
  </tr>
</table>

## Manual Installation ##

1. Create an account at https://www.openshift.com

1. Create a rails application

    ```
    rhc app create railsapp ruby-2.0
    ```

   **Note:** This quickstart will not work with Ruby 1.8


1. Add database support to your application

    ```
    rhc cartridge add -a railsapp -c mysql-5.5
    ```

    or

    ```
    rhc cartridge add -a railsapp -c postgresql-9.2
    ```

1. Add this upstream Rails quickstart repository

    ```
    cd railsapp
    git remote add upstream -m master git://github.com/openshift/rails4-example.git
    git pull -s recursive -X theirs upstream master
    ```

1. Push your new code

    ```
    git push
    ```

1. That's it! Enjoy your new Rails application!


[template]: https://openshift.redhat.com/app/console/application_types

License
-------

This code is dedicated to the public domain to the maximum extent permitted by applicable law, pursuant to CC0 (http://creativecommons.org/publicdomain/zero/1.0/)
=======
## BuzzBites

*BuzzBites is for anyone searching for awesome restaurants, just a short walk away. You don't need to go on Foursquare or Instagram: It's all here on BuzzBites!*

Get first-hand accounts on what folks are saying about restaurants you're curious about. Check out posts on Twitter and Instagram about the trending restaurants around you, or enter a zip code for restaurants in an area you're curious about. Take all the guesswork, research, and planning out of your group dinner outings. Got a date? Bring them to a special spot. Brunch with the inlaws? Impress them with your knowledge of the neighborhood eateries.


Our development team used a variety of technologies to create this full stack application: 
- Ruby on Rails version 4.2.6 and PostgresQL
- GeoLocation, Google Maps, Foursquare, and Instagram APIs
- HTTParty and Figaro gems
- [Trello for progress tracking](https://trello.com/b/LoDBZMzJ/foodie-faddies)
- GitHub (obviously) for version control
- Agile approach for meetings



Check out pics of our humble beginnings

![ERD](https://raw.githubusercontent.com/dpatuwo/BuzzBites/foursquare_restaurants/app/assets/images/erd.jpg)
![Brainstorming](https://raw.githubusercontent.com/dpatuwo/BuzzBites/foursquare_restaurants/app/assets/images/brainstorming.jpg)
![Wireframe 1](https://raw.githubusercontent.com/dpatuwo/BuzzBites/foursquare_restaurants/app/assets/images/wireframe.jpg)
![Wireframe 2](https://raw.githubusercontent.com/dpatuwo/BuzzBites/foursquare_restaurants/app/assets/images/wireframe2.jpg)


Before you go, we want you to know that our team had lots of fun working on this app, and we hope you have lots of fun using it.

<3 Mekesia ([@Githubbubber](https://github.com/Githubbubber)), Reggie ([@ReggieKim](https://github.com/reggiekim)), and Victor ([@Koipondkeepers](https://github.com/koipondkeepers)) 

Git Master: David Patuwo ([@DPatuwo](https://github.com/dpatuwo))

Project #3, General Assembly
>>>>>>> 68e4be344c54cc71323c27c8e24ad6a693b94254
