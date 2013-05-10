# Lockup

“Can I come into your fort?”

“…what's the codeword?”

## Installation

1. Clone the repo to a local folder
2. Add this line to your application's Gemfile:

        gem 'lockup', path: 'your/path/to/lockup'

3. Finally, add this line to your routes.rb:

        mount Lockup::Engine, at: '/lockup'

## Usage

To set a codeword, define LOCKUP_CODEWORD in your environments/your_environment.rb file like so:

    ENV["LOCKUP_CODEWORD"] = 'secret'

If you're using Figaro, set your lockup codeword in your application.yml file:

    LOCKUP_CODEWORD: "love"
    
**Codewords are not case-sensitive, by design. Keep it simple.**

### Link it with no typing:

    http://somedomain.com/or_path/?lockup_codeword=love
    
The visitor is redirected and the cookie is set without them ever seeing the Lockup splash page.
