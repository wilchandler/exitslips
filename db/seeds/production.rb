require 'csv'


# Standard: type:. grade: code:, decription:,

CSV.foreach("db/ela_standards.csv") do |row|
	unless row.last == nil || row.first[0] == '('
	# standard = Standard.new(type: "ELA", grade: (/^\d+[-\d]*/).match(row.first).to_s, code: row.first, description: row.last)
	# standard.save unless standard.grade.nil?
		puts "type: ELA"
		puts "grade: #{(/^\d+[-\d]*/).match(row.first).to_s}"
		puts "code: #{row.first}"
		puts "description: #{row.last}"
	end
end

CSV.foreach("db/math_standards.csv") do |row|


	unless row.last == nil || row.first[0] == '('
	# standard = Standard.new(type: "ELA", grade: (/^\d+[-\d]*/).match(row.first).to_s, code: row.first, description: row.last)
	# standard.save unless standard.grade.nil?
		puts "type: ELA"
		puts "grade: #{(/^\d+[-\d]*/).match(row.first).to_s}"
		puts "code: #{row.first}"
		puts "description: #{row.last}"
	end
end