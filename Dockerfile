# Use the official Golang base image
FROM golang:1.22.3

# Set necessary environment variables needed for our image
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

# Set the working directory inside the container
WORKDIR /app

# Copy go.mod and go.sum files to the working directory
COPY go.mod go.sum ./

# Copy the entire application
COPY . .

RUN mkdir -p /usr/local/bin 

RUN GOBIN=/usr/local/bin go install github.com/DataDog/orchestrion@v1.0.4

# Build the Go binary
ENV GOFLAGS="${GOFLAGS} '-toolexec=/usr/local/bin/orchestrion toolexec'"

RUN /usr/local/bin/orchestrion pin

# With the newly instrumented code, manage dependency
RUN go mod tidy

# Build the Go application
RUN go build -o main .

# Expose port 8080 for the application
EXPOSE 8080

# Command to run the executable
CMD ["./main"]
