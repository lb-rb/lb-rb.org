# frozen_string_literal: true

module Screenshots
  def step(name, tag)
    return unless ENV.key?('SCREENSHOTS')
    saver = Capybara::Screenshot.new_saver(
      Capybara,
      Capybara.page,
      true, # save html
      ['screenshot', name, tag].join('_')
    )

    return unless saver.save && ENV.key?('DEBUG')

    puts "Save HTML to: file://#{saver.html_path}"
    puts "Save Image to: file://#{saver.screenshot_path}"
  end
end
