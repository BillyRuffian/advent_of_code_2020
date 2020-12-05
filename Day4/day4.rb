require_relative 'passport'

def passports_from(file, klass:)
  passports = []
  passports << passport = klass.new

  values = File.foreach(file) do |line|
    if line.chomp.empty?
      passports << passport = klass.new
    else
      line.split(' ')
        .each do |values|
          values.split(':').then{ |field, value| passport.send( "#{field}=", value ) }
        end
    end
  end
  passports
end


# Part 1
puts 'Part 1'

puts passports_from('input.txt', klass: Passport).filter(&:valid?).count


# Part 2
puts 'Part 2'

puts passports_from('input.txt', klass: Passport2).filter(&:valid?).count