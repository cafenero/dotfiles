hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  hs.alert.show("Hello World!")
end)

hs.hotkey.bind({"cmd"}, "i", function()
   sec_all = hs.timer.localTime()
   hour = math.floor(sec_all / 60 / 60)
   min = math.floor((sec_all - (hour * 60 * 60)) / 60)
   sec = math.floor(sec_all % 60 % 60)
--   timestring = string.format("%02d",hour) .. ":" .. string.format("%02d",min)
   timestring = string.format("%02d",hour) .. ":" .. string.format("%02d",min) .. ":" .. string.format("%02d",sec)

--   hs.alert.show(timestring, hs.screen.mainScreen(), {textStyle=10}, 10)
--   hs.alert.show(timestring, {fillColor = {red = 1}}, 10)
--   hs.alert.show(timestring, {textSize = 300}, 4.5)
   --   hs.alert.show(timestring, hs.screen.mainScreen(), {textSize = 300}, 4.5)

   for k, v in pairs(hs.screen.allScreens()) do
      hs.alert.show(timestring, {textSize = 300}, v, 4.5)
   end
end)

hs.hotkey.bind({"cmd"}, "l", function()
      for k, v in pairs(hs.hotkey.getHotkeys()) do
	 if k == 5 then
	    hs.alert.show("HITTTTTTTTTTTTTTTT")
	 end
	 hs.alert.show(k)
	 hs.alert.show(v)
	 hs.alert.show(v.msg)
      end
end)

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
