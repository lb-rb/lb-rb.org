# frozen_string_literal: true

module SessionScenario
  def session_scenario(*args, &block)
    scenario(*args) do
      session do
        instance_eval(&block)
      end
    end
  end

  def xsession_scenario(*args, &block)
    xscenario(*args) do
      session do
        instance_eval(&block)
      end
    end
  end
end
