# Use the official Golang base image
FROM golang:1.23.1-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy go.mod and go.sum files to the working directory
COPY go.mod go.sum ./

# Copy the entire application
COPY . .

#Activate Orchestrion on Dockerfile
RUN mkdir -p /usr/local/bin 

RUN GOBIN=/usr/local/bin go install github.com/DataDog/orchestrion@latest

# Build the Go binary
ENV GOFLAGS="${GOFLAGS} '-toolexec=/usr/local/bin/orchestrion toolexec'"

# With the newly instrumented code, manage dependency
RUN go mod tidy

# Build the Go application
RUN go build -o main .

# Expose port 8080 for the application
EXPOSE 8080

# Command to run the executable
CMD ["./main"]