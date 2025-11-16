


# MacheteDemo

This project serves as a demo / tutorial for the
[Machete](https://hexdocs.pm/machete/Machete.html) library. It is structured as
a set of failing tests which you can work through to learn about Machete's
features in a progressive manner.

## Running The Demo

Since this demo is structured as a set of tests, running it is as easy as
running any suite of ex_unit tests:

```elixir
git clone git@github.com/drylikov/machete_demo
cd machete_demo
mix deps.get
mix test
```

At this point you should see a single failing test (`TEST 1: literals`). Open up
`test/machete_demo_test.exs` in your editor and follow along to the instructions
therein. Once you make your way to the end of that file, you're done!
