# Cupid

Cupid is a Ruby library to generate rotations for pair-programming teams.


# Initialize your cupid

    cupid = Cupid.new

# Add your team members

    cupid.register 'John'
    cupid.register 'Bruce'
    # ...

# Define round manually

A round is a set of pairs. If your team changes pairs every day, a round is a day.

	cupid.add_round do |round|
	  round.add_couple 'John', 'Bruce'
	  round.add_couple 'Mathew', 'Jimmy'
	  # ...
	end

# Auto-generate the next round

	cupid.decide_next_round

# Check the pair of each member

	john_couple = cupid.current_couple_for('John')
	bruce_couple = cupid.current_couple_for('Bruce')
	# ...

