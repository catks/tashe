# Tashe - The Talk Scheduler

Tashe is a scheduler for conferences it receives a file with talks as input and schedule a conference with tracks.

### Installation
To install clone this repository:
```sh
$ git clone https://github.com/catks/tashe
```

Run bundler:
```sh
$ bundle install
```

Run rake to see all tests pass (optional)
```sh
$ rake
```

And you are ready to go!

### Usage

You can execute tashe running with ruby and passing a text file as input

```sh
ruby tashe.rb input.txt    
```

Supposing that input.txt content is:
```
Writing Fast Tests Against Enterprise Rails 60min
Overdoing it in Python 45min
Lua for the Masses 30min
Ruby Errors from Mismatched Gem Versions 45min
Common Ruby Errors 45min
Rails for Python Developers lightning
Communicating Over Distance 60min
Accounting-Driven Development 45min
Woah 30min
Sit Down and Write 30min
Pair Programming vs Noise 45min
Rails Magic 60min
Ruby on Rails: Why We Should Move On 60min
Clojure Ate Scala (on my project) 45min
Programming in the Boondocks of Seattle 30min
Ruby vs. Clojure for Back-End Development 30min
Ruby on Rails Legacy App Maintenance 60min
A World Without HackerNews 30min
User Interface CSS in Rails Apps 30min
```

The output will be:
```
Track 1:
09:00AM Writing Fast Tests Against Enterprise Rails
10:00AM Overdoing it in Python
10:45AM Lua for the Masses
11:15AM Ruby Errors from Mismatched Gem Versions
12:00PM Lunch
01:00PM Common Ruby Errors
01:45PM Rails for Python Developers
01:50PM Communicating Over Distance
02:50PM Accounting-Driven Development
03:35PM Woah
04:05PM Sit Down and Write
04:45PM Networking Event

Track 2:
09:00AM Pair Programming vs Noise
09:45AM Rails Magic
10:45AM Ruby on Rails: Why We Should Move On
12:00PM Lunch
01:00PM Clojure Ate Scala (on my project)
01:45PM Programming in the Boondocks of Seattle
02:15PM Ruby vs. Clojure for Back-End Development
02:45PM Ruby on Rails Legacy App Maintenance
03:45PM A World Without HackerNews
04:15PM User Interface CSS in Rails Apps
04:45PM Networking Event
```


