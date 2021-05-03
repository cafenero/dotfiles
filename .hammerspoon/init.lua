hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  hs.alert.show("Hello World!")
end)

hs.hotkey.bind({"cmd"}, "`", function()
      showDataTime()
end)

dotw_a = { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" }
function showDataTime()
   local timestring = os.date("%Y-%m-%d") .. " (" .. dotw_a[tonumber(os.date("%w")) + 1] .. ")" .. "\n         " ..  os.date("%H:%M:%S")
   for k, v in pairs(hs.screen.allScreens()) do
      hs.alert.show(timestring, {textSize = 250}, v, 3.0)
   end
end

-- hs.hotkey.bind({"cmd"}, "i", function()
--    showDataTime()
-- end)


-- gloval variable is needed!!!
showDataTimeViaMouse = hs.eventtap.new({hs.eventtap.event.types.otherMouseDown},
   function(eventobj)
      if eventobj:getButtonState(5) then
	 showDataTime()
      end
      if eventobj:getButtonState(8) then
	 -- bind enter
	 return true, { hs.eventtap.event.newKeyEvent(hs.keycodes.map[36], true) }
      end
   end
)
showDataTimeViaMouse:start()

-- hs.hotkey.bind({"cmd"}, "l", function()
--       for k, v in pairs(hs.hotkey.getHotkeys()) do
-- 	 if k == 5 then
-- 	    hs.alert.show("HIT")
-- 	 end
-- 	 hs.alert.show(k)
-- 	 hs.alert.show(v)
-- 	 hs.alert.show(v.msg)
--       end
-- end)

local function keyCode(key, modifiers)
   modifiers = modifiers or {}
   return function()
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
      hs.timer.usleep(1000)
      hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
   end
end

local function remapKey(modifiers, key, keyCode)
   hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

local function disableAllHotkeys()
   for k, v in pairs(hs.hotkey.getHotkeys()) do
      --hs.alert.show(hs.hotkey.showHotkeys(v))
      --hs.alert.show(k)
      --hs.alert.show(v)
--      hs.alert.show(v['_hk'])
      -- keycode 34
	 if k == 5 then
	    -- don't disable hs.hotkey.bind({"cmd"}, "i")
	 elseif k == 6 then
	    -- don't disable hs.hotkey.bind({"cmd"}, "`") == cmd + Esc
	 else
	    v['_hk']:disable()
	 end
   end
end

local function enableAllHotkeys()
   for k, v in pairs(hs.hotkey.getHotkeys()) do
      v['_hk']:enable()
   end
end

local function handleGlobalAppEvent(name, event, app)
   if event == hs.application.watcher.activated then
--      hs.alert.show(name)
      if name == "iTerm2" then
         disableAllHotkeys()
      elseif name == "cool-retro-term" then
         disableAllHotkeys()
--      elseif name == "PDF Expert" then
--         disableAllHotkeys()
--         enableAllHotkeys()
      else
         enableAllHotkeys()
      end
   end
end

appsWatcher = hs.application.watcher.new(handleGlobalAppEvent)
appsWatcher:start()

-- Caps key to left ctrl
-- looks not working
remapKey({}, 'capslock', keyCode('ctrl'))



-- カーソル移動
remapKey({'ctrl'}, 'f', keyCode('right'))
remapKey({'ctrl'}, 'b', keyCode('left'))
remapKey({'ctrl'}, 'n', keyCode('down'))
remapKey({'ctrl'}, 'p', keyCode('up'))

-- テキスト編集
-- remapKey({'ctrl'}, 'w', keyCode('x', {'cmd'}))
-- remapKey({'ctrl'}, 'y', keyCode('v', {'cmd'}))

-- コマンド
-- remapKey({'ctrl'}, 's', keyCode('f', {'cmd'}))
-- remapKey({'ctrl'}, '/', keyCode('z', {'cmd'}))
-- remapKey({'ctrl'}, 'g', keyCode('escape'))

-- ページスクロール
-- remapKey({'ctrl'}, 'v', keyCode('pagedown'))
-- remapKey({'alt'}, 'v', keyCode('pageup'))
-- remapKey({'cmd', 'shift'}, ',', keyCode('home'))
-- remapKey({'cmd', 'shift'}, '.', keyCode('end'))

-- adding option modify
-- remapKey({'alt'}, '2', keyCode('2'))
