# UseParagon

The UseParagon Ruby Gem simplifies the interaction with Paragon's service through RESTful API calls, enabling seamless integration of native features into your Ruby applications. With this gem, product and engineering teams can effortlessly incorporate Paragon's SDK and embedded Integration Platform as a Service (iPaaS) to accelerate the development of native integrations.

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

To use the UseParagon gem, you need to configure it with your private key and project ID. Here's how to do it:

#### For Rails
Create a new initializer in your Rails project:

    touch config/initializers/use_paragon.rb

Provide your private key and project ID in the initializer:

```ruby
# config/initializers/use_paragon.rb

UseParagon.configure do |config|
  config.private_key = Rails.application.credentials.paragon.private_key
  config.project_id = Rails.application.credentials.paragon.project_id
end
```

## Usage

To use UseParagon, add your project's ID along with your private key to your Rails credentials.

The private key is generated on the UseParagon Dashboard. Follow [these instructions](https://docs.useparagon.com/getting-started/installing-the-connect-sdk#setup-with-your-own-authentication-backend).

    Rails.application.credentials.paragon.private_key

Find your project ID in the Overview tab of any Integration.

    Rails.application.credentials.paragon.project_id

Once this information is configured in your Rails project, you can start using the gem as needed.

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
