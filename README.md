# Lockup

“Can I come into your fort?”

“…what's the codeword?”

## Installation

1. Add this line to your application's Gemfile:

        gem 'lockup'

2. Next, add this line to your routes.rb:**

        mount Lockup::Engine, at: '/lockup'

  **This step may be unnecessary—depends on your config/routes.rb setup.
        
3. Define a codeword (see Usage below).

## Usage

To set a codeword, define LOCKUP_CODEWORD in your environments/your_environment.rb file like so:

    ENV["LOCKUP_CODEWORD"] = 'secret'

If you're using [Figaro](https://github.com/laserlemon/figaro), set your lockup codeword in your application.yml file:

    LOCKUP_CODEWORD: "love"
    
**Codewords are not case-sensitive, by design. Keep it simple.**

### Link it with no typing:

    http://somedomain.com/or_path/?lockup_codeword=love
    
The visitor is redirected and the cookie is set without them ever seeing the Lockup splash page.
