# Blackout Script for FiveM (ESX Framework)

## Description
A secure and optimized blackout script for FiveM, designed to work with the ESX framework. This script triggers blackouts in the game world with random chances and durations. It allows admins to manually trigger or end blackouts through a command. Additionally, the blackout state is synced across all players, and notifications are displayed for events such as blackout start, restore, and access denial.

**Version**: 1.0.0

## Features
- Random automatic blackouts triggered with a configurable chance and duration.
- Manual control for admins using the `/blackout` command.
- Automatic synchronization of blackout state across clients.
- Configurable notifications for different events.
- Optimized for performance with minimal server load.

## Dependencies
- **es_extended**: This script requires the ESX framework to function. It relies on ESX for player management and notifications.

## Installation

1. Download or clone the repository.
2. Place the `blackout` folder in your `resources` directory.
3. Add `start blackout` to your `server.cfg`.
4. Ensure that `es_extended` is installed and functioning properly.

## Configuration

### `config.lua`

The `config.lua` file allows you to customize the blackout system.

- **BlackoutChance**: Chance of an automatic blackout being triggered (0.0 to 1.0).
- **BlackoutMinDuration**: Minimum duration of a blackout (in seconds).
- **BlackoutMaxDuration**: Maximum duration of a blackout (in seconds).
- **DefaultManualDuration**: Default duration for a manual blackout (in seconds).
- **BlackoutCheckInterval**: Interval (in minutes) at which the server checks if a blackout should occur.
- **BlackoutNotify**: Notification settings for when the blackout starts.
- **RestoreNotify**: Notification settings for when the blackout ends.
- **AccessDeniedNotify**: Notification for players without permission trying to use the blackout command.
- **CommandErrorNotify**: Notification for invalid command usage.

Example configuration:

```lua
Config = {}

Config.BlackoutChance = 0.3
Config.BlackoutMinDuration = 300
Config.BlackoutMaxDuration = 600
Config.DefaultManualDuration = 300
Config.BlackoutCheckInterval = 30

Config.BlackoutNotify = {
    title = "Power Outage",
    description = "All lights have gone out!",
    type = "error"
}

Config.RestoreNotify = {
    title = "Power Restored",
    description = "All lights are back on.",
    type = "success"
}

Config.AccessDeniedNotify = {
    title = "Access Denied",
    description = "Only admins can execute this command.",
    type = "error"
}

Config.CommandErrorNotify = {
    title = "Error",
    description = "Invalid option. Use /blackout [on/off] [duration in seconds].",
    type = "error"
}
```

## Commands

### `/blackout [on/off] [duration in seconds]`

- **on**: Activates the blackout for the given duration (in seconds).
- **off**: Ends the current blackout immediately.

This command can only be used by admins (users with the `admin` group).

### Automatic Blackouts

Automatic blackouts are triggered randomly based on the configured chance (`BlackoutChance`) and occur at intervals defined by `BlackoutCheckInterval`.

## Event Listeners

- `custom_blackout:startBlackout`: Starts a blackout on all clients.
- `custom_blackout:endBlackout`: Ends the blackout on all clients.
- `custom_blackout:syncBlackout`: Syncs the blackout state between server and client.

## Client-side Behavior

- When a blackout is active, all artificial lights are turned off.
- When the blackout ends, artificial lights are restored.
- Clients periodically check if the blackout has ended and update accordingly.

## Server-side Behavior

- The server checks for automatic blackouts based on the configured interval.
- When a player joins, their client is synced with the current blackout state if one is active.
- The server handles the triggering and ending of blackouts, ensuring all players are updated in real time.

## Changelog

### Version 1.0.0
- Initial release.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


## Disclaimer

Use this script at your own risk. The author is not responsible for any issues, damages, or losses that may occur as a result of using this script. By using this script, you agree to take full responsibility for any consequences. The script is provided "as is" without any warranty or guarantee.
