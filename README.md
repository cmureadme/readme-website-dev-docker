The first time you get your dev environment set up, you'll want to run the following:

```bash
git clone https://github.com/cmureadme/readme-website-dev-docker.git
cd readme-website-dev-docker
git clone https://github.com/cmureadme/readme-website
cd readme-website
git checkout dev
cd ..
docker build --tag readme-website-dev .
```

Now, to run a local dev server on `http://127.0.0.1:8000`, run:

```bash
docker run --rm -ti --network host readme-website-dev:latest
```

Do your development work in `readme-website`, in the `dev` branch. Whenever you want to run your updated code, run the following:

```bash
docker build --tag readme-website-dev .
yes | docker image prune
docker run --rm -ti --network host readme-website-dev:latest
```

Once you're ready to commit changes, double check you're on the `dev` branch, and `git push` from the `readme-website` directory.
