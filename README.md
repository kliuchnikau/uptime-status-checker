# Uptime status checker

Check uptime status of major services from the console.

To run this project you going to need Ruby 2.0+. First clone the repository, then run `bundle install` to install the required gems.

Start by running the `status-page.rb` script:

```bash
bundle exec ./status-page.rb
```

# Supported commands

```
Commands:
  status-page.rb backup PATH     # Takes a path variable, and creates a
backup of historic and currently saved data.
  status-page.rb help [COMMAND]  # Describe available commands or one
specific command
  status-page.rb history         # Display all the data which was
gathered by the tool.
  status-page.rb live            # Constantly (every 10 seconds)
query the URLs and output the status periodically on the console and
save it to the data store. Interrupt ...
  status-page.rb pull            # Pull all the status page data from
different providers and save into the data store.
  status-page.rb restore PATH    # Takes a path variable which is a
backup created by the application and restores that data.
```
