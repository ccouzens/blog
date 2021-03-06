# Blog about what I'm working on

26/03/2019

For my first blog post I'll list out some of the things I am currently doing in
my spare time.

## Starting a Blog

Isn't this meta 😛?

I'm starting a blog for a few reasons. Firstly so I can keep a record on what
I'm doing, and to make it easier to reflect back and keep myself focussed. I'm
liable to get stuck or get caught up in something else and never get back to
what I was doing. I hope the blog can help keep me disciplined and organized.

Second, by having a blog, I can easily blog when I have something to blog about.
I'll have removed the initial hurdle of blogging.

Thirdly, so that I can try out static site generators. I might try a few out if
I don't get on with the first.

Fourth, so that I can practice my writing. I don't often get a chance to write a
lot.

Fifth, to design a website. Previously my usage of HTML and CSS has always been
to implement someone else's design. This will give me an opportunity to create
my own design. It will also give me a chance to try some of the new semantic
HTML5 tags and some of the CSS 3 features and CSS Level 4 features.

## Rust sudoku solver

This is something I'm thinking about. I haven't made any concrete steps towards
doing it. I'd like to write a Sudoku solver web app in Rust.

There are probably many web apps that can already solve Sudoku, but that's not
the point. The point is so that I can try out a web assembly project. I can try
out the [PWA](https://developer.mozilla.org/en-US/docs/Web/Progressive_web_apps)
technologies. The front end would either be JavaScript (most probably TypeScript
with React) or a native Rust DOM library.

I've written a backtracking Sudoku solver
[before](https://github.com/ccouzens/newspaper-puzzle-solvers/blob/master/sudoku.py).
That was able to solve sudokus very quickly. I expect writing in Rust, running
on newer hardware and using heuristics will make this one even faster.

## React tutorial

I'm [working](https://github.com/ccouzens/react-complete-guide)
[through](https://github.com/ccouzens/hamburger-react-project) a
[Udemy course for React](https://www.udemy.com/react-the-complete-guide-incl-redux/learn/v4/content).

I'd recommend it. But as with all learning, challenge things that don't feel
right. For example, contrary to the tutorial you don't need to eject your app to
set up
[CSS modules](https://facebook.github.io/create-react-app/docs/adding-a-css-modules-stylesheet).

## Exercism

[Exercism](https://exercism.io/) is a great website for getting familiar with
various programming languages. They have exercises to work through. After doing
an exercise, you can compare your solution to other people's and reflect on what
you could have done better. Some of the exercises are mentored where you receive
feedback.

I'm working through the 9 different tracks, although I've not made much progress
on about half of them.

Bash: Almost no progress. I'd like to be more comfortable with Bash. It comes up
now and again. I mostly use Bash interactively- I'm not familiar with the
programming language features of Bash (eg control flow and conditions).

C: A couple exercises in. I've written a client/server C program that sent
Kinect depth data and displayed it triple buffered on the receiving end. I
started this track because C is the language that ties all other languages
together. For example Ruby extensions are written in C and many open source
libraries have C headers. I'd like to do as much of that as possible in Rust,
but being familiar with C likely helps.

Elm: A couple exercises in. This appealed to me because it's a functional
language that compiles to JavaScript without inheriting all its idiosyncrasies.

Haskell: Almost no progress, but working on it. I've done some Haskell
previously and I remember it was eye opening. I'm relearning it because I want
to be able to take its pure-function philosophy into other languages. I'm hoping
that will allow me to write programs more amenable to automated tests.

Java: A couple exercises in. I've previously struggled with Java because I
perceive it as limited compared to many other languages and those limitations
get in the way of nice solutions. I'm doing the track in the hope that it might
make me like Java more and as an acknowledgement that a lot of existing software
is written in Java. I submitted a
[pull request](https://github.com/exercism/java/pull/1643) to the track this
morning.

JavaScript: 38% complete of the core exercises. Precisely 1/3 complete on the
side exercises that I've unlocked. It's an unavoidable language, so I may as
well be good at it. It has its warts, but they've not been too difficult to work
around.

Ruby: 100% complete of the core exercises. About 30% complete on the side
exercises. The Ruby mentors are very quick to respond 👍.

I'm a professional Ruby developer. I did this track to see if I might learn
something, and I did learn a couple things.

Rust 😍: 44% complete of the core exercises. 100% of unlocked side exercises
complete.

I'm loving Rust- but I think people have got tired of me advocating it so much.
I consider it a ground breaking language because it's competitive at every level
of the stack. It's competitive with C if you're writing a driver or an operating
system or just want to go as fast as possible. It's as easy (although other
people might dispute) as Ruby or Python. And it runs well in the browser.

TypeScript: 20% complete of core exercises. About 75% complete on the unlocked
side exercises. I prefer TypeScript to JavaScript, because of the enforced
discipline and the better static analysis.

TypeScript and JavaScript are a good pair to do together on Exercism. When they
have exercises in common, one solution can be used by the other with often only
minor modification needed.

## Podcasts

I listen to a few Podcasts:

[Command Line Heroes](https://www.redhat.com/en/command-line-heroes) - a fun
podcast from RedHat and Saron Yitbarek.

[Langsam gesprochene Nachrichten](https://www.dw.com/de/deutsch-lernen/nachrichten/s-8030) -
the news in German. I subscribed in the hope that the exposure to German would
improve my limited German. To be honest, I don't think it's working.

[New Rustacean](https://newrustacean.com/) - my favourite Rust podcast.

[Rusty Spike](https://rusty-spike.blubrry.net/) - Rust news. Doesn't seem to be
updated any longer.

[The Bike Shed](http://bikeshed.fm/) - Programming podcast by thoughtbot. The
discussions are varied, but Ruby is a frequent topic.

[The Yak Shave](http://yakshave.fm/) - Programming podcast by the former hosts
of the Bike Shed. Recent topics include running crates.io and building rubyfmt.

[No such thing as a fish](https://www.nosuchthingasafish.com/) - This is always
a treat. Each episode 4 major facts are presented, and many more are humorously
connected to it.

## Learning Haskell

I'm working through
[Learn You a Haskell for Great Good](http://learnyouahaskell.com/) (what a
title!). I'm not sure how practical Haskell is (because it's very different and
not widely known), but I think learning it will teach me new ways to architect
applications.

## Keycloak swagger

I want to find or create OpenApi 3 specs of
[Keycloak's admin API](https://www.keycloak.org/docs-api/5.0/rest-api/index.html).

There are various references to Swagger in the
[Pom file](https://github.com/keycloak/keycloak/blob/5.0.0/services/pom.xml#L234),
but I'm currently unsure how to make use of them.

Github user illes [has](https://illes.github.io/keycloak/apidocs/)
[some](https://illes.github.io/keycloak/apidocs/service.json)
[version](https://illes.github.io/keycloak/apidocs/Clients.json) 1 specs.
Version 1 is no longer useful, but perhaps it could be updated to a newer
version. I should contact illes to see if they can show me how they were
generated.

## Sonic Mania and Spyro

The games I'm playing.

## Advent of code 2018

This is on the back-burner. Last December I worked through some of
[Advent of Code 2018](https://adventofcode.com/2018) in
[Rust](https://github.com/ccouzens/advent_of_code_2018_rust). I'm intending to
eventually get round to completing it.
