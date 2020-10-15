# Words Matter

> THIS IS A WORK IN PROGRESS. DO NOT USE!

## Scope

This is a simple docker container that walks through a directory and changes any
instance of `Master` to `Leader`. As a bonus, it also does the same thing with
`Slave` to `Follower`.

The idea is that this can create a PR for repos via GitHub Actions so we as developers
can have bots make sure we start to take these words out of our vocabulary.

## Usage

If you want to run the container:

```bash
docker build -t words-matter .
cd <to source code>
docker run -v $PWD:/mnt words-matter
```

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
