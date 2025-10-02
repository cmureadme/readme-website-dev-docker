NOTE: We are abandoning Windows support. If you are on Windows you need to download WSL.

If you don't already have Docker on your computer go to their website and follow their setup instructions.
NOTE: If you are on Windows using WSL make sure that you follow the additional instructions for WSL.

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


Do your development work in `readme-website`, in the `dev` branch. Whenever you want to run your updated code, run the following:

```./rebuild.sh ```

If you want to run the docker with a bash terminal run ```./rebuild.sh bash```.
Then from within the bash terminal run ```../entrypoint.sh &``` to run the entrypoint script in the background.
If you are in the bash terminal you can then also do django mangement commands.
Just write ```python3 manage.py``` followed by whatever command you are doing.
Note that this will only apply to the current Docker image so when you rebuild the image any changes you make this way will go away.
One helpful use for this is to run ```python3 manage.py createsuperuser```.
This will create a one time superuser admin acount for you.
This is helpful if you are making changes to anything on the admin pannel (such as forms) and need to check to make sure you did it correctly.

Once you're ready to commit changes, double check you're on the `dev` branch, and `git push` from the `readme-website` directory.

