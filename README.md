# docker-mkdocs-builder
Dockerfile that just builds the MkDocs document

## Usage

1. Run the following command in your mkdocs project to start the local server

```
docker run --rm -p 8000:8000 -v $PWD:/docs tiryoh/mkdocs-builder:alpine
```

2. Access http://127.0.0.1:8000 to access the content