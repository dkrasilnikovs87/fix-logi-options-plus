-- Kill the UI only (not the agent — it's managed by launchd)
do shell script "killall 'Logi Options+' || true"
delay 1

-- Read the agent's actual port and write it to the port file
-- (new agent version stopped updating this file — bug introduced in April 2026 update)
do shell script "lsof -p $(pgrep -f logioptionsplus_agent | head -1) 2>/dev/null | awk '/TCP.*LISTEN/{print $9}' | cut -d: -f2 | head -1 | xargs -I{} sh -c 'echo {} > /var/tmp/.eidLvUI.port'"
delay 1

-- Restart the UI
do shell script "open '/Applications/logioptionsplus.app'"
