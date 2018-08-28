# docker volume example

this is a test repo to show an issue I ran into with volume sharing in the docker-orchestrating-docker pattern.

## Running the example

```
$ ./start.sh
```

Will tell docker to build and run `Prep.dockerfile`. This container creates 3 volumes to store the files within the repo:

- `vol_dockerfiles` which contains all the *.dockerfile files
- `vol_scripts` which contains all the *.sh files
- `vol_out` which will hold created files within the prep container (not used yet)

## The issue
The prep container will build successfully, but the `docker run` command will fail with an error similar to ```cp: can't stat '/app/*.sh': No such file or directory```

This happens whenever a container attempts to access a volume that is in use inside another container. In this case it's the `/app` volume on the prep container that is causing the error, since `prep.sh` attempts to bind-mount that directory into a container in order to populate the other docker volumes with data.

## The workaround
So far the workaround has been to take any data that you need to share between containers that are run via the DOD pattern and store it in volumes _before_ you launch the container and mount them in using the `-v` or `--mount` options of `docker run`.
