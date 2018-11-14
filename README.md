# battleshift

Battleshift is an api interface to play the game battleshift built in Ruby on Rails. 

This project was a 'brown field' project where we inherited an existing code base for a one player game with no external interface and no win condition validations. We built the API interface, win validation, and two player functionality while fixing and improving the existing code base. We found that a large percentage of the code base was untested and unused, we removed any code that was not necessary and wrote tests for the existing code base. Testing went from 30% to 90%+.

This project also used a [spec harness](https://github.com/turingschool-examples/battleshift_spec_harness) for evaluation. 

## to run locally

1. clone the repo
2. bundle `bundle && bundle update`
3. create the database `rake db:{create,migrate,seed}`
4. start rails `rails s`
