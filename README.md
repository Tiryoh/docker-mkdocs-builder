# docker-mkdocs-builder
Dockerfile that just builds the MkDocs document

## Usage

1. Run the following command in your mkdocs project to start the local server

```
docker run --rm -p 8000:8000 -v $PWD:/docs tiryoh/mkdocs-builder:alpine
```

2. Access http://127.0.0.1:8000 to access the content


## Related projects

* [Tiryoh/actions-mkdocs](https://github.com/Tiryoh/actions-mkdocs)
    * GitHub Actions for MkDocs


## License

Copyright (c) 2020 Daisuke Sato

This repository is licensed under the MIT License, see [LICENSE](./LICENSE).
Unless attributed otherwise, everything in this repository is licensed under the MIT license.

### Acknowledgements

This repository includes third-party libraries and software. See [THIRD-PARTY-NOTICES.md](./THIRD-PARTY-NOTICES.md).