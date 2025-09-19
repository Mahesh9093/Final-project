FROM nginx:alpine

# Copy build output to nginx html directory
COPY build /usr/share/nginx/html

# Expose port 80 (your requirement)
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
