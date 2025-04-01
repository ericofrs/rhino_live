# dockerfile 

FROM rocker/shiny:4.3.2

# Install dependencies and utilities
RUN apt-get update && apt-get install -y \
    libcurl4-gnutls-dev 
    
    # Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs
    
# Workaround for renv cache
RUN mkdir /.cache
RUN chmod 777 /.cache

RUN R -e "install.packages('renv', repos = c(CRAN = 'https://cloud.r-project.org'))"

# Set the working directory to /app
WORKDIR /app

# Copy the entire app directory into the container
COPY . .

# install renv & restore packages
RUN R -e 'renv::consent(provided = TRUE)'
RUN R -e "renv::restore()"

# expose port
EXPOSE 3838
CMD ["R", "-e", "shiny::runApp(port = 3838, host = '0.0.0.0')"]