Dashboard

https://plot.ly/dashboard/srush:3/view

Logs in logs/


Integration Testing using Docker.

1. Provision an EC Ubuntu g2 box and run the `build.sh` script.
2. Clone and provide a password for this repository in the root/~ directory.
3. Setup `launch.sh` with the pem and box id.
4. Run `launch.sh` locally, this will call `setup.sh` to start docker, and `run.sh` within docker.
5. Sit back. It will run a 200K translation task and upload to the repo.



