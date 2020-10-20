# words-really-matter

There's only one script in the repo. It replaces problematic words in a code base. It specifically looks at markdown files only. There are multiple ways to run this script.

## Scope

This is a simple docker container that walks through a directory and changes any
instance of some problematic words to something more socially acceptable, for instance:
`slave` to `follower` or `master` to `leader`. You can look at the `dict` we created
[here](https://github.com/jjasghar/actions-words-really-matter/blob/main/entrypoint.sh#L22-L24) and are more than willing to accept PRs to add to the list.

The idea is that this can create a PR for repos via GitHub Actions so we as developers
can have bots make sure we start to take these words out of our vocabulary.

### Run in a container (aka locally)

There is a [containerized version](Dockerfile) of the script Run these commands from your project root:

```bash
docker build -t words-matter .
cd <to source code>
docker run -v `pwd`:/source words-matter
```

> You can of course take the [script](entrypoint.sh) itself and run it locally, just be aware that you need use bash 4.0 or later and you'll have to push your own changes.

### Run as a GitHub Action

The script can also be run as a [GitHub Action](action.yml) and is available in the [GitHub Action Marketplace](https://github.com/marketplace/actions/words-really-matter).

For an example run check out this [resulting PR](https://github.com/jjasghar/words-really-matter-tester/pull/6/files).

To use this function in your repository perform the following steps:

1. Create a [GitHub Secret](https://developer.github.com/v3/actions/secrets/) with the key name `GH_TOKEN` and it's value be a [GitHub API key](https://github.com/settings/tokens).

2. Create a file in `.github/workflows/` and paste the following code:

   ```yaml
   on:
     push:
       branches:
         - main
         - master

   jobs:
     words-matter:
       runs-on: ubuntu-latest
       name: A job to remove problematic words
       steps:
         - name: Checking out our code
           uses: actions/checkout@master
         - name: Remove the problematic words
           uses: jjasghar/actions-words-really-matter@v2.1.0
         - name: Create Pull Request
           id: cpr
           uses: peter-evans/create-pull-request@v3
           with:
             token: ${{ secrets.GH_TOKEN }}
             commit-message: Remove problematic words
             title: '[Automated PR] Remove problematic words'
             body: |
               Found a problematic words that can be replaced

               [1]: https://github.com/jjasghar/actions-words-really-matter
         - name: Check outputs
           run: |
             echo "Pull Request Number - ${{ steps.cpr.outputs.pull-request-number }}"
             echo "Pull Request URL - ${{ steps.cpr.outputs.pull-request-url }}"
     ```

## Override or add to the dictionary

If you want to override some of our values or just add your own then pass them as environment variables that start with `WORDS_`. For example, add this block to your GitHub Action workflow

```yaml
   env:
     WORDS_foo: bar
```

## Tips

If you want to re-build this with debug logs, just add this line to the `Dockerfile`:

```Dockerfile
ENV DEBUG=true
```

Re-build it locally and run it.

## License & Authors

If you would like to see the detailed LICENCE click [here](./LICENSE).

- Author: JJ Asghar <awesome@ibm.com>
- Author: Steve Martinelli <stevemar@ca.ibm.com>
