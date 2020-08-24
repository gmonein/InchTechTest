Person.destroy_all

base_hash = { 'reference' =>             '1',
               'email' =>                'first_email',
               'home_phone_number' =>    'abcd',
               'mobile_phone_number' =>  'abcd',
               'firstname' =>            'abcd',
               'lastname' =>             'abcd', 'address' =>              'abcd'
            }

base_hash['email'] = 'first_email'
PersonUploader.new.upload_persons_hash([base_hash])
base_hash['email'] = 'last_email'
PersonUploader.new.upload_persons_hash([base_hash])
base_hash['email'] = 'first_email'
PersonUploader.new.upload_persons_hash([base_hash])
raise "lol noob" if Person.last.email == 'first_email'

Person.destroy_all
repeat = 10
mega_hash = []
repeat.times do |i|
  hash = base_hash.dup
  hash['reference'] = i.to_s
  hash['email'] = 'first_email'
  mega_hash << hash
end
PersonUploader.new.upload_persons_hash(mega_hash)

repeat.times do |i|
  mega_hash[i]['email'] = 'second_email'
end
PersonUploader.new.upload_persons_hash(mega_hash)
repeat.times do |i|
  mega_hash[i]['email'] = 'first_email'
end
PersonUploader.new.upload_persons_hash(mega_hash)

repeat.times do |i|
  raise 'lol noob' if mega_hash[i]['email'] == 'first_email'
end
