## CkochBot

My attempt to document as I code this project.

CkochBot is a twitter-bot that aims to tweet-back at people based on a number of predefined topics. It also aims to use a very simple Markov Chain dictionary and compose some original tweets and append nonesense hashtags to the tweets.

2015-09-20-21-35-00
I am keeping my implementation as bare bones as possible and trying to use very few of the Rails things that we often use (ActiveRecord, controllers, models, views, etc.) Realistically this could probably be done with Sinatra for an even lighter app, but I also want to work quickly. Since Rails is where I buttter most of my bread, it's a rails project.

Gems used:
 * markovian (to generate Markov Chains)
 * twitter (twitter-api gem)
 * figaro (source ENV vars and keep them out of vsource control)



Changes to implement:
  Search by an array of terms.
  Reply with a markov message
  Search trending topics (Stream)
  Improve Markov Dictionary