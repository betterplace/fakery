# fakery

## Descripton

Faking Ruby objects from JSON API responses

## Usage

### Registering fakes

Automatically register all fakes stored in JSON files under their respective
filenames:

    require 'fakery'
    Fakery.register_files Dir[Rails.root + 'spec/support/fakes/*.json']

### Building fakes

`Fakery.build(:foo)` now builds a fake object for the file named `foo.json` in
the the `spec/support/fakes` directory. `Fakery.build(:foo, with: { bar:
"something" })` builds the fake with its `bar` attribute set to the string
`"something"`.

For integration testing of services you can stub an API response with
`Fakery.build(:the_response).to_json` for your specs.

### Instantiate objects with fake data

`Fakery.instance(:foo, as: TheModel)` instantiates the model TheModel with the
fake's data by passing it as a hash to the model's constructor.
`Fakery.instance(:foo, as: TheModel, with: { bar: "something" })` does the same
with the instances `bar` attribute set to the string `"something"`.

### Seeding fake data from API endpoints

`Fakery.seed('http://api.example.com/foo/bar.json')` returns a fake initialized
from the URL's JSON content.
`Fakery.seed('http://api.example.com/foo/bar.json', register: :foo_bar)` also
registers the fake with the name `foo_bar`.
`Fakery.reseed(:foo_bar)` then reseeds the fake named `foo_bar` from the same
URL.

## Badges

[![Build Status](https://travis-ci.org/betterplace/fakery.svg?branch=master)](https://travis-ci.org/betterplace/fakery)
[![Code Climate](https://codeclimate.com/github/betterplace/fakery.png)](https://codeclimate.com/github/betterplace/fakery)
