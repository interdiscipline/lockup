# Lockup

"Can I come into your fort?"

"...what's the password?"

## Installation

1. Clone the repo to a local folder
2. Add this line to your application's Gemfile:

        gem 'lockup', path: 'your/path/to/lockup'

3. Finally, add this line to your routes.rb:

        mount Lockup::Engine, at: '/lockup'

If you're using Figaro, set your lockup password like so:

    LOCKUP_CODEWORD: "love"

## Contributing

1. Fork it
2. Improve it
3. Request a Pull
