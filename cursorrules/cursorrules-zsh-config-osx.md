## Zsh configuration

This is a repository for my zsh configuration. We source the `main_injector.sh` in our `.zshrc` file.

The `main_injector.sh` file is the main file that sources all the other files in the `plugins`, `aliases`, `functions`, `options`, `env_vars`, `init_files`, and `scripts` directories. It should only be responsible for sourcing the other files.

The files it sources, can have multiple child files. We like to use a SOLID like approach with seperate of concerns. For `alias_injector.sh` we can have a `navigation-alias.zsh` file that contains all the navigation aliases. But also `git-aliasses.sh`, `dev-shortcuts-aliases.zsh`, `navigation-aliases.zsh`, `script-aliases.zsh`, `misc-aliases.zsh` etc. Instead of one big file. This principle applys to all other `*_injector.sh` files.

Every change we make to the config, wether it's adding a new alias, function, option, env_var, init_file or plugin, we should make sure to document it in the `helper_menu.sh` file. Which is an interactive help menu that will guide you through the process of adding a new alias, function, option, env_var, init_file or plugin.

If we add a new function, it should be documented, and also if the function needs to be maintained some way, should be maintained in the `helper_menu.sh` file. If that's not the case then only make sure it's described in the `helper_menu.sh` file.

Besides aliasses we have the following folders:


`/init`
   - `01-completion.zsh`  <---- This file is responsible for initializing the completion system.
   - `02-welcome.zsh`   <---- This file is responsible for displaying a welcome message when the shell is opened.
   - `03-error-handling.zsh`   <---- This is NOT YET IMPLEMENTED. AND DOES NOT EXIST.
   - `04-key-bindings.zsh`   <---- This is NOT YET IMPLEMENTED. AND DOES NOT EXIST.
   - `05-theme-setup.zsh`   <---- This is NOT YET IMPLEMENTED. AND DOES NOT EXIST.

`/plugins`
    - `zsh-completions`
    - `zsh-autosuggestions`
    - `zsh-syntax-highlighting`
    - `zsh-history-substring-search`
    - `zsh-autocomplete`
    - `zsh-autocomplete-plugin`
    - `zsh-autocomplete-plugin-zsh`
    - `zsh-autocomplete-plugin-zsh-completions`
    - `zsh-autocomplete-plugin-zsh-autosuggestions`
    - `zsh-autocomplete-plugin-zsh-syntax-highlighting`
    - `zsh-autocomplete-plugin-zsh-history-substring-search`
  

`/aliases`
    - `config-aliases.zsh` <---- This file is responsible for configuring (.zshrc etc) the aliases. (e.g. alias zrc='vim ~/.zshrc')
    - `navigation-aliases.zsh` <---- This file is responsible for configuring the navigation aliases. (e.g. alias ..='cd ..')
    - `git-aliases.zsh` <---- This file is responsible for configuring the git aliases. (e.g. alias g='git')
    - `dev-shortcuts-aliases.zsh` <---- This file is responsible for configuring the development shortcuts aliases. (e.g. alias p='pnpm')
    - `script-aliases.zsh` <---- This file creates aliasses for scripts/functions. (e.g. alias copy='copy_function() ')
    - `misc-aliases.zsh` <---- This file is responsible for configuring the misc aliases.

`/functions`
    - `config-functions.zsh` <---- This file is responsible for configuring (.zshrc etc) the functions.

# ZSH Configuration Rules

## File Organization
- All ZSH files must use `.zsh` extension
- Function files should be prefixed with numbers (01-, 02-) for load order
- Keep files in their designated directories (aliases/, functions/, etc.)
- Use kebab-case for filenames (e.g., git-aliases.zsh)

## Function Creation
- Each function should have a descriptive header comment
- Include usage examples in comments for complex functions
- Follow the pattern:
```zsh
# Function name and description
# Usage: function_name <arg1> <arg2>
# Example: function_name value1 value2
function function_name() {
    # Function logic here
}
```

## Alias Organization
- Group related aliases in themed files (git.zsh, docker.zsh, etc.)
- Include descriptive comments above each alias or group
- Use the format:
```zsh
# Description of the alias group
alias shortcut='actual command'
```

## Version Management
- Version bumps should be automatic with commits
- Follow semantic versioning principles
- Document version changes in commit messages

## Documentation
- All new features must be documented in the help system
- Use color coding consistently in help output
- Include practical examples in documentation
- Keep help sections focused and organized

## Plugin Management
- Document plugin dependencies clearly
- Include configuration instructions in plugin-config.zsh
- Keep plugin-specific settings isolated

## Security
- Never store sensitive information in plain text
- Use environment variables for sensitive data
- Document security considerations

## Testing
- Test new functions in a clean shell environment
- Verify aliases work across different contexts
- Ensure help documentation is accurate

## Maintenance
- Keep the help menu updated with new features
- Clean up deprecated functions and aliases
- Maintain consistent formatting across files

