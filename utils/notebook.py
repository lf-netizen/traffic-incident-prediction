import os
import nbformat
from nbconvert.preprocessors import ExecutePreprocessor


KERNEL_TIMEOUT = 600


def run_notebook(notebook_path):
    with open(notebook_path) as f:
        nb = nbformat.read(f, as_version=4)

    ep = ExecutePreprocessor(timeout=KERNEL_TIMEOUT, kernel_name='python3')

    try:
        ep.preprocess(
            nb, {'metadata': {'path': os.path.dirname(notebook_path)}})
    except Exception as e:
        print(f"Error executing the notebook {notebook_path}")
        print(e)

    with open(notebook_path, 'w', encoding='utf-8') as f:
        nbformat.write(nb, f)
