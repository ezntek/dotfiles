#!/usr/bin/env python3.11

import subprocess
import json
import sys
from typing import Any

def get_state() -> dict[Any, Any]:
    res = subprocess.check_output(['leftwm-state', '--quit'])
    return json.loads(res) 

def get_workspace_layout(state: dict[Any, Any], id: int) -> str:
    try:
        return state["workspaces"][id]["layout"] # type: ignore
    except KeyError or IndexError:
        return f"failed to get layout ({id=})"

def main():
    try:
        id = int(sys.argv[1])
    except IndexError:
        print("must supply the workspace ID as the first arg.")
        exit()

    layout = get_workspace_layout(get_state(), id)
    print(layout)

if __name__ == "__main__":
    main()
