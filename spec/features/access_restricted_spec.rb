# encoding: utf-8
require 'spec_helper'

describe "Accessing a page in the application" do

  def enter_code_word(code_word)
    fill_in 'code word', with: code_word
    click_on 'Go'
  end

  before { reset_user_agent }

  context "without a configured code word" do
    before { ENV.delete('LOCKUP_CODEWORD') }

    it "displays the requested page" do
      visit '/posts'

      current_path.should == '/posts'

      page.should have_content('Title One')
      page.should have_content('Title Two')
    end
  end

  context "with a configured code word" do
    before { ENV['LOCKUP_CODEWORD'] = 'OMGponies' }

    it "redirects to the password entry screen" do
      visit '/posts'

      current_path.should start_with('/lockup/unlock')

      page.should_not have_content('Title One')
      page.should_not have_content('Title Two')

      page.should have_content('Please enter the code word to continue…')
    end

    it "allows access to the requested page when the correct code word is supplied" do
      visit '/posts'

      enter_code_word('omgponies')

      current_path.should == '/posts'

      page.should have_content('Title One')
      page.should have_content('Title Two')
    end

    it "does not allow access when the incorrect code word is supplied" do
      visit '/posts'

      enter_code_word('lolwut')

      page.should have_content('Hmm… that doesn’t seem right. Try again?')

      current_path.should_not == '/posts'

      page.should_not have_content('Title One')
      page.should_not have_content('Title Two')
    end

    it "allows direct access with a code in the URL" do
      visit '/posts?lockup_codeword=omgponies'

      page.should have_content('Title One')
      page.should have_content('Title Two')

      click_on 'Title One'

      within('h2') { page.should have_content 'Title One' }
      page.should have_content('Body One')
    end

    it "rejects direct access with an invalid code in the URL" do
      visit '/posts?lookup_codeword=lolwut'

      page.should have_content('Please enter the code word to continue…')

      current_path.should_not start_with('/posts')

      page.should_not have_content('Title One')
      page.should_not have_content('Title Two')
    end

    it "renders nothing when hit by a crawler using a valid code" do
      set_user_agent_to('Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)')

      visit '/posts?lockup_codeword=omgponies'

      page.body.should be_blank

      reset_user_agent
    end

    it "works with a catch all route" do
      visit '/this-does-not-exist?lockup_codeword=omgponies'

      page.status_code.should == 404
    end

    context "with a configured hint" do
      it "displays the hint to the user" do
        ENV['LOCKUP_HINT'] = 'Cute 4-legged animals'

        visit '/posts'

        within('#hint')  { page.should have_content('Cute 4-legged animals') }

        ENV.delete('LOCKUP_HINT')
      end
    end

    context "without a user agent" do
      before(:each) do
        set_user_agent_to(nil)
      end

      it "doesn't blow up" do
        visit '/posts?lockup_codeword=omgponies'
      end
    end
  end
end
