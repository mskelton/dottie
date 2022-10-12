# dottie

Dead simple dotfile management with the full power of bash.

## Installation

To install dottie, simply run the following command in your dotfiles repo.

```bash
curl https://mskelton.dev/dottie.sh --output dottie.sh
chmod +x dottie.sh
```

This will download a file named `dottie.sh` to your repo which you can source
inside your setup script to gain access to all the tools dottie provides.

```bash
source ./dottie.sh
```

_If you are concerned about security, feel free to checkout the downloaded file.
It's all just bash script no minified code or special surprises._

## Usage

### `link`

This function allows you to create a symlink from a source file or directory to
a target location.

```bash
link nvim ~/.config/nvim
link home/.vimrc ~/.vimrc
```

### `link_contents`

Links the contents of a directory and it's subdirectories. This is primarily
needed for tools such as Fish where the entire directory can't be linked due
to auto-generated files or other files that cannot be committed to version control.

```bash
link_contents home ~/
link_contents fish ~/.config/fish/
```

### `finalize`

This function will perform various finalization tasks (currently just error
reporting) and should be run last after all other steps in your configuration.

```bash
finalize
```
