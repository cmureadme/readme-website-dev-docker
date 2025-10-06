# syntax=docker.io/docker/dockerfile:1.7-labs

FROM python:3.13

ARG sample_db

# Set the working directory
WORKDIR /readme-website

# Set environment variables to optimize Python
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Copy requirements
COPY readme-website/requirements.txt /readme-website/

# Install dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Populate sample data
COPY sample_dbs/${sample_db}/db.sqlite3 .
COPY sample_dbs/${sample_db}/media ./media

# Copy the website files to the container
COPY --exclude=.git --exclude=.gitignore --exclude=__pycache__/ --exclude=staticfiles/ --exclude=venv/ --exclude=.env --exclude=db.sqlite3 --exclude=media/ readme-website /readme-website

# Copy entrypoint.sh
COPY --chmod=755 ./entrypoint.sh /entrypoint.sh

# Expose the application port
EXPOSE 8000

# Start the application
CMD ["/entrypoint.sh"]
