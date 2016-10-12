# UKCloud Portal API Client

## Introduction

Collection and Model representation in ukcloud fog provider.

```no-highlight
todo: describe model
```

### Actions

Every collection supports the following methods:

Method Name       | Lazy Load
----------------- | ---------
get(id)           | false
get_by_name(name) | false
all               | true

## Initialization

```ruby
require 'fog/ukcloud'

ukcloud = Fog::Compute::UKCloud.new(
  :ukcloud_username => "<user email address>",
  :ukcloud_password => "<password>",
  :ukcloud_host => '<portal hostname or omit for default>'
)
```



