
# Un model de testare dragut dar la care am renuntat.
# E mai simplu sa testez direct pe aplicatie urmarind elementele log-ate pe parcurs

require 'crawler_test_helper'
require 'timisoreni_ro_timisoara'

class TimisoreniRoTimisoaraTest < Test::Unit::TestCase
  context 'The crowler' do
    setup do
      @crawler = TimisoreniRoTimisoara.instance
    end

    should 'gather event links' do
      assert !@crawler.event_links.empty?
    end

    should 'propose an event for an event link' do
      @crawler.expects(:propose_event)
      @crawler.propose_event_for('http://www.timisoreni.ro/evenimente/concerte/Nopatea_Italiana_cei_5_tenori_si_orchestra_F.html')
    end
  end
end
