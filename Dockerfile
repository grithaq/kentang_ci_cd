# Use the Bitnami Python base image
FROM bitnami/python:3.9
# Update the package list, install sudo, create a non-root user, and grant password-less sudo permissions
FROM ubuntu

ARG UID
ARG GID

RUN apt update && \
    apt install -y sudo && \
    addgroup --gid $GID nonroot && \
    adduser --uid $UID --gid $GID --disabled-password --gecos "" nonroot && \
    echo 'nonroot ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Set the non-root user as the default user
USER nonroot

# Set the working directory
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install the project dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY --chown=nonroot:nonroot . /app
RUN chmod -R 755 /app

# Expose the necessary port (if applicable)
EXPOSE 8000

# Set the command to run the FastAPI app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
