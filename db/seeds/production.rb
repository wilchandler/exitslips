require 'csv'

CSV.foreach("db/ela_standards.csv") do |row|
	unless row.last == nil || row.first[0] == '('
		standard = Standard.new(subject: "ELA", grade: (/^(?!-)(\d+|K)/).match(row.first).to_s, code: row.first, description: row.last)
		standard.save unless standard.grade.nil?
	end
end

CSV.foreach("db/math_standards.csv") do |row|
	unless row.last == nil || row.first[0] == '('
	  standard = Standard.new(subject: "Math", grade: (/^(?!-)(\d+|K)/).match(row.first).to_s, code: row.first, description: row.last)
	  standard.save unless standard.grade.nil?
	end
end