## Moodwall: A simple CLI tool aimed to help manage wallpapers.

[![Build Status](https://travis-ci.org/vmikhaliuk/moodwall.svg?branch=master)](https://travis-ci.org/vmikhaliuk/moodwall)
[![Maintainability](https://api.codeclimate.com/v1/badges/ad73e69778bb4b5dcbdb/maintainability)](https://codeclimate.com/github/vmikhaliuk/moodwall/maintainability)
[![Coverage Status](https://coveralls.io/repos/github/vmikhaliuk/moodwall/badge.svg?branch=master)](https://coveralls.io/github/vmikhaliuk/moodwall?branch=master)
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](http://www.gnu.org/licenses/gpl-3.0)

![Alt text](assets/meme.jpg?raw=true)

## Installation

Install it yourself as:

$ gem install moodwall

## Usage examples

``` shell
<!-- First of all, you need to add some moods -->

moodwall -a -m Winter

<!-- Then you should be able to add wallpapers -->

moodwall -a -w ~/Pictures/wallpaper/mountains.jpeg -m Winter

<!-- To change wallpaper use -->

moodwall -c -w or simply moodwall, since its a default option.

<!-- To change current mood use: -->

moodwall -c -m Winter
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vmikhaliuk/moodwall. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the Moodwall project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/vmikhaliuk/moodwall/blob/master/CODE_OF_CONDUCT.md).
