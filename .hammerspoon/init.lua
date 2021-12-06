hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", function()
  hs.alert.show("Hello World!")
end)


function resize_window_4()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  -- delta = 20
  delta = 0
  f.x = max.x + delta
  f.y = max.y
  f.w = max.w - delta
  f.h = max.h
  win:setFrame(f)
end
hs.hotkey.bind({"cmd"}, "4", resize_window_4)

function resize_window_5()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  -- 3840 * 2160 => 1920 * 1080
  f.x = max.w / 4
  f.y = max.h / 4
  f.w = max.w * (2/4)
  f.h = max.h * (2/4)
  win:setFrame(f)
end
hs.hotkey.bind({"cmd"}, "5", resize_window_5)

-- mouseCircle = nil
mouseCircleTimer = nil

mousepoint = nil
mousepoint = "hoge"
-- mouseCircle = nil

function mouseHighlight()
   -- Delete an existing highlight if it exists
   hs.alert.show(mouseCircle)

   if mouseCircle then
	  mouseCircle:hide()
	  mouseCircle:delete()
	  mouseCircle = nil
   else
	  -- Get the current co-ordinates of the mouse pointer
	  mousepoint = hs.mouse.getAbsolutePosition()
	  -- Prepare a big red circle around the mouse pointer
	  mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-40, mousepoint.y-40, 80, 80))
	  mouseCircle:setStrokeColor({["red"]=0,["blue"]=0,["green"]=1,["alpha"]=1})
	  mouseCircle:setFill(false)
	  mouseCircle:setStrokeWidth(5)
	  mouseCircle:show()
	  -- Set a timer to delete the circle after 3 seconds
	  -- mouseCircleTimer = hs.timer.doAfter(3, function() mouseCircle:delete() end)
   end
end
-- mouseHighlight:start()





function mytest()
   -- Delete an existing highlight if it exists
   hs.alert.show(mouseCircle)

   if mouseCircle then
	  mouseCircle:hide()
	  mouseCircle:delete()
	  mouseCircle = nil
   else
	  mouseCircle = hs.drawing.rectangle(hs.geometry.rect(0, 0, 800, 800))
	  mouseCircle:setFillColor({["red"]=0.9,["blue"]=0.9,["green"]=0.9,["alpha"]=0.7})
	  mouseCircle:setFill(true)
	  mouseCircle:show()
   end
end



function mytest2()
   -- hs.alert.show(mouseCircle)

   if mouseCircle then
	  mouseCircle:hide()
	  mouseCircle:delete()
	  mouseCircle = nil

	  mouseCircle2:hide()
	  mouseCircle2:delete()
	  mouseCircle2 = nil

   else
	  mousepoint = hs.mouse.getAbsolutePosition()

	  -- hs.alert.show(xAdd(0))
	  -- hs.alert.show(yAdd(0))

	  -- n = 0
	  -- angle = 2*math.pi/6 * n
	  -- local xAdd = math.floor(L * math.sin(angle)) + 1
	  -- local yAdd = math.floor(L * math.cos(angle)) + 1

	  mouseCircle = hs.drawing.line( {x=mousepoint.x, y=mousepoint.y} , {x=(mousepoint.x+xAdd(0)) , y=(mousepoint.y+yAdd(0))})
	  mouseCircle2 = hs.drawing.line( {x=mousepoint.x, y=mousepoint.y} , {x=(mousepoint.x+xAdd(1)) , y=(mousepoint.y+yAdd(1))})

  -- 	   a = { "x", "y", "z" };
  -- print( a[1] );

	  -- set style
	  mouseCircle:setStrokeColor({["red"]=0.9,["blue"]=0.9,["green"]=0.9,["alpha"]=0.7})
	  mouseCircle2:setStrokeColor({["red"]=0.9,["blue"]=0.9,["green"]=0.9,["alpha"]=0.7})
	  mouseCircle:setStrokeWidth(2)
	  mouseCircle2:setStrokeWidth(2)


	  -- mouseCircle = hs.drawing.line(hs.geometry.point(0, 0), hs.geometry.point(100, 100))
	  -- mouseCircle = hs.drawing.line(hs.geometry.point(f.0, f.0), hs.geometry.point(f.100, f.100))

	  -- mouseCircle = hs.drawing.line(hs.geometry.point(1, 1), hs.geometry.point(100, 100))
	  -- mouseCircle:setFillColor({["red"]=0.9,["blue"]=0.9,["green"]=0.9,["alpha"]=0.7})
	  -- mouseCircle:setFill(true)
	  mouseCircle:show()
	  mouseCircle2:show()

   end
end



-- org 02 random!!! chaos!
-- function xAdd(n)
--    angle = math.random() * 2*math.pi
--    return math.floor(L * math.sin(angle)) + 1
-- end

-- function yAdd(n)
--    angle = math.random() * 2*math.pi
--    return math.floor(L * math.cos(angle)) + 1
-- end

-- function xSAdd(n)
--    angle = math.random() * 2*math.pi
--    return math.floor(l * math.sin(angle)) + 1
-- end

-- function ySAdd(n)
--    angle = math.random() * 2*math.pi
--    return math.floor(l * math.cos(angle)) + 1
-- end

-- -- org 01
-- function xAdd(n)
-- 	  angle = 2*math.pi/arraysize* n
-- 	  return math.floor(L * math.sin(angle)) + 1
-- end

-- function yAdd(n)
-- 	  angle = 2*math.pi/arraysize * n
-- 	  return math.floor(L * math.cos(angle)) + 1
-- end

-- function xSAdd(n)
-- 	  angle = 2*math.pi/arraysize * n
-- 	  return math.floor(l * math.sin(angle)) + 1
-- end

-- function ySAdd(n)
-- 	  angle = 2*math.pi/arraysize * n
-- 	  return math.floor(l * math.cos(angle)) + 1
-- end



L = 1500
-- L = 3000 -- 危険！
l = 45
ll = 30
function xAdd(angle)
   return math.floor(L * math.sin(angle)) + 1
end

function yAdd(angle)
   return math.floor(L * math.cos(angle)) + 1
end

function xSAdd(angle, r)
   -- return math.floor(l * math.sin(angle))
   -- return math.floor(l * math.sin(angle)) + 1
   -- return math.floor(math.random() * l * math.sin(angle)) + 1
   -- return math.floor(r * l * math.sin(angle)) + 1
   return math.floor(r * ll * math.sin(angle)) + math.floor(l * math.sin(angle))
end

function ySAdd(angle, r)
   -- return math.floor(l * math.cos(angle))
   -- return math.floor(l * math.cos(angle)) + 1
   -- return math.floor(math.random() * l * math.cos(angle)) + 1
   -- return math.floor(r * l * math.cos(angle)) + 1
   return math.floor(r * ll * math.cos(angle)) +  math.floor(l * math.cos(angle))
end

-- arraysize=300 -- looks good!
arraysize=150
mouseCircle = {}
for i = 1, arraysize do
   table.insert(mouseCircle, "")
end

displayflag = false
function mytest3()
   -- hs.alert.show(#mouseCircle)

   if displayflag then
	  for i = 1, #mouseCircle do
		 mouseCircle[i]:hide()
		 mouseCircle[i]:delete()
		 mouseCircle[i] = nil
	  end
	  mouseCircle = {}
	  for i = 1, arraysize do
		 table.insert(mouseCircle, "")
	  end

	  displayflag = false
   else
	  mousepoint = hs.mouse.getAbsolutePosition()
	  for i = 1, #mouseCircle do
		 -- mouseCircle[i] = hs.drawing.line( {x=mousepoint.x, y=mousepoint.y} , {x=(mousepoint.x+xAdd(i-1)) , y=(mousepoint.y+yAdd(i-1))})
		 -- mouseCircle[i] = hs.drawing.line( {x=(mousepoint.x+xSAdd(i)) , y=(mousepoint.y+ySAdd(i))} , {x=(mousepoint.x+xAdd(i)) , y=(mousepoint.y+yAdd(i))})
		 angle = math.random() * 2 * math.pi
		 r = math.random()
		 -- mouseCircle[i] = hs.drawing.line( {x=(mousepoint.x+xSAdd(angle)) , y=(mousepoint.y+ySAdd(angle))} , {x=(mousepoint.x+xAdd(angle)) , y=(mousepoint.y+yAdd(angle))})
		 mouseCircle[i] = hs.drawing.line( {x=(mousepoint.x+xSAdd(angle, r)) , y=(mousepoint.y+ySAdd(angle, r))} , {x=(mousepoint.x+xAdd(angle)) , y=(mousepoint.y+yAdd(angle))})

		 depth = math.random()
		 -- mouseCircle[i]:setStrokeColor({["red"]=0.9,["blue"]=0.9,["green"]=0.9,["alpha"]=0.7})
		 mouseCircle[i]:setStrokeColor({["red"]=depth,["blue"]=depth,["green"]=depth,["alpha"]=depth})

		 width = math.random() * 3
		 -- mouseCircle[i]:setStrokeWidth(2)
		 mouseCircle[i]:setStrokeWidth(width)
		 mouseCircle[i]:show()
	  end
	  displayflag = true
   end
end
-- hs.hotkey.bind({"cmd"}, "/", mytest3)





--
function str(x)
  return x .. ""
end

c = require("hs.canvas")
mousefocus = nil
mousefocusflag = false
function buildElement(mousex, mousey)
   mousefocus = c.new{x=0, y=0, h=displaysize.h, w=displaysize.w}
   mousefocus:appendElements(
	  {
		 action = "build", padding = 0, radius = ".025", reversePath = true, type = "circle",
		 center = { x = mousex, y = mousey },
	  },
	  {
		 action = "fill",
		 fillColor = { alpha = 0.5, red = 0.5, green = 0.5, blue = 0.5},
		 frame = { x = "0", y = "0", h = "1.0", w = "1.0", },
		 type = "rectangle",
		 withShadow = true,
	  }
   )
end

function toggle_mousefocus()
   if mousefocusflag then
	  mousefocus:hide()
	  mousefocusflag = false
   else
	  sc = hs.screen.mainScreen()
	  displaysize = sc:fullFrame()

	  mousepoint = hs.mouse.getAbsolutePosition()
	  buildElement(str(mousepoint.x/displaysize.w), str(mousepoint.y/displaysize.h))
	  mousefocus:show()
	  mousefocusflag = true
   end
end

hs.hotkey.bind({"cmd"}, "/", toggle_mousefocus)


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
	 toggle_mousefocus()
	 -- mytest3()
	 -- bind enter
	 -- return true, { hs.eventtap.event.newKeyEvent(hs.keycodes.map[36], true) }
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
--         disableAllHotkeys()
      elseif name == "terminus" then
         disableAllHotkeys()
      elseif name == "cool-retro-term" then
         disableAllHotkeys()
      -- elseif name == "Preview" then
      --    disableAllHotkeys()
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
-- remapKey({}, 'capslock', keyCode('ctrl'))



-- カーソル移動
-- remapKey({'ctrl'}, 'f', keyCode('right'))
-- remapKey({'ctrl'}, 'b', keyCode('left'))
-- remapKey({'ctrl'}, 'n', keyCode('down'))
-- remapKey({'ctrl'}, 'p', keyCode('up'))

-- テキスト編集
-- remapKey({'alt'}, 'd', keyCode('forwarddelete', {'alt'}))
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
