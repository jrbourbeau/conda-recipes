#!/bin/bash

# Script to:
#     (1) Install conda into the scratch directory on a HTCondor execute node.
#     (2) Create conda environment from input environment file.
#     (3) Run specified command inside the newly created conda environment.

# Adapted from https://conda.io/docs/user-guide/tasks/use-conda-with-travis-ci.html


# Parse command line options to get environment file and command to run
while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    -f|--file)
    FILE="$2"
    shift
    shift
    ;;
    -c|--command)
    COMMAND="$2"
    shift
    shift
    ;;
    *)
    shift
    ;;
esac
done

# Ensure that PYTHONPATH environment variable is not set
if [[ -z "${PYTHONPATH}" ]]; then
  :
else
  echo "Unsetting the PYTHONPATH environment variable."
  echo "    Existing PYTHONPATH=${PYTHONPATH}"
  unset PYTHONPATH
fi

# Download and run miniconda installation script from continuum
echo "Installing miniconda..."
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $_CONDOR_SCRATCH_DIR/miniconda.sh
bash $_CONDOR_SCRATCH_DIR/miniconda.sh -b -p $_CONDOR_SCRATCH_DIR/miniconda
rm $_CONDOR_SCRATCH_DIR/miniconda.sh

# Add conda command to PATH
export PATH="$_CONDOR_SCRATCH_DIR/miniconda/bin:$PATH"

# Configure conda
conda update -q conda --yes
conda info -a

# Create and activate conda environment
echo "Creating conda environment from file: ${FILE}"
conda env create --name conda-env --file "${FILE}" --quiet
source activate conda-env

# Run command
echo "Running the command: ${COMMAND}"
${COMMAND}
