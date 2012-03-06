class Cupid
  VERSION = "0.0.1"
  attr_accessor :pretenders
  attr_accessor :matrix
  attr_accessor :current_round
  attr_accessor :current_round_number

  def initialize
    self.pretenders = []
    self.matrix = []
    self.current_round_number = 0
  end

  def register(pretender)
    self.pretenders ||= []
    self.pretenders << pretender
    self.matrix.each do |row|
      row.push nil
    end
    self.matrix.push([nil] * (pretenders.size-1))
    self.matrix.last.push(-1)
  end

  def add_round
    self.current_round = []
    self.matrix.each_with_index do |row, i|
      row.each_with_index do |score, j|
        unless i == j
          row[j] = (score || self.pretenders.size) + 1
        end
      end
    end
    yield Round.new(self)
    self.current_round_number += 1
  end

  def decide_next_round
    available_pretenders = self.pretenders.dup
    self.current_round = []

    self.add_round do |round|
      self.pretenders.size.times do |i|
        pretender_index = (i + self.current_round_number) % self.pretenders.size

        pretender = self.pretenders[pretender_index]
        next unless available_pretenders.include?(pretender)
        best_candidate = nil
        best_score = 0
        available_pretenders.each do |candidate|
          candidate_index = self.pretenders.index(candidate)
          score = self.matrix[pretender_index][candidate_index]
          if score > best_score
            best_candidate = candidate
            best_score = score
          end
        end

        available_pretenders.delete pretender
        available_pretenders.delete best_candidate

        round.add_couple pretender, best_candidate if pretender and best_candidate
      end
    end
  end

  def current_couple_for(pretender)
    self.current_round.each do |a, b|
      return a if pretender == b
      return b if pretender == a
    end
    nil
  end

  class Round
    attr_accessor :cupid
    def initialize(cupid)
      self.cupid = cupid
    end
    def add_couple(a, b)
      index_a = cupid.pretenders.index(a)
      index_b = cupid.pretenders.index(b)
      cupid.matrix[index_a][index_b] = 0
      cupid.matrix[index_b][index_a] = 0
      cupid.current_round << [a,b]
    end
  end
end
