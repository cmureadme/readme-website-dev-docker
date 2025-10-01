# syntax=docker.io/docker/dockerfile:1.7-labs

FROM python:3.13

# Install dependencies first (only re-run if requirements.txt changes)
WORKDIR /readme-website
COPY readme-website/requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy the website files to the container
COPY --exclude=.git --exclude=.gitignore --exclude=__pycache__/ --exclude=staticfiles/ --exclude=venv/ --exclude=.env --exclude=db.sqlite3 --exclude=media/ readme-website /readme-website

# Set the working directory
WORKDIR /readme-website

# Set environment variables to optimize Python
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Populate sample data
RUN chmod u+x data_populate.sh
RUN ./data_populate.sh

# Copy entrypoint.sh
COPY --chmod=755 ./entrypoint.sh /entrypoint.sh

# Expose the application port
EXPOSE 8000

# Start the application
CMD ["/entrypoint.sh"]
