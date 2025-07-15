# UseParagon

[![example workflow](https://github.com/candanedo/use_paragon/actions/workflows/main.yml/badge.svg)](https://github.com/candanedo/use_paragon/actions?query=branch%3Amain)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/testdouble/standard)

The UseParagon Ruby Gem simplifies the interaction with Paragon's service through RESTful API calls, enabling seamless integration of native features into your Ruby applications. With this gem, engineering teams can effortlessly incorporate Paragon's API to accelerate the development of native integrations.

| API Method                     | HTTP Method | Supported |
|--------------------------------|-------------|-----------|
| Disable Workflow               |    DELETE   |    ✅     |
| Get Integrations Metadata      |    GET      |    ✅     |
| Get User                       |    GET      |    ✅     |
| Workflow Event (App Events)    |    POST     |    ✅     |
| Proxy Request                  |    -        |    ✅     |
| Set User Metadata              |    PATCH    |    ✅     |
| Uninstall Integration          |    DELETE   |    ✅     |
| Workflow Request (Trigger)     |    POST     |    ✅     |
| Get Project's Integrations     |    GET      |    ✅     |
| Get User's Connect Credentials |    GET      |    ✅     |
| Task History API               |    -        |    ❌     |

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
  # Additional configurations available and defaults.
  # config.base_url = "https://zeus.useparagon.com"  # Change this for on-prem installations
  # config.logger = Logger.new(STDOUT)
  # config.logger_enabled = true
end
```

### On-Premise Installations

For on-premise Paragon installations, you can configure a custom base URL:

```ruby
UseParagon.configure do |config|
  config.private_key = YOUR_PRIVATE_KEY
  config.project_id = YOUR_PROJECT_ID
  config.base_url = "https://paragon.yourcompany.com"  # Your on-prem Paragon instance
end
```

## How to use
### Disable Workflow
[Paragon Documentation](https://docs.useparagon.com/api/api-reference#disableworkflow-workflowid-string-greater-than-promise)

Call disable Workflow to turn off a workflow for a user by ID.

    UseParagon::Workflow.new(user_id).disable("workflow_id")

### Get Integrations Metadata
[Paragon Documentation](https://docs.useparagon.com/api/api-reference#getintegrationmetadata)

Get the name, brandColor, and icon, for any of your active integration providers.

    UseParagon::Integration.new(user_id).metadata

### Get User
[Paragon Documentation](https://docs.useparagon.com/api/api-reference#getuser-paragonuser)

Retrieve the currently authenticated user and their connected integration state.

    UseParagon::User.new(user_id).get

### Workflow Event (App Events)
[Paragon Documentation](https://docs.useparagon.com/api/api-reference#event-name-string-json-json)

App Events can be sent from your application using the Paragon REST API.

    UseParagon::Workflow.new(user_id).event(event_name, payload = {})

You can also pass custom headers:

    UseParagon::Workflow.new(user_id).event(event_name, payload = {}, headers: { "X-Custom-Header" => "value" })

### Proxy Request 
[Paragon Documentation](https://docs.useparagon.com/api/api-reference#request-integrationtype-string-path-string-requestoptions-requestinit-promise-less-than-unknown-gre)

Call proxy_request to send an API request to a third-party integration on behalf of one of your users

This endpoint accepts any HTTP verb you want to use with the API:
post, get, put, patch or delete.

    UseParagon::Integration.new(user_id).proxy_request(request_method, integration_type, integration_path, payload = {})

### Set User Metadata
[Paragon Documentation](https://docs.useparagon.com/api/api-reference#setusermetadata-meta-object)

Associate the authenticated user with metadata from your application. This metadata can be accessed with "Get User"

    UseParagon::User.new(user_id).metadata=({email: "example@example.com"})

### Uninstall Integration
[Paragon Documentation](https://docs.useparagon.com/api/api-reference#workflow)

Disconnect an integration for the authenticated user

    UseParagon::Integration.new(user_id).uninstall(integration_id)

### Workflow Request (Trigger)
[Paragon Documentation](https://docs.useparagon.com/api/api-reference#workflow-1)

Trigger a Paragon workflow that sends a custom response back to your app. Note: The workflow must be enabled and use a Request-type trigger.

    UseParagon::Workflow.new(user_id).request(workflow_id, payload = {})

You can also pass custom headers:

    UseParagon::Workflow.new(user_id).request(workflow_id, payload = {}, headers: { "X-Custom-Header" => "value" })

### Get Project's Integrations
[Paragon Documentation](https://docs.useparagon.com/api/api-reference#get-projects-integrations)

Returns a list of the integrations enabled for the Paragon project by the ID in the URL. 

    UseParagon::Integration.new(user_id).list

### Get User's Connect Credentials
[Paragon Documentation](https://docs.useparagon.com/api/api-reference#get-users-connect-credentials)

Returns a list of the user's Connect credentials (i.e., the accounts connected and authorized by the end user).

    UseParagon::User.new(user_id).credentials

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/candanedo/use_paragon. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/candanedo/use_paragon/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the UseParagon project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/candanedo/use_paragon/blob/main/CODE_OF_CONDUCT.md).
