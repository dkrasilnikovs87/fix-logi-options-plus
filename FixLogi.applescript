-- Убиваем UI Logi Options+ (не агент — он управляется launchd)
do shell script "killall 'Logi Options+' || true"
delay 1

-- Читаем реальный порт агента и записываем в port-файл
-- (новая версия агента не обновляет его сама — баг обновления от апреля 2026)
do shell script "lsof -p $(pgrep -f logioptionsplus_agent | head -1) 2>/dev/null | awk '/TCP.*LISTEN/{print $9}' | cut -d: -f2 | head -1 | xargs -I{} sh -c 'echo {} > /var/tmp/.eidLvUI.port'"
delay 1

-- Перезапускаем UI
do shell script "open '/Applications/logioptionsplus.app'"
