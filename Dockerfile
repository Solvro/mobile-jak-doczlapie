FROM ubuntu:latest AS builder

RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /flutter
ENV PATH="/flutter/bin:${PATH}"
RUN flutter doctor
RUN flutter channel stable
RUN flutter upgrade

# Clone project and build it
WORKDIR /app
COPY . .

RUN dart run build_runner build -d 
RUN flutter build web --release -t lib/main.web.dart


FROM nginx:alpine AS nginx

# Copy the built Flutter web app from the builder stage to nginx html directory
COPY --from=builder /app/build/web /usr/share/nginx/html

# Optional: Copy custom nginx configuration
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]