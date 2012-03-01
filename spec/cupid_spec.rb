require 'spec_helper'

describe Cupid do
  it 'calculates couples based on previous couples' do
    subject.register 'John'
    subject.register 'Marie'
    subject.register 'Bruce'
    subject.register 'Melanie'

    subject.add_round do |round|
      round.add_couple 'John', 'Marie'
      round.add_couple 'Bruce', 'Melanie'
    end

    subject.add_round do |round|
      round.add_couple 'John', 'Bruce'
      round.add_couple 'Marie', 'Melanie'
    end

    subject.decide_next_round

    subject.current_couple_for('John').should == 'Melanie'
    subject.current_couple_for('Marie').should == 'Bruce'
    subject.current_couple_for('Bruce').should == 'Marie'
    subject.current_couple_for('Melanie').should == 'John'
  end

  it 'supports odd pretenders' do
    subject.register 'John'
    subject.register 'Marie'
    subject.register 'Bruce'

    subject.add_round do |round|
      round.add_couple 'John', 'Marie'
    end

    subject.decide_next_round

    subject.current_couple_for('John').should == nil
    subject.current_couple_for('Marie').should == 'Bruce'
  end

  it 'rotates' do
    subject.register 'John'
    subject.register 'Marie'
    subject.register 'Bruce'

    subject.add_round do |round|
      round.add_couple 'John', 'Marie'
    end

    expect{
      subject.decide_next_round
    }.to change{subject.current_couple_for('John')}.from('Marie').to(nil)
    expect{
      subject.decide_next_round
    }.to change{subject.current_couple_for('John')}.from(nil).to('Bruce')
    expect{
      subject.decide_next_round
    }.to change{subject.current_couple_for('John')}.from('Bruce').to('Marie')
    
  end

end