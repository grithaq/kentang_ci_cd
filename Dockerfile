# Use the Bitnami Python base image
FROM bitnami/python:3.9

# Set the working directory
WORKDIR /app

# Create a non-root user and group with matching UID and GID to the host user
ARG USER_ID
ARG GROUP_ID
RUN groupadd -g $GROUP_ID myuser && \
    useradd -u $USER_ID -g $GROUP_ID -ms /bin/bash myuser

# Set password-less sudo permissions for the non-root user
RUN echo "myuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the non-root user
USER myuser

# Copy the requirements file
COPY requirements.txt .

# Install the project dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . /app

# Expose the necessary port (if applicable)
EXPOSE 8000

# Set the command to run the FastAPI app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
