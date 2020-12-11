seats = File.readlines('input.txt').map(&:chomp).map(&:chars)

# Part 1
puts 'Part 1'

def adjacent_seats(seats, row, col)
  rows = [row-1,row,row+1].filter { _1 >= 0 && _1 < seats.length }
  cols = [col-1,col,col+1].filter { _1 >= 0 && _1 < seats.first.length }

  adjacent = rows.map { |r| cols.map { |c| seats[r][c] unless r == row && c == col } }.flatten.compact
end

new_seats = nil

loop do
  new_seats = Marshal.load(Marshal.dump(seats))

  (0...seats.count).each do |row|
    (0...seats.first.count).each do |col|
      seat = seats[row][col]
      if seat == 'L' && adjacent_seats(seats,row, col).filter { _1 == '#' }.empty?
        new_seats[row][col] = '#'
      elsif seat == '#' && adjacent_seats(seats, row, col).filter { _1 == '#' }.count >= 4
        new_seats[row][col] = 'L'
      end
    end
  end

  break if new_seats == seats
  seats = new_seats
end

pp new_seats.flatten.filter { _1 == '#' }.count

# Part 2
puts 'Part 2'

def off_the_edge(seats, row, col)
  return true if row < 0 || col < 0
  return true if row >= seats.length || col >= seats.first.length

  false
end

def visible_seats(seats, row, col)
  directions = [ [1,0], [-1,0], [0,1], [0,-1], [1,1], [1,-1], [-1,-1], [-1,1] ]

  visible = []

  directions.each do |row_d, col_d|
    row_curr = row
    col_curr = col

    while !off_the_edge(seats, row_curr += row_d, col_curr += col_d)
      seat = seats[row_curr][col_curr]
      next if seat == '.'
      visible << seat
      break
    end
  end

  visible
end

seats = File.readlines('input.txt').map(&:chomp).map(&:chars)

new_seats = nil

loop do
  new_seats = Marshal.load(Marshal.dump(seats))


  (0...seats.count).each do |row|
    (0...seats.first.count).each do |col|
      seat = seats[row][col]
      if seat == 'L' && visible_seats(seats,row, col).filter { _1 == '#' }.empty?
        new_seats[row][col] = '#'
      elsif seat == '#' && visible_seats(seats, row, col).filter { _1 == '#' }.count >= 5
        new_seats[row][col] = 'L'
      end
    end
  end

  break if new_seats == seats
  seats = new_seats
end

pp new_seats.flatten.filter { _1 == '#' }.count