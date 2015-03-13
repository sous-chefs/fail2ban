This cookbook includes support for running tests via Test Kitchen. This has some requirements.

1. You must be using the Git repository, rather than the downloaded cookbook from the Supermarket Site.
2. You must have Vagrant 1.1+ installed.
3. You must have a "sane" Ruby 1.9.3+ environment.

Once the above requirements are met, install the additional requirements:

Install the berkshelf plugin for vagrant to your local environment.

    vagrant plugin install vagrant-berkshelf

Install Test Kitchen and Berkshelf

    bundle install

Once the above are installed, you should be able to run Test Kitchen:

    bundle exec kitchen list
    bundle exec kitchen test
