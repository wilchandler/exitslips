FactoryGirl.define do
  factory :teacher do
  	first_name 'Teacher'
  	last_name 'McTeacher'
    email 'teacher@example.com'
    password 'f4k3p455w0rd'
  end

  factory :student do
  	first_name 'Student'
  	last_name 'McStudent'
    email 'student@example.com'
    password 'f4k3p455w0rd'
  end
end
