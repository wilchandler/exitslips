require 'csv'


# Standard: type:. grade: code:, decription:,

CSV.foreach("db/ela_standards.csv") do |row|
	unless row.last == nil || row.first[0] == '('
		p standard = Standard.new(subject: "ELA", grade: (/^\d+[-\d]*/).match(row.first).to_s, code: row.first, description: row.last)
		p standard.save unless standard.grade.nil?
		# puts "subject: ELA"
		# puts "grade: #{(/^(?!-)(\d|K)+/).match(row.first).to_s}"
		# puts "code: #{row.first}"
		# puts "description: #{row.last}"
	end
end

CSV.foreach("db/math_standards.csv") do |row|


	unless row.last == nil || row.first[0] == '('
	  p standard = Standard.new(subject: "Math", grade: (/^\d+[-\d]*/).match(row.first).to_s, code: row.first, description: row.last)
	  p standard.save unless standard.grade.nil?
		# puts "subject: Math"
		# puts "grade: #{(/^(?!-)(\d|K)+/).match(row.first).to_s}"
		# puts "code: #{row.first}"
		# puts "description: #{row.last}"
	end
end