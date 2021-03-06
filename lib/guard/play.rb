require 'guard'
require 'guard/guard'
require 'faraday'
module Guard
  class Play < Guard

    def test name
      conn = Faraday::Connection.new "http://localhost:9000"
      r = conn.get "/@tests/#{name.gsub('/','.')}.class"
      passed = r.status == 200 ? true : false
      message = "Test #{name} #{passed ? 'passed' : 'failed'}."
      image = passed ? :success : :failed
      ::Guard::UI.info message
      ::Guard::Notifier.notify(message, :title => "Guard::Play", :image => image)
    end

    # Initialize a Guard.
    # @param [Array<Guard::Watcher>] watchers the Guard file watchers
    # @param [Hash] options the custom Guard options
    def initialize(watchers = [], options = {})
    @options = {
    :notifications => true
      }.merge(options)
    super(watchers, @options)
    end

    def init
    end

    # Call once when Guard starts. Please override initialize method to init stuff.
    # @raise [:task_has_failed] when start has failed
    def start
    end

    # Called when `stop|quit|exit|s|q|e + enter` is pressed (when Guard quits).
    # @raise [:task_has_failed] when stop has failed
    def stop
    end

    # Called when `reload|r|z + enter` is pressed.
    # This method should be mainly used for "reload" (really!) actions like reloading passenger/spork/bundler/...
    # @raise [:task_has_failed] when reload has failed
    def reload
    end

    # Called when just `enter` is pressed
    # This method should be principally used for long action like running all specs/tests/...
    # @raise [:task_has_failed] when run_all has failed
    def run_all
    end

    # Called on file(s) modifications that the Guard watches.
    # @param [Array<String>] paths the changes files or paths
    # @raise [:task_has_failed] when run_on_change has failed
    def run_on_changes(paths)
      paths.each do |file|
        ::Guard::UI.info "Testing #{file}."
        test file
      end
    end

    # Called on file(s) deletions that the Guard watches.
    # @param [Array<String>] paths the deleted files or paths
    # @raise [:task_has_failed] when run_on_change has failed
    def run_on_removals(paths)
    end

  end
end