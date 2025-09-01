NOTE: We are abandoning Windows support. If you are on Windows you need to download WSL.

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

Now, to run a local dev server on `http://localhost:8000`, run:

```bash
docker run --rm -ti -p 8000:8000 readme-website-dev:latest
```

To view your locally running site you can eaither go to `http://127.0.0.1:8000` or `localhost:8000` in your browser.

When you are doing stuff with django you need to make sure that you are in the `readme-website` directory.
For example, if you are editing the models when you are done you need to run these two commands: 

```
python3 manage.py makemigrations
python3 manage.py migrate
```

To see the changes that you are making in the admin panel you need to create a superuser account:
```
python3 manage.py createsuperuser
```
This will not make you an admin on our production website, but it is important that you are able to view the admin panel to do development work.

Do your development work in `readme-website`, in the `dev` branch. Whenever you want to run your updated code, run the following:

```bash
docker build --tag readme-website-dev .
docker image prune
docker run --rm -ti --network host readme-website-dev:latest
```

Once you're ready to commit changes, double check you're on the `dev` branch, and `git push` from the `readme-website` directory.
