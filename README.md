# Bash Modules

## Overview

This project provides a modular system for managing Bash aliases, helper functions, and executables. Everything is organized within your `~/.bash-modules` directory and loaded automatically when you open a terminal.

## Features

- Automatically loads Bash aliases, helpers, and scripts at shell startup
- Modular organization for easy management and updates
- Simple installation with a `Makefile`
- Automatically adds custom scripts to your PATH

## Directory Structure

Below is how the project is organized:

```
    ~/.bash-modules/
    ├── bash-modules.sh          # Main loader script
    ├── modules/
    │   ├── aliases.d/           # Place your .aliases files here
    │   ├── helpers.d/           # Place your .helper.sh files here
    │   └── bin/                 # Place your executables here (added to PATH)
    ├── Makefile                 # For installing
```


## Getting Started

### 1. Clone This Repository

```
git clone https://github.com/galgeri/bash-modules.git ~/.bash-modules
```

### 2. Install

Navigate into the directory and run:

```
cd ~/.bash-modules
make install
```

This ensures the loader is hooked into your `~/.bashrc` for automatic loading.

### 3. Reload your shell

```
source ~/.bashrc
```

Or open a new terminal window.

---

## How It Works

- Any `.aliases` files in `modules/aliases.d/` are loaded as aliases
- Any `.helper.sh` files with functions in `modules/helpers.d/` are loaded as Bash functions
- Any scripts in `modules/bin/` are added to your `PATH` for easy execution

---

## Adding Your Own Modules

**Add an alias:**

1. Create a file such as `my.aliases` in `modules/aliases.d/`
2. Add your aliases:

```
alias gs='git status'
```

**Add a helper function:**

1. Create a file such as `git.helper.sh` in `modules/helpers.d/`
2. Add your Bash functions:

```
my_func() {
    echo "Hello from bash-modules!"
}
```

**Add an executable script:**

1. Place the script in `modules/bin/`
2. Make sure it is executable:

```
chmod +x modules/bin/my_script
```

---

# Managing Your Private or Shared Modules Repository

You can manage your entire `modules/` directory as a Git repository. This makes it easy to back up, sync, or share all your Bash modules (aliases, helpers, scripts) across systems or with collaborators.

## Initializing a New Modules Repository

To set up a new, personal or private Git repository containing your modules directory:

- Run `make init-modules-repo`
- This will initialize a new git repository in the `modules/` directory and prompt you to enter a remote repository URL.
- After setting the remote, you can commit and push your modules as needed.

## Cloning an Existing Modules Repository

To use an existing modules repository (for example, from another machine or a shared configuration):

- Run `make clone-modules-repo`
- You’ll be prompted for the remote repository URL.
- The command will **remove any existing `modules/` directory** and clone the repository from the given URL into `modules/`.
- Make sure to back up or commit any local changes before proceeding, as this operation cannot be undone.

## Typical Workflow

- Use `make init-modules-repo` if you want to start tracking your `modules/` directory with a new repository.
- Use `make clone-modules-repo` to pull down an existing set of modules and replace your current set completely.

---

**Note:**  
These commands assume your project is located at `~/.bash-modules` and operate on the `modules/` directory found there.

For more information about available commands, run `make help`. This will list all available Makefile targets and provide brief usage instructions.

---

## Uninstallation

1. Edit your `~/.bashrc` and remove this line:

```
source $HOME/.bash-modules/bash-modules.sh
```

2. Delete the directory if desired:

```
rm -rf ~/.bash-modules
```

---

## Troubleshooting

- Ensure that `~/.bash-modules` is used exactly as the directory name/location.
- If `make install` raises a path error, move the directory as instructed.
- Make sure file extensions are correct for aliases and helpers.
- Scripts in `modules/bin/` must be executable.

---

## License

Bash Modules © 2025 by Gergely Gál is licensed under CC BY-NC-SA 4.0. To view a copy of this license, visit https://creativecommons.org/licenses/by-nc-sa/4.0/