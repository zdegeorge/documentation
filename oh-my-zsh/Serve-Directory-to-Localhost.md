# Introduction

This file uses a `oh-my-zsh` function to allow you to serve a directory to localhost in a simple one line command.

## Prerequisites

You must have `php` installed on your system. If you have `brew` installed the easiest way to install `php` is to run:

```
brew install php@7.4
```

You also must have `oh-my-zsh` installed and have access to your `.zshrc` file.

## Oh-my-zsh Function

Copy this function into your `.zshrc` file.

```
# Function for quickly serving directory to localhost
function serve() {
	echo "[serve] Provided parameters: "$1
	if [ -z $1 ] || [ $1 = "help" ]
	then
		echo "Usage: serve <port #>"
		echo "Port #: Integer port number 1024-65535"
		echo "Example: serve 2222"
		echo "Please provide correct parameters and run again"
	else
		echo "[serve] Selected Port #: "$1
		open -a "Google Chrome" http://localhost:$1
		php -S localhost:$1
	fi
}
```

## Usage

You can now use the function by running the command `serve` in any directory and passing the port # you would like to use
