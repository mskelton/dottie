# dottie

Dead simple dotfile management with the full power of bash.

## Installation

To install dottie, simply run the following command in your dotfiles repo. This
will add dottie as a submodule of your dotfiles repo, so you can easily update
when changes are made to dottie.

```bash
git submodule add https://github.com/mskelton/dottie
```

Next, add the following to your side your setup script to gain access to all the
tools dottie provides.

```bash
source ./dottie/dottie.sh
```

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
needed for tools such as Fish where the entire directory can't be linked due to
auto-generated files or other files that cannot be committed.

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

## FAQs

### How do I update dottie?

To update dottie, simply run the following command in your dotfiles repo.

```bash
git submodule update --remote dottie
```
