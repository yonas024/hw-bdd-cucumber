# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    @t = movie["title"]
    @r = movie["rating"]
    @rd = movie["release_date"]
    
    # puts movie
    Movie.create("title":@t, "rating":@r)
  end
  # fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  
  
  # count = 0
  # page.body('td').each do |td|
  #   puts td.text
  #   if e1 == td.text and count == 0
  #     count = 1
  #   end
  #   if e2 == td.text and count == 0
  #     count = 2
  #   end
  # end
  # count.should be 1
  # first = page.body.index(S1) or return false
  # second = page.body.index(S2, first) or return false
  # true
  # assert false
  puts page.body
  bool = true
  bool.should be page.body.index(e1) < page.body.index(e2)
  
  
  
  # fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |un, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  if un
    for r in rating_list.split
      uncheck("ratings[" + r + "]")
    end
  else
    for r in rating_list.split
      check("ratings[" + r + "]")
    end
  end
  # fail "Unimplemented"
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  
  # Movie.count.should be 10
  count = -1
  page.all('tr').each do |tr|
    count += 1
  end
  
  Movie.count.should be count
  
  # fail "Unimplemented"
end
