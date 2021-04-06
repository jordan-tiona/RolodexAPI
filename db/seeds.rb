5.times do
    Client.create({
        firstname: Faker::Name.first_name,
        lastname: Faker::Name.last_name,
        dateofbirth: Faker::Date.birthday(min_age: 6, max_age: 21),
        address: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state_abbr,
        zipcode: Faker::Address.zip,
        phonenumber: Faker::PhoneNumber.cell_phone,
        lastappointment: Faker::Time.backward(days: 365, period: :morning),
        nextappointment: Faker::Time.forward(days: 365, period: :morning),
        notes: Faker::Lorem.paragraph(sentence_count: 3, random_sentences_to_add: 3, supplemental: true),
        clientof: 1
    })
    Client.create({
        firstname: Faker::Name.first_name,
        lastname: Faker::Name.last_name,
        dateofbirth: Faker::Date.birthday(min_age: 6, max_age: 21),
        address: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state_abbr,
        zipcode: Faker::Address.zip,
        phonenumber: Faker::PhoneNumber.cell_phone,
        lastappointment: Faker::Time.backward(days: 365, period: :morning),
        nextappointment: Faker::Time.forward(days: 365, period: :morning),
        notes: Faker::Lorem.paragraph(sentence_count: 3, random_sentences_to_add: 3, supplemental: true),
        clientof: 2
    })
end