
# Json Logic Humanizable

**Translate JsonLogic rules into readable sentences.** Extension for [JsonLogic](https://jsonlogic.com/).

⚙️ Zero deps · 🛠️ Configurable · 🧩 Mixin + Wrapper

[![Gem Version](https://img.shields.io/gem/v/json_logic_humanizable.svg)](https://rubygems.org/gems/json_logic_humanizable) [![Docs](https://img.shields.io/badge/docs-rubydoc.info-blue)](https://www.rubydoc.info/gems/json_logic_humanizable) [![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)



## What

This gem converts JsonLogic Rules into readable sentences.
- A mixin for serializer/presenter classes.
- A small wrapper for one-off translations.

No dependencies. Works with a Ruby Hash.

## How

Config => operators map + variables map
Input  => JsonLogic Rule (Hash )
Output => human-readable sentence



## Where

If you found this gem, you likely already know where to use it in your app — the abstract use case is simple: you want to read a Rule as text (e.g., show it in the UI, preview it, or share it elsewhere).

## Installation

### Plain Ruby
```bash
gem install json_logic_humanizable
```

### Rails (Bundler)
Add to your `Gemfile` if you need:

```ruby
gem "json_logic_humanizable"
```

Then install:

```bash
bundle install
```

Configuration (if needed)
```ruby
# config/initializers/json_logic.rb

require "json_logic"

# Config
```

## Examples


### Easy – Quick Start
```ruby
logic = {
  "and" => [
    { ">=" => [ { "var" => "payment.amount" }, 50 ] },
    { "in" => [ { "var" => "payment.currency" }, %w[EUR USD] ] }
  ]
}

puts JsonLogic::Rule.new(logic).humanize
```

Example output:
```
payment.amount is greater than or equal to 50 AND payment.currency is in EUR, USD
```

### Complex – With Config

```ruby

JsonLogic::Config.operators["in"] = "is one of"

JsonLogic::Config.vars[/([^\.]+)$/] =  ->(m) { m[1].tr("_", " ").split.map(&:capitalize).join(" ") }

logic = {
  "and" => [
    { ">=" => [ { "var" => "payment.amount" }, 50 ] },
    { "fact" => "payment.currency", "operator" => "in", "value" => %w[EUR USD] }
  ]
}

puts JsonLogic::Rule.new(logic).humanize
```

Example output:
```
Amount is greater than or equal to 50 AND Currency is one of ["EUR", "USD"]
```

### Mixin – Humanizable in serializers

```ruby
class RuleSerializer
  include JsonLogic::Humanizable

  attr_reader :json_logic

  def initialize(json_logic)
    @json_logic = json_logic
  end

   def condition
      humanize_logic(json_logic)
   end
end

s = RuleSerializer.new({
  "and" => [
    { ">=" => [ { "var" => "payment.amount" }, 50 ] },
    { "in" => [ { "var" => "payment.currency" }, %w[EUR USD] ] }
  ]
})

puts s.condition
```
Example output:
```
payment.amount is greater than or equal to 50 AND payment.currency is in EUR, USD
```

## Configuration

### Operators mapping

Configure labels as you prefer:

```ruby
JsonLogic::Config.operators["in"]  = "is one of"
JsonLogic::Config.operators["=="]  = "equals"
JsonLogic::Config.operators[">="]  = "is at least"
JsonLogic::Config.operators["!"]   = "NOT"
JsonLogic::Config.operators["and"] = "AND"
JsonLogic::Config.operators["or"]  = "OR"
```

### Variables mapping

Each entry is key  – **pattern**,  value – **replacement**, where **pattern** is a `Regexp` or exact `String`, and **replacement** is a `String` or `Proc`.

```ruby
JsonLogic::Config.vars[/([^\.]+)$/] =  ->(m) { m[1].tr("_", " ").split.map(&:capitalize).join(" ") }
```

This maps `payment.amount` → `Amount`, `customer.country` → `Country`, etc.

## Links

- JsonLogic site: https://jsonlogic.com/
