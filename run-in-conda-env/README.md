# Run a command in a local `conda` environment

`run_in_conda_env.sh` is a `bash` script that will:

1. Install `conda` into the local scratch directory of an HTCondor execute node.
2. Create a `conda` environment from an input [environment file](https://conda.io/docs/user-guide/tasks/manage-environments.html#creating-an-environment-file-manually).
3. Run a specified command inside of the newly created `conda` environment.

## Example usage

The `conda` environment file you would like to use can be specified via the `--file` command line argument, while the command to run is specified with the `--command` argument:

```bash
$ ./run_in_conda_env.sh --file path/to/environment.yml --command "command goes here"
```

For example, for an environment file, `environment.yml`, and a Python script, `example-script.py`, both in the current directory, you would run:

```bash
$ ./run_in_conda_env.sh --file environment.yml --command "python example-script.py"
```
