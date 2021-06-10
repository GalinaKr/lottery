class LotteriesController < ApplicationController
  def index; end

  def result
    filename = 'input.txt'
    data = {}

    File.open(filename).each do |line|
      line = line.strip.split ','
      data[line[0].to_s+ ','+line[1].to_s+','+line[2].to_s] = line.last.to_s
    end

    winning_number = params[:winning_number]
    result = []

    data.each do |d|
      res = Array.new(winning_number.length + 1) {Array.new(d[1].length + 1, '')}

      winning_number.each_char.with_index do |win, i|
        d[1].each_char.with_index do |d1, j|
          res[i+1][j+1] = if win == d1
                            res[i][j] + win
                          else
                            [res[i][j+1], res[i+1][j]].max_by(&:length)
                          end
        end
      end

      credits = res[-1][-1].length

      if credits > 0
        result << d[0] + ',' + credits.to_s
      end


    end

    @result = result
  end
end
