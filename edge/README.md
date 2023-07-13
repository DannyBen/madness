# Testing Unreleased (Edge) Madness Versions

If you wish to try a version of madness straight from GitHub before it is
released, you can use one of these methods:

## Using Docker

```bash
alias madness_edge='docker run --rm -it --user $(id -u):$(id -g) --publish 3000:3000 --volume "$PWD:/docs" dannyben/madness:edge'
```

or build your own image with [this Dockerfile](Dockerfile).

## Using Ruby

```bash
git clone https://github.com/DannyBen/madness.git
cd madness
git checkout <the branch of the PR>   # optional, if not testing `master`
gem build madness.gemspec
gem install madness*.gem
cd ..
```
