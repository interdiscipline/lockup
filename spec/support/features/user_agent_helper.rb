module UserAgentHelper
  DEFAULT_USER_AGENT = 'Capybara Rack/Test'

  def reset_user_agent
    set_user_agent_to(DEFAULT_USER_AGENT)
  end

  def set_user_agent_to(user_agent)
    page.driver.browser.header('User-Agent', user_agent)
  end
end
