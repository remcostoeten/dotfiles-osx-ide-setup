# ZSH Functions Documentation

This directory contains various ZSH functions to enhance your development workflow.

## Development Commands

Quick development commands with colorful console feedback. These commands are designed to work with PNPM-based projects.

### Available Commands

| Command  | Description | Feedback |
|----------|-------------|----------|
| `i`      | Install dependencies | Shows installation progress and success/failure status |
| `d`      | Start development server | Displays server startup message |
| `b`      | Build project | Shows build progress and success/failure status |
| `start`  | Start production server | Displays server startup message |
| `rmall`  | Clean project | Shows cleanup progress for node_modules and .next |
| `restart`| Full development restart | Combines clean, install, and dev server start |
| `rebuild`| Full project rebuild | Combines clean, install, and build |

### Features
- 🎨 Colorful console output
- ✨ Emoji indicators
- ✅ Success/failure feedback
- 📊 Progress tracking
- 🚀 Multi-step process visualization

### Help Menu
Run `dev_help` to see all available commands in your terminal.

## Browser Opener Function

The `www` function allows opening URLs in different browsers.

### Usage
```zsh
www example.com          # Opens in default browser
www example.com --ff     # Opens in Firefox
www example.com --chrome # Opens in Google Chrome
www example.com --brave  # Opens in Brave
www example.com --arc    # Opens in Arc
```

### Features
- Automatically adds https:// if not provided
- Supports multiple browsers
- Shows usage help if no URL is provided

## Function Organization

All functions are organized in separate files and loaded through the `functions_injector.sh`:

- `01-git-commit.zsh` - Git related functions
- `02-version-manager.zsh` - Version management functions
- `03-ascii-art.zsh` - ASCII art functions
- `04-browser-opener.zsh` - Browser URL opener function
- `05-dev-commands.zsh` - Development workflow commands 