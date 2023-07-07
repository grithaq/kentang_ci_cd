# Use the Bitnami Python base image
FROM bitnami/python:3.9

# Set the working directory
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install the project dependencies
RUN python -m pip install --upgrade pip
RUN pip3 install -r requirements.txt

# Copy the rest of the application code
COPY . /app

# Expose the necessary port (if applicable)
EXPOSE 8000

RUN useradd -u 1001 nonroot

USER nonroot

# Set the command to run the FastAPI app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
