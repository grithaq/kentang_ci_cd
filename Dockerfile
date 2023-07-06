# Use the Bitnami Python base image
FROM bitnami/python:3.9
FROM ubuntu:latest

# Set the working directory
WORKDIR /app

# Install necessary packages for user and group management
RUN apt-get update && apt-get install -y shadow


# Copy the requirements file
COPY requirements.txt .

# Install the project dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . /app

# Expose the necessary port (if applicable)
EXPOSE 8000

RUN useradd -u 8877 john

USER jhon

# Set the command to run the FastAPI app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
