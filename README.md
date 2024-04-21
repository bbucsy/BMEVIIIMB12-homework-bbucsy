# README


## Dependencies

- Ruby 3.2.3

- Node 18.16.1

- For image processing `libvips` is used by Rails, and needs to be installed on host machine or container.

## Local development

Install dependencies by runnning
```bash
    bundle install
    yarn install
```

To set up database run 
```
    rails db:create
    rails db:migrate
    rails db:seed
```

To run webapp in local run 
```
    bin/dev
```

## Deployment

Deployment is done by using Docker. By default Rails encrypts secrets that get pushed into
the image. To change secrets run the following command:
```
EDITOR=nano rails credentials:edit
```
Instead of nano, you can use your favorite editor.

In the credentials set the following values:
```yml
secret_key_base: secret

# for the HTTPBasicAuth in production
login:
  username: username
  password: pass
```

This repo is configured to automatically deploy to Google Cloud Run. [https://bmeviiimb12-web-mmigih7niq-ey.a.run.app](https://bmeviiimb12-web-mmigih7niq-ey.a.run.app)

If you want to make another instance you will need to set a new `RAILS_MASTER_KEY` in the container enviroment variables via Google Secret Manager. 