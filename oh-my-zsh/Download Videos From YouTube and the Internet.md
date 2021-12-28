# Introduction

This file will teach you how to use a package called `youtube-dl` to create a funciton in oh-my-zsh to download videos from YouTube in one command line.

## Prerequisites

`youtube-dl` must be installed. If you have `brew` installed you can install `youtube-dl` with the following command:

```
brew install youtube-dl
```

You also must have `oh-my-zsh` installed and have access to your `.zshrc` file.

## Configuring

On a Mac or Linux system run the following commands:

```
mkdir ~/.config/youtube-dl
touch ~/.config/youtube-dl/config
```

In this config file you can place options for `youtube-dl` that will be used everytime you execute `youtube-dl`. All these commands should be in one line.

For example if you are downloading videos from youtube you add the following values to your `config` file:

```
-u <username> -p <password>
```

Other options you may want to add are `--restrict-filenames` and `--verbose`.

When you add all these together your `config` file should look like this:

```
--restrict-filenames --verbose -u <username> -p <password>
```

If you want to run `youtube-dl` without the `config` options you can pass the `--ignore-config` option on your `youtube-dl` call and pass your own options, or alternatively use the `--config-location PATH` option specify a specific config file.

If you have `oh-my-zsh` installed you can create global aliases, in which case you can create global aliases to your other config files like:`alias -g config_name='path/to/config_name` and then you can use `config_name` in the terminal or console anywhere you would like to reference that config file, such as with the option `--config-location config_name`.

See a full list of options in the [github repository](https://github.com/ytdl-org/youtube-dl) readme file.

## Oh-my-zsh Function

Open your `.zshrc` file and add the following code. You can modify the output location of the YouTube file by modifying the path after the `-o` option in the `youtube-dl` command line call in the function.

```
alias -g youtube-config='~/.config/youtube-dl/config'

# Function for scraping youtube videos
function youtube() {
	location=$(pwd)
	echo "[youtube] Provided parameters: "$1
	if [ -z $1 ] || [ $1 = "help" ]
	then
		echo "Usage: youtube <youtube identifier>"
		echo "YouTube Identifier: From v= in URL"
		echo "Example: youtube HOaEwQ85fG4"
		echo "Please provide correct parameters and run again"
	else
		echo "Identifier selected: "$1
		echo "Config location: ~/.config/youtube-dl/config"
		echo "Config contents: "$(cat youtube-config)
		echo "Starting download..."
		youtube-dl -o '~/Movies/YouTube/%(title)s.%(ext)s' $1
		echo "Finished."
	fi
	cd $location
}

# Function for scraping youtube playlists
function playlist() {
	location=$(pwd)
	echo "[playlist] Provided parameters: "$1
	if [ -z $1 ] || [ $1 = "help" ]
	then
		echo "Usage: playlist <playlist url>"
		echo "Playlist URL: URL"
		echo "Example: playlist https://www.youtube.com/playlist?list=PLuT2DqGFoFPQWrlw0PP3yxJIAidhM9Grl"
		echo "Please provide correct parameters and run again"
	else
		echo "Identifier selected: "$1
		echo "Config location: ~/.config/youtube-dl/config"
		echo "Config contents: "$(cat youtube-config)
		echo "Starting download..."
		youtube-dl -o '~/Movies/YouTube/'%(playlist_title)s/%(playlist_index)s - %(title)s.%(ext)s' $1
		echo "Finished."
	fi
	cd $location
}
```

## Usage

Now you can use these functions in the command line by calling `youtube` or `playlist` and passing the URL or YouTube identifier for the YouTube item.
