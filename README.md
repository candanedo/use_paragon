# UseParagon

[![example workflow](https://github.com/candanedo/use_paragon/actions/workflows/main.yml/badge.svg)](https://github.com/candanedo/use_paragon/actions?query=branch%3Amain)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/testdouble/standard)

The UseParagon Ruby Gem simplifies the interaction with Paragon's service through RESTful API calls, enabling seamless integration of native features into your Ruby applications. With this gem, engineering teams can effortlessly incorporate Paragon's API to accelerate the development of native integrations.

| API Method                     | REST Method | Supported |     Gem's Class         |                                   Method                                        |
|--------------------------------|-------------|-----------|-------------------------|---------------------------------------------------------------------------------|
| Disable Workflow               |    DELETE   |    [x]    | UseParagon::Workflow    | disable(workflow_id)                                                            |
| Get Integrations Metadata      |    GET      |    [x]    | UseParagon::Integration | metadata                                                                        |
| Get User                       |    GET      |    [x]    | UseParagon::User        | get                                                                             |
| Workflow Event (App Events)    |    POST     |    [x]    | UseParagon::Workflow    | event(event_name, payload = {})                                                 |
| Proxy Request                  |             |    [x]    | UseParagon::Workflow    | proxy_request(request_method, integration_type, integration_path, payload = {}) |
| Set User Metadata              |    PATCH    |    [x]    | UseParagon::User        | metadata=(metadata)                                                             |
| Uninstall Integration          |    DELETE   |    [x]    | UseParagon::Integration | uninstall(integration_id)                                                       |
| Workflow Request (Trigger)     |    POST     |    [x]    | UseParagon::Workflow    | request(workflow_id, payload = {})                                              |
| Get Project's Integrations     |    GET      |    [x]    | UseParagon::Integration | list                                                                            |
| Get User's Connect Credentials |    GET      |    [x]    | UseParagon::User        | credentials                                                                     |

## Installation

Add the gem to your application's Gemfile by executing:

    $ bundle add use_paragon

or manually add it to the Gemfile:

    gem "use_paragon"

Then run:

    bundle install

If Bundler is not used to manage dependencies, install the gem with:

    $ gem install use_paragon

## Configuration

To use the UseParagon gem, you need to configure it with your private key and project ID. Here's an example on how to do it:

Provide your private key and project ID:

```ruby
UseParagon.configure do |config|
  config.private_key = YOUR_PRIVATE_KEY
  config.project_id = YOUR_PROJECT_ID
end
```

### Workflow triggers
#### Request trigger

The Request trigger can be used to run workflows by sending it an HTTP request. To trigger a workflow request, use the following code:

    UseParagon::Workflow.new(user_id).request("workflow_id", {})

Here, the first parameter is the endpoint of the workflow trigger, and the second one is the payload the workflow expects.

#### Event trigger

App Events are custom events that are sent programmatically from your application via the Paragon SDK or API to trigger Workflows. To trigger a workflow event, use the following code:

    UseParagon::Workflow.new(user_id).event("Create Contact", {})

Here, the first parameter is the App event, and the second one is the payload the workflow expects.

### User API

Retrieve the currently authenticated user and their connected integration state.

    UseParagon::User.new(user_id).get

### Integration API

Get the name, brandColor, and icon, for any of your active integration providers.

    UseParagon::Integration.new(user_id).metadata

Returns a list of the integrations enabled for the Paragon project by the ID in the URL.

    UseParagon::Integration.new(user_id).list

Integrations can be disconnected using paragon.uninstallIntegration or with the REST API with:

    UseParagon::Integration.new(user_id).uninstall(integration_id)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/candanedo/use_paragon. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/candanedo/use_paragon/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the UseParagon project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/candanedo/use_paragon/blob/main/CODE_OF_CONDUCT.md).
