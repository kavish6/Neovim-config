Simple neovim config for typescript environment.

1. This config basically is created according my personal opinions and customised workflow.
2. This has keybinding for pure vim motions and actions in vim-options file.
3. plugins directory has all the stuff scoped just to external plugins with their keybindings as well.

Usage guide:

1. Pull the config in your machine.
2. Add all the files inside it to the `.config` folder of your home directory. 
3. Folder structure should be **Users/Kavish/.config/nvim** (Replace with your home directory) ->
```
    init.lua
    lua/
     | config/
      | lazy.lua
      | vim-options.lua
     | plugins/
         .
         .
         -- All the plugin files
```
