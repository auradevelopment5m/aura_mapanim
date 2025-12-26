# Aura Map Toggle

A FiveM script that automatically displays a map animation when the pause menu is opened, with configurable options and manual toggle functionality.

## Features

- Automatic map animation on pause menu open/close
- Manual toggle via command
- Configurable settings (model, animation, timing, etc.)

## Installation

1. Ensure the resource in your `server.cfg`:
   ```
   ensure aura-maptoggle
   ```

## Configuration

Edit `shared/config.lua` to customize:

- Map prop model
- Animation dictionary and name
- Attachment positions and rotations
- Timing settings (check intervals)
- Command settings
- Debug options

## Usage

- The map animation automatically plays when opening the pause menu
- Use the configured command (default: `/togglemap`) to open pause menu too.
- Adjust settings in the config file as needed

## Preview

![Preview](https://i.postimg.cc/sggHnm07/image-2025-12-26-222350732.png)
