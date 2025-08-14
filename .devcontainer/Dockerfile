FROM python:3.11-slim
WORKDIR /app

RUN echo "Installing system dependencies..."
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    curl \
    make \
    bc \
    python3-dev \
    foma \
    libfoma-dev \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY . ./OjibweMorph/
RUN echo "Installing OjibweMorph's requirements..."
RUN pip install -r ./OjibweMorph/requirements.txt

RUN echo "Downloading OjibweLexicon..."
RUN git clone https://github.com/ELF-Lab/OjibweLexicon.git /app/OjibweLexicon
