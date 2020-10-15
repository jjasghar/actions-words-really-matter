# words-matter

There's only one script in the repo. It replaces problematic words in a code base. It specifically looks at markdown files only. There are multiple ways to run this script.

## Scope

This is a simple docker container that walks through a directory and changes any
instance of some problematic words to something more socially acceptable, for instance:
`slave` to `follower` or `master` to `leader`. You can look at the `dict` we created
[here][here] are more then willing to accept PRs to add to them.

The idea is that this can create a PR for repos via GitHub Actions so we as developers
can have bots make sure we start to take these words out of our vocabulary.

### Run in a container (aka locally)

There is a [containerized version](Dockerfile) of the script Run these commands from your project root:

```bash
docker build -t words-matter .
cd <to source code>
docker run -v `pwd`:/source words-matter
```

### Run as a GitHub Action

The script is also available as a [GitHub Action](action.yml). See this [repo](https://github.com/stevemar/testing-images) as an example. To use it in your repository perform the following:

1. Create a [GitHub Secret](https://developer.github.com/v3/actions/secrets/) with the key name `GH_TOKEN` and it's value be a [GitHub API key](https://github.com/settings/tokens).

2. Create a file in `.github/workflows/` and paste the following code:

   ```yaml

   on:
     push:
       branches:    
         - master

   jobs:
     rm_old_images:
       runs-on: ubuntu-latest
       name: A job to remove images
       steps:
         - name: Checking out our code
           uses: actions/checkout@master
         - name: Remove the problematic words
           uses: jjasghar/actions-words-really-matter@v2.0.0
         - name: Create Pull Request
           uses: peter-evans/create-pull-request@v2
           with:
             token: ${{ secrets.GH_TOKEN }}
             commit-message: Remove problematic words
             title: '[Automated PR] Remove problematic words'
             body: |
               Found a problematic words that can be replaced

               [1]: https://github.com/jjasghar/actions-words-really-matter
         - name: Check outputs
           run: |
             echo "Pull Request Number - ${{ env.PULL_REQUEST_NUMBER }}"
             echo "Pull Request Number - ${{ steps.cpr.outputs.pr_number }}"
     ```

## Tips

If you want to re-build this with debug logs, just add this line to the `Dockerfile`:

```Dockerfile
ENV DEBUG=true
```

Re-build it locally and run it.

## License & Authors

If you would like to see the detailed LICENCE click [here](./LICENCE).

- Author: JJ Asghar <awesome@ibm.com>
- Author: Steve Martinelli <stevemar@ca.ibm.com>

```text
Copyright:: 2020- IBM, Inc

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

[here]: https://github.com/jjasghar/actions-words-really-matter/blob/master/entrypoint.sh#L22-L24
