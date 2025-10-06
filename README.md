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
chmod u+x ./load_sample.sh
./load_sample.sh
```
From there you can choose what sample database you would like to develop with. 
You only have to run this script once per database you want to use.

Do your development work in `readme-website`, in the `dev` branch. 
If you change how the database schema works (ie make changes to `models.py`) you need to run `python3 manage.py makemigrations` inside of the `readme-website` folder.

Whenever you want to run your updated code, run the following where `database_name` is the name of the database you are working on:

```./rebuild.sh database_name```

If you want to run the docker with a bash terminal run ```./rebuild.sh database_name bash```.
Then from within the bash terminal run ```../entrypoint.sh &``` to run the entrypoint script in the background.
If you are in the bash terminal you can then also do django mangement commands.
Just write ```python3 manage.py``` followed by whatever command you are doing.
Note that this will only apply to the current Docker image so when you rebuild the image any changes you make this way will go away.

On each building of this image a superuser named ```god``` is created with password ```him```.
THIS IS ONLY CREATED ON THIS DEVELOPMENTAL IMAGE AND WILL NOT ACTUALLY WORK ON THE PRODUCTION SERVER.
This is helpful if you are making changes to anything on the admin pannel (such as forms) and need to check to make sure you did it correctly.

To view your locally running site you can eaither go to `http://127.0.0.1:8000` or `localhost:8000` in your browser.

Once you're ready to commit changes, double check you're on the `dev` branch, and `git push` from the `readme-website` directory.

