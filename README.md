# FixLogi

macOS AppleScript fix for Logi Options+ "Backend connection problem" after the ~April 2026 update.

## The problem

After a Logi Options+ update around April 16, 2026, the app hangs on a loading loop with:

> Backend connection problem

**Root cause:** The new version of `logioptionsplus_agent` stopped updating `/var/tmp/.eidLvUI.port` on each restart. The UI reads this file to find the agent's WebSocket port. The file contained the old port (e.g. `49167`) while the agent was listening on a new one (e.g. `59869`) — so the UI couldn't connect.

## The fix

The script does three things:

1. Kills only the UI (`Logi Options+`) — leaves the agent alone, it's managed by launchd
2. Reads the agent's actual current port via `lsof` and writes it to `/var/tmp/.eidLvUI.port`
3. Restarts the UI

## Installation

1. Open `FixLogi.applescript` in **Script Editor**
2. File → Export → Format: **Application**
3. Save anywhere convenient (e.g. Desktop or `/Applications`)
4. Run it whenever Logi Options+ gets stuck on the loading screen

## Notes

- The agent (`logioptionsplus_agent`) is managed by `launchd` via `com.logi.cp-dev-mgr` — do not kill it manually
- The port file path `/var/tmp/.eidLvUI.port` and the agent's Unix socket path are machine-specific
- Tested on macOS with Logi Options+ post-April 2026 update
