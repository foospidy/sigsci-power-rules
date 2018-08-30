# Signal Sciences Power Rules

Rule packs for Signal Sciences power rules platform.

A rule pack is a set of rules config (e.g. Request Rules, Signal Rules, Templated Rules, Advanced Rules, Lists, Custom Signals, and Custom Alerts) that have a specific purpose.

## Deploying a rule pack

todo

## Contributing and Creating a rule pack


### Contributing

To contribute rule packs to this repostory:

1. Fork this repository.
2. Follow the instructions below.
3. Commit your changes.
4. Submit a pull request.

### Creating

1. Create the set of rules in your dashboard.
2. Create a rule pack template using the command: `cd build && make template SITE=<site_containing_rules> NAME=<name-of-rule-pack?`
3. Step to generates the file `templates/<name-of-rule-pack>`, open this file in an editor.
4. For each rule type there is an array, add the rule IDs as an element in the corrosponding array. Example:

```json
{
    "site": "power_rules",
    "name": "graphql-requests",
    "request_rules": [],
    "signal_rules": [],
    "templated_rules": [],
    "advanced_rules": ["5b87e8807a54b364dd11e5d1"],
    "rule_lists": [],
    "custom_signals": ["site.graphiql", "site.graphql-invalid", "site.graphql-request", "site.graphql-dos"],
    "custom_alerts": ["5b87ea0f7a54b364dd11eae0", "5b87ea40b08cd95a8d6d7d63", "5b87ea66b08cd95a8d6d7e5a"]
}
```

5. Generate the rule pack with the command: `cd build && make rulepack NAME=<name-of-rule-pack>`
6. Update the `index.json` file with the details of your rule pack. Example entry:

```json
{
    "name": "graphql-requests",
    "display_name": "GraphQL Requests",
    "description": "Identifies and inspects requests associated with GraphQL. Inspections include: Requests to graphiql, which should never be enabled in production servers, GraphQL requests not properly formatted, Injection attacks on raw graphql posts, Nested queries that could be abused to cause a DoS.",
    "dependency": "None",
    "version": "1.0",
    "category": "Attack Detection",
    "tags": ["attack", "detection", "threat", "visibility", "graphql"]
}
```
