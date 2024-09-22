local module = {}

local openKey = Enum.KeyCode.F6
local aimbotKey = Enum.KeyCode.L
local fpsAimbotKey = "Mouse2"
local version = "v1"

getfenv()["nometa"] = true

module.config = {
	esp = false,
	espTeamBased = false,
	espBlockMode = 1,
	espTransparency = 0,
	aimbot = false,
	aimbotTargetEveryone = true,
	aimbotTargetNearest = true,
	aimbotThroughWalls = false,
	aimbotDampening = false,
	aimbotDampeningValue = 20,
	aimbotMethod = 2,
	aimbotCamera = false,
	healthbar = false,
	targetInvisible = false,
	hbe = false,
	hbeRadius = 5,
	hbeThroughWalls = false,
	
}
local color = {
	red = Color3.new(1, 140 / 255, 140 / 255),
	green = Color3.new(0, 1, 170 / 255),
	yellow = Color3.new(1, 1, 140 / 255),
}
local saveConfig = function()
	if writefile or true then
		writefile("bigmansteroids.config", game:GetService("HttpService"):JSONEncode(module.config))
	end
end
local w1, f1 = ypcall(function()
if readfile or true then
	local w, f = ypcall(function()
		for i, v in pairs(game:GetService("HttpService"):JSONDecode(readfile("bigmansteroids.config"))) do
			module.config[i] = v
		end
	end)
	if not w then
		warn(f)
	end
	delay(0, function()
		while wait(5) do
			ypcall(function() saveConfig() end)
		end
	end)
else
	warn("rip")
end
end)
if not w1 then
	print(f1)
end

local uiItems = {}
local uiItem = function(item)
	table.insert(uiItems, item)
end

local font = Enum.Font.SourceSans

local UserInputService = game:GetService("UserInputService")
do
	local preEnabled = {}
	if game:GetService("RunService"):IsStudio() then else
		UserInputService.WindowFocusReleased:Connect(function()
			for i, v in pairs(uiItems) do
				preEnabled[v] = (v.Enabled and true or false)
				v.Enabled = false
			end
		end)
		UserInputService.WindowFocused:Connect(function()
			for i, v in pairs(preEnabled) do
				i.Enabled = v
			end
		end)
	end
end
do
	local kcbs1 = {}
	local kcbs2 = {}
	local kcbs3 = {}
	module.onKeyDown = function(code, cb)
		kcbs1[code.Value] = cb
	end
	module.onKeyUp = function(code, cb)
		kcbs2[code.Value] = cb
	end
	module.isKeyPressed = function(code)
		return kcbs3[typeof(code) == "string" and code or code.Value]
	end
	local keyboard = Enum.UserInputType.Keyboard
	local mouse1 = Enum.UserInputType.MouseButton1
	local mouse2 = Enum.UserInputType.MouseButton2
	game:GetService("UserInputService").InputBegan:connect(function(inp)
		if inp.UserInputType == keyboard then
			local val = inp.KeyCode.Value
			kcbs3[val] = true
			if kcbs1[val] then
				kcbs1[val]()
			end
		elseif inp.UserInputType == mouse2 then
			kcbs3["Mouse2"] = true
		end
	end)
	game:GetService("UserInputService").InputEnded:connect(function(inp)
		if inp.UserInputType == keyboard then
			local val = inp.KeyCode.Value
			kcbs3[val] = false
			if kcbs2[val] then
				kcbs2[val]()
			end
		elseif inp.UserInputType == mouse2 then
			kcbs3["Mouse2"] = false
		end
	end)
end

local testing = true
if writefile then
	testing = false
end

ypcall(function() (testing and (game.Players.LocalPlayer and game.Players.LocalPlayer:WaitForChild("PlayerGui") or game.StarterGui) or game:GetService("CoreGui")):FindFirstChild("_"):Destroy() end)

--if getgenv().MTAPIMutex~=nil then return end;local function a()if is_protosmasher_caller~=nil then return 0 end;if elysianexecute~=nil then return 1 end;if fullaccess~=nil then return 2 end;if Synapse~=nil then return 3 end;return 4 end;local function b()local c=a()if c==0 then return is_protosmasher_caller end;if c==1 or c==3 then return checkcaller end;if c==2 then return IsLevel7 end;return nil end;if a()==2 then error("mt-api: Exploit not supported")end;local d={}local e={}local f={}local g={}local h={}local i={}local j={}local k={}local function l()local m=a()local n=b()local o=getrawmetatable(game)if m==0 then make_writeable(o)elseif m==2 then fullaccess(o)else setreadonly(o,false)end;local p=o.__index;local q=o.__newindex;local r=o.__namecall;o.__index=newcclosure(function(s,t)if n()then return p(s,t)end;if d[s]and d[s][t]then local u=d[s][t]if u["IsCallback"]==true then return u["Value"](s)else return u["Value"]end end;if g[t]then local v=g[t]if v["IsCallback"]==true then return v["Value"](s)else return v["Value"]end end;if j[s]and j[s][t]then return k[s][t]end;return p(s,t)end)o.__newindex=newcclosure(function(w,x,y)if n()then return q(w,x,y)end;if e[w]and e[w][x]then local z=e[w][x]if z["Callback"]==nil then return else z["Callback"](w,y)return end end;if h[x]then local A=h[x]if A["Callback"]==nil then return else A["Callback"](w,y)return end end;if j[w]and j[w][x]then local B=j[w][x]if type(y)~=B["Type"]then error("bad argument #3 to '"..x.."' ("..B["Type"].." expected, got "..type(x)..")")end;k[w][x]=y;return end;return q(w,x,y)end)local C=isluau and isluau()or false;o.__namecall=newcclosure(function(D,...)local E={...}local F=C and getnamecallmethod()or table.remove(E)if n()then if F=="AddGetHook"then if#E<1 then error("mt-api: Invalid argument count")end;local G=E[1]local H=E[2]local I=E[3]if type(G)~="string"then error("mt-api: Invalid hook type")end;if not d[D]then d[D]={}end;if I==true and type(H)~="function"then error("mt-api: Invalid callback function")end;d[D][G]={Value=H,IsCallback=I}local J=function()d[D][G]=nil end;return{remove=J,Remove=J}end;if F=="AddGlobalGetHook"then local K=E[1]local L=E[2]local M=E[3]if type(K)~="string"then error("mt-api: Invalid hook type")end;if M==true and type(L)~="function"then error("mt-api: Invalid callback function")end;g[K]={Value=L,IsCallback=M}local N=function()g[K]=nil end;return{remove=N,Remove=N}end;if F=="AddSetHook"then if#E<1 then error("mt-api: Invalid argument count")end;local O=E[1]local P=E[2]if type(O)~="string"then error("mt-api: Invalid hook type")end;if not e[D]then e[D]={}end;if type(P)=="function"then e[D][O]={Callback=P}else e[D][O]={Callback=nil}end;local Q=function()e[D][O]=nil end;return{remove=Q,Remove=Q}end;if F=="AddGlobalSetHook"then if#E<1 then error("mt-api: Invalid argument count")end;local R=E[1]local S=E[2]if type(R)~="string"then error("mt-api: Invalid hook type")end;if type(S)=="function"then h[R]={Callback=S}else h[R]={Callback=nil}end;local T=function()h[R]=nil end;return{remove=T,Remove=T}end;if F=="AddCallHook"then if#E<2 then error("mt-api: Invalid argument count")end;local U=E[1]local V=E[2]if type(U)~="string"then error("mt-api: Invalid hook type")end;if type(V)~="function"then error("mt-api: Invalid argument #2 (not function)")end;if not f[D]then f[D]={}end;f[D][U]={Callback=V}local W=function()f[D][U]=nil end;return{remove=W,Remove=W}end;if F=="AddGlobalCallHook"then if#E<2 then error("mt-api: Invalid argument count")end;local X=E[1]local Y=E[2]if type(X)~="string"then error("mt-api: Invalid hook type")end;if type(Y)~="function"then error("mt-api: Invalid argument #2 (not function)")end;i[X]={Callback=Y}local Z=function()i[X]=nil end;return{remove=Z,Remove=Z}end;if F=="AddPropertyEmulator"then if#E<1 then error("mt-api: Invalid argument count")end;local _=E[1]if type(_)~="string"then error("mt-api: Invalid hook type")end;local a0=p(D,_)local a1=type(a0)if not j[D]then j[D]={}end;if not k[D]then k[D]={}end;j[D][_]={Type=a1}k[D][_]=p(D,_)local a2=function()j[D][_]=nil;k[D][_]=nil end;return{remove=a2,Remove=a2}end;return r(D,...)end;if f[D]and f[D][F]then local a3=f[D][F]return a3["Callback"](p(D,F),unpack(E))end;if i[F]then local a4=i[F]return a4["Callback"](D,p(D,F),unpack(E))end;return r(D,...)end)if m==0 then make_readonly(o)elseif m==2 then else setreadonly(o,true)end end;l()getgenv().MTAPIMutex=true

local ui = false
do
	local gui = Instance.new("ScreenGui")
	gui.ResetOnSpawn = false
	gui.Name = "_"
	gui.IgnoreGuiInset = true
	
	uiItem(gui)
	
	local goalSizeY = false
	
	local layoutOrderNum = -1
	local layoutOrder = function()
		layoutOrderNum = layoutOrderNum + 1
		return layoutOrderNum
	end
	
	local propertyChanged = function(obj, name, cb)
		obj:GetPropertyChangedSignal(name):connect(function()
			cb(obj[name])
		end)
	end
	
	local frameTemplate = Instance.new("Frame")
	frameTemplate.BackgroundTransparency = 1
	frameTemplate.BorderSizePixel = 0
	frameTemplate.Size = UDim2.new(1, 0, 1, 0)
	module.frameTemplate = frameTemplate
	
	local windowFrame = frameTemplate:clone()
	windowFrame.Size = UDim2.new(0.2, 0, 1, 0)
	windowFrame.Position = UDim2.new(0.8, 0, 0.25, 0) -- 0.35 instead of 0.25
	
	windowFrame.Parent = gui
	
	local windowClipper = frameTemplate:clone()
	windowClipper.Size = UDim2.new(1, 0, 0, 0)
	windowClipper.Position = UDim2.new(0, 0, 0, -30)
	windowClipper.ClipsDescendants = true
	windowClipper.Parent = windowFrame
	local transitionTime = function()
		return 0.15 + (0.00005 * (goalSizeY or 0))
	end
	local ms = 0.7 -- 0.6 -- Size Thing for Window
	module.open = function()
		module.opened = true
		module.minimized = false
		local e = (game.Workspace.CurrentCamera.ViewportSize.Y * ms)
		windowClipper:TweenSize(UDim2.new(1, 0, 0, (goalSizeY and math.min(goalSizeY, e) or e)), "Out", "Sine", transitionTime(), true)
	end
	module.close = function()
		module.opened = false
		module.minimized = false
		windowClipper:TweenSize(UDim2.new(1, 0, 0, 0), "In", "Sine", transitionTime(), true)
	end
	module.minimize = function()
		module.opened = false
		module.minimized = true
		windowClipper:TweenSize(UDim2.new(1, 0, 0, 30), "In", "Sine", transitionTime(), true)
	end
	delay(1, function()
		module.open()
	end)
	local lok = 0
	local lastOpen = 0
	local ol = false
	do
		local plabel = Instance.new("TextLabel")
		do
			plabel.BackgroundTransparency = 1
			plabel.Position = UDim2.new(0.5 - (0.3 / 2), 0, 0.3, 0)
			plabel.Size = UDim2.new(0.3, 0, 0.025, 0)
			plabel.TextColor3 = Color3.new(1, 0, 0)
			plabel.TextScaled = true
			plabel.TextWrapped = true
			plabel.Text = ""
			plabel.TextTransparency = 0
			plabel.Visible = false
		end
		ol = plabel
	end
	module.onKeyDown(openKey, function()
		lastOpen = tick()
		local elapsed = (tick() - lok)
		module.ui._instance.Enabled = true
		if elapsed <= 0.35 then
			module.runESP()
		end
		lok = tick()
		if module.opened then
			module.close()
		else
			module.open()
		end
		delay(2, function()
			if module.isKeyPressed(openKey) then
				ol.Visible = true
				while module.isKeyPressed(openKey) and wait() do
					local ela = math.ceil(5 - (tick() - lastOpen))
					if ela <= 0 then
						module.ui._instance.Enabled = false
					end
					ol.Text = "HIDING GUI: " .. ela .. "..."
				end
				ol.Visible = false
			end
		end)
	end)
	module.onKeyUp(openKey, function()
		ol.Visible = false
		local openElapsed = tick() - lastOpen
		if openElapsed >= 5 then
			module.ui._instance.Enabled = false
		end
	end)
	
	local topBar = Instance.new("TextButton")
	topBar.Size = UDim2.new(1, 0, 0, 30)
	topBar.Position = UDim2.new(0, 0, 0, 0)
	topBar.BackgroundColor3 = Color3.new(18 / 255, 18 / 255, 18 / 255)
	topBar.BorderSizePixel = 0
	topBar.Font = font
	topBar.TextColor3 = Color3.new(1, 1, 1)
	topBar.Text = "BIGMAN STEROIDS"
	topBar.TextSize = 18
	topBar.AutoButtonColor = false
	topBar.Parent = windowClipper
	local lclick = 0
	topBar.MouseButton1Click:connect(function()
		local el = (tick() - lclick)
		lclick = tick()
		if el <= 0.35 then
			if module.opened then
				module.minimize()
			else
				module.open()
			end
		end
	end)
	local mouseDown = false
	if game.Players.LocalPlayer then
		local offset = false
		local mouse = game.Players.LocalPlayer:GetMouse()
		mouse.Button1Up:connect(function()
			mouseDown = false
		end)
		mouse.Button1Down:connect(function()
			if mouseDown then
				
			end
		end)
		topBar.MouseButton1Down:connect(function()
			offset = windowFrame.AbsolutePosition - UserInputService:GetMouseLocation()
			mouseDown = true
		end)
		topBar.MouseButton1Up:connect(function()
			mouseDown = false
		end)
		game:GetService("RunService"):BindToRenderStep("drag1", Enum.RenderPriority.Last.Value, function()
			if mouseDown and offset then
				if module.opened or module.minimized then
					local p = offset + UserInputService:GetMouseLocation()
					windowFrame.Position = UDim2.new(0, p.x, 0, p.y + 36)
				else
					mouseDown = false
				end
			end
		end)
	end
	
	local windowHolder = frameTemplate:clone()
	windowHolder.BackgroundTransparency = 0
	windowHolder.BackgroundColor3 = Color3.new(32 / 255, 32 / 255, 33 / 255)
	windowHolder.Size = UDim2.new(1, 0, 0, game.Workspace.CurrentCamera.ViewportSize.Y)
	windowHolder.Position = UDim2.new(0, 0, 0, 30)
	windowHolder.Parent = windowClipper
	
	local winSizeC = Instance.new("UISizeConstraint")
	winSizeC.MaxSize = Vector2.new(1000000, game.Workspace.CurrentCamera.ViewportSize.Y * ms)
	winSizeC.Parent = windowHolder
	local winSizeC2 = winSizeC:clone()
	winSizeC2.MaxSize = Vector2.new(250, 1000000)
	winSizeC2.Parent = windowFrame
	
	local scrollFrame = Instance.new("ScrollingFrame")
	scrollFrame.BackgroundTransparency = 1
	scrollFrame.MidImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	scrollFrame.TopImage = ""
	scrollFrame.BottomImage = ""
	scrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.Always
	scrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
	scrollFrame.ScrollBarThickness = 4
	scrollFrame.ScrollBarImageColor3 = Color3.new(22 / 255, 22 / 255, 23 / 255)
	scrollFrame.ElasticBehavior = Enum.ElasticBehavior.Always
	--scrollFrame.CanvasSize = 
	scrollFrame.Size = UDim2.new(1, -10, 1, -10)
	scrollFrame.BorderSizePixel = 0
	scrollFrame.Parent = windowHolder
	local ascrollFrame = frameTemplate:clone()
	ascrollFrame.Size = UDim2.new(1, -10 - 4 - 10 - 5, 1, -10)
	ascrollFrame.Position = UDim2.new(0, 5 + 5, 0, 0)
	ascrollFrame.ClipsDescendants = true
	ascrollFrame.Parent = windowHolder
	local scrollContents = frameTemplate:clone()
	scrollContents.Size = UDim2.new(1, 0, 0, 0)
	scrollContents.Parent = ascrollFrame
	local scrollLayout = Instance.new("UIListLayout")
	scrollLayout.FillDirection = Enum.FillDirection.Vertical
	scrollLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
	scrollLayout.VerticalAlignment = Enum.VerticalAlignment.Top
	scrollLayout.Padding = UDim.new(0, 4)
	scrollLayout.Parent = scrollContents
	propertyChanged(scrollLayout, "AbsoluteContentSize", function(size)
		local extr = 10 + 10
		scrollContents.Size = UDim2.new(1, 0, 0, size.Y)
		goalSizeY = size.Y + 30 + extr
		windowHolder.Size = UDim2.new(1, 0, 0, goalSizeY)
	end)
	propertyChanged(scrollContents, "AbsoluteSize", function(size)
		scrollFrame.CanvasSize = UDim2.new(0, 0, 0, size.Y)
	end)
	propertyChanged(scrollFrame, "CanvasPosition", function(pos)
		--scrollContents.Position = UDim2.new(0, 0, 0, -scrollFrame.CanvasPosition.Y)
		scrollContents:TweenPosition(UDim2.new(0, 0, 0, -scrollFrame.CanvasPosition.Y), "Out", "Sine", 0.25, true)
	end)
	
	module.ui = {}
	ui = module.ui
	module.ui._instance = gui
	module.ui._contents = scrollContents
	module.ui.add = function(a, b)
		if not b then
			if typeof(a) == "Instance" then
				a.Parent = scrollContents
			else
				a._instance.Parent = scrollContents
			end
		else
			local dest = (typeof(a) == "Instance" and a or (a._contents or a._instance))
			b._instance.Parent = dest
			if b._onAdd then
				if typeof(a) == "Instance" then
					b._onAdd({
						add = function(c)
							c.Parent = a
						end,
						_instance = a,
					})
				else
					b._onAdd(a)
				end
			end
		end
	end
	
	ol.Parent = module.ui._instance
	
	local templates = {}
	module.ui.create = function(name, config, cb)
		local config2 = config
		local cb2 = cb
		if not cb then
			if config and typeof(config) == "function" then
				config2 = {}
				cb2 = config
			elseif typeof(config) == "table" then
				cb2 = function() end
			else
				config2 = {}
				cb2 = function() end
			end
		end
		return templates[name](config2, cb2)
	end
	local addTemplate = function(name, cb)
		templates[name] = function(...)
			local a = {
				
			}
			a.add = function(...)
				return module.ui.add(a, ...)
			end
			a.parent = function(b, ...)
				return module.ui.add(b, a, ...)
			end
			cb(a, ...)
			local cb2 = {...}
			cb2 = cb2[#cb2]
			if typeof(cb2) == "function" then
				cb2(a)
			end
			return a
		end
	end
	
	do
		addTemplate("tab", function(obj, config, cb)
			local frame1 = frameTemplate:clone()
			frame1.Size = UDim2.new(1, 0, 0, 0)
			obj._instance = frame1
			frame1.LayoutOrder = layoutOrder()
			local frame2 = frame1:clone()
			frame2.Size = UDim2.new(1, -15, 0, 0)
			frame2.Position = UDim2.new(0, 15, 0, 0)
			frame2.Parent = frame1
			local layout1 = scrollLayout:clone()
			layout1.Parent = frame2
			obj._contents = frame2
			--[[local frame3 = frame1:clone()
			frame3.LayoutOrder = layoutOrder()
			obj._onAdd = function(par)
				par.add(frame3)
			end]]
			propertyChanged(layout1, "AbsoluteContentSize", function(size)
				frame2.Size = UDim2.new(1, -15, 0, size.Y)
				frame1.Size = UDim2.new(1, 0, 0, size.Y)
			end)
		end)
		addTemplate("title", function(obj, config, cb)
			local label1 = Instance.new("TextLabel")
			label1.TextColor3 = Color3.new(1, 1, 110 / 255)
			label1.TextSize = 18
			label1.BackgroundTransparency = 1
			label1.LayoutOrder = layoutOrder()
			label1.Size = UDim2.new(1, 0, 0, 30)
			label1.TextXAlignment = Enum.TextXAlignment.Left
			label1.Font = font
			obj._instance = label1
			if config.text then
				label1.Text = config.text
			end
			obj.text = function(str)
				label1.Text = str
			end
		end)
		addTemplate("label", function(obj, config, cb)
			local label1 = Instance.new("TextLabel")
			label1.TextColor3 = Color3.new(1, 1, 1)
			label1.TextSize = 18
			label1.BackgroundTransparency = 1
			label1.LayoutOrder = layoutOrder()
			label1.Size = UDim2.new(1, 0, 0, 30)
			label1.TextXAlignment = Enum.TextXAlignment.Left
			label1.Font = font
			obj._instance = label1
			if config.text then
				label1.Text = config.text
			end
			obj.text = function(str)
				label1.Text = str
			end
		end)
		addTemplate("label2", function(obj, config, cb)
			local btn1 = Instance.new("TextLabel")
			btn1.BackgroundTransparency = 1
			btn1.TextColor3 = Color3.new(1, 1, 1)
			btn1.TextSize = 18
			btn1.Size = UDim2.new(1, 0, 0, 20)
			btn1.LayoutOrder = layoutOrder()
			btn1.TextXAlignment = Enum.TextXAlignment.Left
			btn1.Font = font
			obj._instance = btn1
			local status1 = Instance.new("TextLabel")
			status1.TextSize = 18
			status1.BackgroundTransparency = 1
			status1.Size = UDim2.new(1, 0, 1, 0)
			status1.TextXAlignment = Enum.TextXAlignment.Right
			status1.Font = font
			status1.TextColor3 = Color3.new(1, 1, 1)
			status1.Parent = btn1
			if config.text then
				btn1.Text = config.text[1]
				status1.Text = config.text[2]
			end
			obj.text = function(str)
				btn1.Text = str[1]
				status1.Text = str[2]
			end
		end)
		addTemplate("toggle", function(obj, config, cb)
			local btn1 = Instance.new("TextButton")
			btn1.BackgroundTransparency = 1
			btn1.TextColor3 = Color3.new(1, 1, 1)
			btn1.TextSize = 18
			btn1.Size = UDim2.new(1, 0, 0, 20)
			btn1.LayoutOrder = layoutOrder()
			btn1.TextXAlignment = Enum.TextXAlignment.Left
			btn1.Font = font
			obj._instance = btn1
			local status1 = Instance.new("TextLabel")
			local changes = {}
			obj.setState = function(stat)
				local ov = obj.value
				obj.value = stat
				if stat then
					status1.Text = (config.values and config.values[1] or "ON ")
					status1.TextColor3 = Color3.new(0, 1, 170 / 255)
				else
					status1.Text = (config.values and config.values[2] or "OFF")
					status1.TextColor3 = Color3.new(1, 140 / 255, 140 / 255)
				end
				if obj.value ~= ov then
					for i, v in pairs(changes) do
						v(obj.value)
					end
				end
			end
			if config.text then
				btn1.Text = config.text
			end
			obj.text = function(str)
				btn1.Text = str
			end
			if config.value then
				obj.setState(config.value)
			else
				obj.setState(false)
			end
			obj.toggle = function()
				obj.setState(not obj.value)
			end
			btn1.MouseButton1Click:connect(obj.toggle)
			status1.TextSize = 18
			status1.BackgroundTransparency = 1
			status1.Size = UDim2.new(1, 0, 1, 0)
			status1.TextXAlignment = Enum.TextXAlignment.Right
			status1.Font = font
			status1.Parent = btn1
			obj.changed = {
				
			}
			local a = obj.changed
			function a:connect(cb)
				table.insert(changes, cb)
				cb(obj.value)
			end
		end)
		addTemplate("slider", function(obj, config, cb)
			local btn1 = Instance.new("TextButton")
			btn1.BackgroundTransparency = 1
			btn1.TextColor3 = Color3.new(1, 1, 1)
			btn1.TextSize = 18
			btn1.Text = ""
			btn1.Size = UDim2.new(1, 0, 0, 20)
			btn1.LayoutOrder = layoutOrder()
			btn1.TextXAlignment = Enum.TextXAlignment.Left
			btn1.Font = font
			obj._instance = btn1
			local status1 = Instance.new("TextLabel")
			local changes = {}
			local barHolder = module.frameTemplate:clone()
			barHolder.BorderSizePixel = 0
			barHolder.Size = UDim2.new(1, 0, 1, 0)
			local bar = barHolder:clone()
			bar.Parent = barHolder
			bar.BackgroundColor3 = Color3.new(1, 1, 1)
			bar.BackgroundTransparency = 0.4
			barHolder.BackgroundTransparency = 0
			barHolder.BackgroundColor3 = Color3.new(40 / 255, 40 / 255, 42 / 255)
			barHolder.Position = UDim2.new(0, 0, 0.5, 0)
			barHolder.Size = UDim2.new(0.8, 0, 0.2, 0)
			barHolder.Parent = btn1
			bar.ZIndex = bar.ZIndex + 1
			obj.setValue = function(stat)
				local ov = obj.value
				obj.value = math.max(config.min, math.min(config.max, stat))
				obj.percent = (obj.value - config.min) / (config.max - config.min)
				status1.Text = tostring(math.floor(obj.value))
				bar.Size = UDim2.new(1 * obj.percent, 0, 1, 0)
				if obj.value ~= ov then
					for i, v in pairs(changes) do
						v(obj.value)
					end
				end
			end
			if config.value then
				obj.setValue(config.value)
			else
				obj.setValue(0)
			end
			local mdown = false
			local startPos = false
			btn1.MouseButton1Down:connect(function()
				mdown = true
				startPos = UserInputService:GetMouseLocation()
				delay(0, function()
					while mdown do
						local pos = UserInputService:GetMouseLocation()
						local pos2 = pos - btn1.AbsolutePosition
						local prog = pos2.x / (0.8 * btn1.AbsoluteSize.X)
						--print(prog)
						obj.setValue((prog * (config.max - config.min)) + config.min)
						wait()
					end
				end)
			end)
			btn1.MouseButton1Up:connect(function()
				mdown = false
			end)
			game.Players.LocalPlayer:GetMouse().Button1Up:connect(function()
				mdown = false
			end)
			status1.TextSize = 18
			status1.BackgroundTransparency = 1
			status1.Position = UDim2.new(0.8, 0, 0, 0)
			status1.Size = UDim2.new(0.2, 0, 1, 0)
			status1.TextColor3 = Color3.new(1, 1, 1)
			status1.TextXAlignment = Enum.TextXAlignment.Right
			status1.Font = font
			status1.Parent = btn1
			obj.changed = {
				
			}
			local a = obj.changed
			function a:connect(cb)
				table.insert(changes, cb)
				cb(obj.value)
			end
		end)
		addTemplate("cycle", function(obj, config, cb)
			local btn1 = Instance.new("TextButton")
			btn1.BackgroundTransparency = 1
			btn1.TextColor3 = Color3.new(1, 1, 1)
			btn1.TextSize = 18
			btn1.Size = UDim2.new(1, 0, 0, 20)
			btn1.LayoutOrder = layoutOrder()
			btn1.TextXAlignment = Enum.TextXAlignment.Left
			btn1.Font = font
			obj._instance = btn1
			local status1 = Instance.new("TextLabel")
			local changes = {}
			obj.setState = function(stat)
				local ov = obj.value
				obj.value = stat
				status1.Text = config.values[stat][1]
				status1.TextColor3 = config.values[stat][2]
				if obj.value ~= ov then
					for i, v in pairs(changes) do
						v(obj.value)
					end
				end
			end
			obj.cycle = function()
				if obj.value >= #config.values then
					obj.setState(1)
				else
					obj.setState(obj.value + 1)
				end
			end
			if config.text then
				btn1.Text = config.text
			end
			obj.text = function(str)
				btn1.Text = str
			end
			if config.value then
				obj.setState(config.value)
			else
				obj.setState(false)
			end
			btn1.MouseButton1Click:connect(obj.cycle)
			status1.TextSize = 18
			status1.BackgroundTransparency = 1
			status1.Size = UDim2.new(1, 0, 1, 0)
			status1.TextXAlignment = Enum.TextXAlignment.Right
			status1.Font = font
			status1.Parent = btn1
			obj.changed = {
				
			}
			local a = obj.changed
			function a:connect(cb)
				table.insert(changes, cb)
				cb(obj.value)
			end
		end)
		addTemplate("atab", function(obj, config, cb)
			
		end)
	end
	
	--[[delay(0, function()
		while gui.Parent do
			module.open()
			wait(2)
			module.close()
			wait(3)
		end
	end)]]
	
	do
		-- Health Bar
		local barHolder = frameTemplate:clone()
		barHolder.BackgroundColor3 = Color3.new(32 / 255, 32 / 255, 33 / 255)
		local bar = barHolder:clone()
		barHolder.BackgroundTransparency = 0.75
		bar.BackgroundTransparency = 0
		barHolder.Visible = false
		barHolder.Position = UDim2.new(0.4, 0, 0.2, 0)
		barHolder.Size = UDim2.new(0.2, 0, 0.005, 0)
		bar.Parent = barHolder
		barHolder.Parent = module.ui._instance
		local colors = {
			{1, 140 / 255, 140 / 255},
			{1, 1, 140 / 255},
			{0, 1, 170 / 255},
		}
		local godColor = Color3.new(170 / 255, 0, 1)
		local lerp = function(a, b, t)
		    return a * (1-t) + (b*t)
		end
		local progToColor = function(prog)
			local prog2 = prog * (#colors)
			local st = colors[math.max(1, math.floor(prog2))]
			local ed = colors[math.min(#colors, math.floor(prog2) + 1)]
			local prog3 = prog2 - math.floor(prog2)
			return Color3.new(lerp(st[1], ed[1], prog3), lerp(st[2], ed[2], prog3), lerp(st[3], ed[3], prog3))
		end
		local upd = function(prog, fc)
			local col = (fc or progToColor(prog))
			barHolder.BackgroundColor3 = col
			bar.BackgroundColor3 = col
			bar.Size = UDim2.new(prog, 0, 1, 0)
			if prog >= 1 then
				barHolder.Visible = false
			else
				barHolder.Visible = module.config.healthbar
			end
		end
		local connectHuman = function(hum)
			upd(hum.Health / hum.MaxHealth)
			hum:GetPropertyChangedSignal("Health"):connect(function()
				if tostring(hum.Health) == "inf" or hum.Health >= 99999999 then
					upd(1, godColor)
				else
					upd(hum.Health / hum.MaxHealth)
				end
			end)
		end
		game.Players.LocalPlayer.CharacterAdded:connect(function(char)
			repeat wait() until not char.Parent or char:FindFirstChildWhichIsA("Humanoid")
			connectHuman(char:FindFirstChildWhichIsA("Humanoid"))
		end)
		if game.Players.LocalPlayer.Character then
			spawn(function()
				local char = game.Players.LocalPlayer.Character
				repeat wait() until not char.Parent or char:FindFirstChildWhichIsA("Humanoid")
				connectHuman(char:FindFirstChildWhichIsA("Humanoid"))
			end)
		end
	end
	
	local dest = (testing and (game.Players.LocalPlayer and game.Players.LocalPlayer:WaitForChild("PlayerGui") or game.StarterGui) or game:GetService("CoreGui"))
	if dest:FindFirstChild(gui.Name) then
		dest[gui.Name]:Destroy()
	end
	gui.Parent = dest
end

do
	--Aimbot
	module.targets = {}
	module.ignoreTargets = {}
	
	local framerate = 0
	local frametime = 9999
	
	module.isBlocked = function(p)
		getfenv()["nometa"] = true
		local cf = game.Workspace.CurrentCamera.CoordinateFrame.p
		local ray = Ray.new(cf, (p.Position - cf).unit * (p.Position - cf).magnitude)
		local hit, pos = game.Workspace:FindPartOnRayWithIgnoreList(ray, module.chars)
		if not hit or hit:IsDescendantOf(p.Parent) then
			return false
		else
			return true
		end
	end
	
	module.lastMove = Vector2.new(0, 0)
	local avps = game.Workspace.CurrentCamera.ViewportSize
	local avgdots = (avps.X + avps.Y) / 2
	local dotspeed = avgdots * 6 --0.6
	local zv2a = Vector2.new(0, 0)
	local z = 50
	local da = 14 --7 --4 --0.25
	local t = 0
	module.realism = function()
		if module.config.aimbotDampening then
			t = t + (frametime * da)
			local mx = (math.abs(module.lastMove.x * framerate) / dotspeed) / 5
			local my = (math.abs(module.lastMove.y * framerate) / dotspeed) / 5
			local m = module.config.aimbotDampeningValue / z
			--print(mx .. " => " .. my)
			wait()
			return Vector2.new(math.sin(t) * m * (1 + (1 * mx)) * 1, math.cos(t) * m * (1 + (1 * my)) * 1)
		else
			return zv2a
		end
	end
	module.realism2 = function()
		if module.config.aimbotDampening then
			t = t + (frametime * da)
			local mx = module.lastMove.x * framerate
			local my = module.lastMove.y * framerate
			local m = module.config.aimbotDampeningValue / z
			local x = da * m * (mx / dotspeed) * math.sin(t)
			local y = da * m * (my / dotspeed) * math.cos(t)
			--print(mx / dotspeed .. " => " .. x)
			return Vector2.new(x, y)
		else
			return zv2a
		end
	end
	local r3ofsx = 0
	local r3ofsy = 0
	local addr3ofsx = function()
		local a = 2 --2
		local x = tick()
		return 2 * ((x * 1/a) - math.floor(x * 1/a)) - (a/2)
	end
	local addr3ofsy = function()
		local a = 2 --2
		local x = tick()
		return 2 * ((-x * 1/a) - math.floor(-x * 1/a)) - (a/2)
	end
	module.realism3 = function()
		if module.config.aimbotDampening then
			t = t + (frametime * da)
			local mx = (math.abs(module.lastMove.x * framerate) / dotspeed) / 5
			local my = (math.abs(module.lastMove.y * framerate) / dotspeed) / 5
			local m = module.config.aimbotDampeningValue / z
			--print(mx .. " => " .. my)
			wait()
			r3ofsx = 0*r3ofsx + addr3ofsx()
			r3ofsy = 0*r3ofsy + addr3ofsy()
			return Vector2.new(r3ofsx * math.sin(t) * m * (1 + (1 * mx)), r3ofsy * math.cos(t) * m * (1 + (1 * my)))
		else
			return zv2a
		end
	end
	
	local aofs = Vector3.new(0, 2.144, 0)
	module.getPos = function(roota, extra)
		local root = roota
		local pos3D = root.Position --+ aofs
		if extra then
			pos3D = pos3D + extra
		end
		local pos2D, isVisible = game.Workspace.CurrentCamera:WorldToViewportPoint(pos3D)
		if isVisible then
			local p2 = (extra and game.Workspace.CurrentCamera:WorldToViewportPoint(pos3D - extra) or pos2D)
			return Vector2.new(pos2D.x, pos2D.y), Vector2.new(p2.x, p2.y)
		end
		return false, false
	end
	local getPos = module.getPos
	
	module.megadetect = 1
	local mulper = 0.5
	local md = 2000
	local mulfactor = function(p, fp)
		local dist = (p - fp).magnitude
		dist = math.min(dist, md)
		local fact = (((1 - (dist / md)) * mulper) + (mulper))
		return fact
	end
	local chooseTarget = function(targs, r)
		local fp = game.Workspace.CurrentCamera.Focus.p
		local curPos = UserInputService:GetMouseLocation()
		local closestDist = (r or 50 * module.megadetect) --200 --50
		if module.firstPerson then
			closestDist = closestDist * 4
		end
		local closestPlr = false
		for i, v in pairs(targs) do
			if v[2] and v[2].Parent then
				if not module.ignoreTargets[v[2]] then
					local pos = getPos(v[2])
					local hum = v[2].Parent:FindFirstChildWhichIsA("Humanoid")
					if not hum or (hum and hum.Health > 0) then
						--local throughWall = module.isBlocked(v[2])
						if pos then--if pos and ((throughWall and module.config.aimbotThroughWalls) or not throughWall) then
							pos = Vector2.new(pos.x, pos.y)
							local dist = (pos - curPos).magnitude * mulfactor(v[2].Position, fp)
							if dist <= closestDist then
								closestDist = dist
								closestPlr = v
							end
						end
					end
				end
			end
		end
		if closestPlr then
			module.closestTarget = closestPlr
			return closestPlr
		end
		module.closestTarget = false
		return false
	end
	module.chooseTarget = chooseTarget
	
	local tracking = false
	local lastTarg = false
	
	local targLine = false
	local vps = game.Workspace.CurrentCamera.ViewportSize
	local lh = 1
	local linecenter = Vector2.new(vps.X * 0.5, vps.Y * lh)
	do
		local targf = module.frameTemplate:clone()
		targf.Parent = module.ui._instance
		targf.Size = UDim2.new(0, 0, 0, 0)
		local targl = targf:clone()
		local thickness = 2 --1
		targl.BackgroundTransparency = 0
		targl.BorderSizePixel = 0
		targl.Parent = targf
		targf.Visible = false
		local nine0 = 90 --math.rad(90)
		targLine = function(pos1, pos2, c)
			if  pos1 and pos2 then
				targf.Visible = true
				targf.Position = UDim2.new(0, pos1.x, 0, pos1.y)
				local dist = (pos1 - pos2).magnitude
				targl.Size = UDim2.new(0, thickness, 0, -dist)
				local hd = pos2.y - pos1.y
				local wd = pos2.x - pos1.x
				local ang = math.atan(hd / wd)
				local ang2 = math.deg(ang) - nine0
				if pos2.x > pos1.x then
					ang2 = ang2 + 180
				end
				targf.Rotation = ang2
				targl.BackgroundColor3 = c
			else
				targf.Visible = false
			end
		end
	end
	
	local mxx = game.Workspace.CurrentCamera.ViewportSize.X
	local mxy = game.Workspace.CurrentCamera.ViewportSize.Y
	local deadzone = 10
	local clamp = function(a, b, c)
		return math.max(a + deadzone, math.min(b - deadzone, c))
	end
	local mxint = mxy * 0.8
	local posToMouseMove = function(pos2D)
		if pos2D then
			local curPos = UserInputService:GetMouseLocation()
			--local movement = Vector2.new(-(curPos.x - pos2D.x) / 2, -(curPos.y - pos2D.y) / 2)
			local movement = Vector2.new(-(curPos.x - pos2D.x) / 2, -(curPos.y - pos2D.y) / 2)
			--print(movement)
			if curPos.x + movement.x < 0 or curPos.x + movement.x > mxx then
				movement = Vector2.new(0, movement.y)
			end
			if curPos.y + movement.y < 0 or curPos.y + movement.y > mxy then
				movement = Vector2.new(movement.x, 0)
			end
			local mxint2 = mxint * frametime
			if math.abs(movement.x) > mxint2 then
				movement = Vector2.new(mxint2 * (movement.x < 0 and -1 or 1), movement.y)
			end
			if math.abs(movement.y) > mxint2 then
				movement = Vector2.new(movement.x, mxint2 * (movement.y < 0 and -1 or 1))
			end
			return movement
		end
		return false
	end
	
	math.randomseed(tick())
	local zv2 = Vector2.new(0, 0)
	local zv3 = Vector3.new(0, 0, 0)
	local dampenScale = 1 --15
	local metha = 2 -- 1 = randomization, 2 = sines and shit
	local dampen3D = function()
		if module.config.aimbotDampening then
			if metha == 1 then
				local n = math.random(1, 100)
				if n < module.config.aimbotDampeningValue then
					local ds = dampenScale * (1 + (2 * (module.config.aimbotDampeningValue / 100)))
					return Vector3.new(math.random(-ds, ds) * 1, math.random(-ds, 0) * 1, math.random(-ds, ds) * 1)
				else
					return zv3
				end
			else
				local rm = module.realism3()
				local n = math.random(1, 100)
				local adv = (module.config.aimbotDampeningValue / 100) * 5
				if n < module.config.aimbotDampeningValue then
					return Vector3.new(rm.x * adv, (rm.y - 1) * adv, rm.x * adv)
				else
					return zv3
				end
			end
		end
		return zv3
	end
	local ld2 = Vector2.new()
	local mulx = function()
		return ld2.x > 0 and -1 or 1
	end
	local muly = function()
		return ld2.y > 0 and -1 or 1
	end
	local dampen2D = function()
		local ve = false
		if module.config.aimbotDampening then
			local adv = (module.config.aimbotDampeningValue / 100) * 2
			local n = math.random(1, 100)
			if n < module.config.aimbotDampeningValue or true then
				---ve = Vector2.new(math.abs(math.random(0, dampenScale)) * mulx() * adv, math.abs(math.random(0, dampenScale)) * muly() * adv)
				ve = module.realism()
				ve = Vector2.new(ve.x * adv, ve.y * adv)
			else
				--ve = zv2
				--return zv2
			end
		end
		if not ve then ve = zv2 end
		ld2 = ve
		return ve
		--return zv2
	end
	
	local rad = (mxy / 2) * 0.85 --0.75
	local inRadius = function(pos2D)
		local mag = Vector2.new(math.abs(pos2D.x - (mxx / 2)), math.abs(pos2D.y - (mxy / 2))).magnitude
		--print(mag .. " <= " .. rad)
		return (mag <= rad)
	end
	local ext = 3 --2
	local doy = true
	local fixCamera = function(pos2D, pos3D)
		if inRadius(pos2D) then
		elseif module.config.aimbotCamera then
			--game.Workspace.CurrentCamera.CoordinateFrame = game.Workspace.CurrentCamera.CoordinateFrame:Lerp(CFrame.new(game.Workspace.CurrentCamera.CoordinateFrame.p, pos3D), frametime * ext)
			local cam = game.Workspace.CurrentCamera
			local foc = cam.Focus
			local cor = cam.CoordinateFrame
			local cf0 = (cor - cor.p) * CFrame.new(0, 0, -5)
			local cf1 = CFrame.new(foc.p) * cf0
			local cf2 = CFrame.new(foc.p, Vector3.new(cf1.x, doy and cf1.y or foc.p.y, cf1.z))
			local cf3 = cf2:inverse() * cor
			local cf4 = CFrame.new(foc.p, pos3D)
			local cf5 = cf4 * cf3
			cam.CoordinateFrame = cor:Lerp(cf5, frametime * ext)
		end
	end
	
	local dampenMethod = "3D" -- "3D"
	
	local interceptTarget = function(plr, fp)
		local targ = false
		targ = plr[4] or plr[2]
		local av = zv2a
		if targ then
			if not module.config.aimbotThroughWalls then
				local blocked = module.isBlocked(targ)
				if blocked then
					return false
				end
			end
			local dam1 = ((dampenMethod == "3D" and not fp) and dampen3D() or Vector3.new())
			local dam2 = ((dampenMethod == "2D" and not fp) and dampen2D() or Vector2.new())
			local pos, actualPos = getPos(targ, dam1)
			--currentTargetPos = pos
			vps = game.Workspace.CurrentCamera.ViewportSize
			linecenter = Vector2.new(vps.X * 0.5, vps.Y * lh)
			if module.ui._instance.Enabled then targLine(linecenter, actualPos, module.cols[ plr[5] ]) else targLine(false) end
			local movement = posToMouseMove(pos)
			if pos then
				fixCamera(pos, targ.Position)
			end
			if movement and mousemoverel then
				if module.isKeyPressed("Mouse2") and not module.firstPerson then
				else
					av = movement
					movement = movement + dam2
					--print(dam2)
					mousemoverel(movement.x, movement.y)
				end
			elseif movement then
				--print(movement)
				module.lastMove = zv2a
			end
		end
		module.lastMove = av
	end
	
	-- New Aimbot
	function lerp(a, b, t)
		return a * (1-t) + (b*t)
	end
	
	local lp2 = Vector2.new()
	local ac = {
		x = 0,
		y = 0,
	}
	local acdeadzone = 2
	local acfactor = 0 --0.5 --0.25
	local accuracyFactor = 0 --100 --0 --100 --50 --0 --100 -- 0 to 100
	local accFact =  (1 - ((accuracyFactor) / 100))
	local accRandFact = 1 + (2 * accFact)
	local accSpeedFact = 1 + ((accuracyFactor) / 100)
	--warn(accFact)
	local acfactor2 = 0.55
	local accel = function(p, p2)
		local before = lp2[p]
		local after = p2[p]
		local r = frametime * 4 * accFact --(1 + ((100 - accuracyFactor) / 100)) --30 --1 --0.1
		local ar = r + 0
		local acd = 0 --2 * acdeadzone * r
		local fp = 1 + acfactor2 --1.1
		local fd = 0.5 --1 - acfactor2 --0.9
		local df = math.abs(after - before)
		--r = r * (1 - math.min(0.5, (10 / df)))
		if (after >= 0 and ac[p] < 0 and before < 0) or (after <= 0 and ac[p] > 0 and before > 0) then
			-- You just crossed the thing
			--warn("CROSSED")
			if ac[p] > 0 then
				ac[p] = ac[p] * fd -- - r
			elseif ac[p] < 0 then
				ac[p] = ac[p] * fd -- + r
			end
		else
			if after > 0 then
				ac[p] = (ac[p] + r) * 1.001 --* (2 * accRandFact)
			elseif after < 0 then
				ac[p] = (ac[p] - r) * 1.001 --* (2 * accRandFact)
			end
		end
		return ac[p]
	end
	local lastDist = 0
	local NEWinterceptTarget = function(plr, nfc)
		local targ = false
		targ = plr[4] or plr[2]
		local av = zv2a
		if targ then
			local dist = (game.Workspace.CurrentCamera.CFrame.p - targ.Position).magnitude
			if not module.config.aimbotThroughWalls then
				local blocked = module.isBlocked(targ)
				if module.firstPerson then
					if ((lastDist + 1) / (dist + 1)) <= 0.75 or lastDist == 0 then
						blocked = true
						lastTarg = false
					end
				end
				if blocked then
					return false
				end
			end
			lastDist = dist
			local pos, actualPos = getPos(targ)
			if pos and not nfc then
				fixCamera(pos, targ.Position)
			end
			if pos then
				local curPos = UserInputService:GetMouseLocation()
				local df = (pos - curPos).magnitude
				local dff = accSpeedFact * math.min(15, math.max(5, (((mxx + mxy) / 2) / (5 * accRandFact)) / (df/2)))
				local p = math.min(1, frametime * 1 * dff * (2 - accFact)) --(1 + ((100 - accuracyFactor) / 100))
				local goalPos = Vector2.new(lerp(curPos.x, pos.x, p), lerp(curPos.y, pos.y, p))
				local pos2 = posToMouseMove(goalPos)
				--print(pos2)
				local spf = 1 * 1 * accRandFact --2
				local pos3 = Vector2.new(pos2.x + (spf * accel("x", pos2)), pos2.y + (spf * accel("y", pos2)))
				--print(df .. " => " .. dff .. " => " .. p .. " => " .. "(" .. ac.x .. ", " .. ac.y .. ")")
				lp2 = pos2
				local fct = 0.5
				mousemoverel(pos3.x * 1 * (module.firstPerson and fct or 1), pos3.y * 1 * (module.firstPerson and fct or 1))
				vps = game.Workspace.CurrentCamera.ViewportSize
				linecenter = Vector2.new(vps.X * 0.5, vps.Y * lh)
				if module.ui._instance.Enabled then targLine(linecenter, actualPos, module.cols[ plr[5] ]) else targLine(false) end
			end
		end
	end
	local FPSinterceptTarget = function(plr)
		local targ = false
		targ = plr[4] or plr[2]
		local av = zv2a
		if targ then
			if not module.config.aimbotThroughWalls then
				local blocked = module.isBlocked(targ)
				if blocked then
					return false
				end
			end
		end
	end
	
	local lt = tick()
	local localHuman = false
	local getHum = function(char)
		local humm = char:FindFirstChildWhichIsA("Humanoid")
		if humm then
			localHuman = humm
		else
			localHuman = false
		end
	end
	game.Players.LocalPlayer.CharacterAdded:connect(getHum)
	if game.Players.LocalPlayer.Character then
		getHum(game.Players.LocalPlayer.Character)
	end
	module.aimbotMainline = function(targs)
		local c = tick()
		local el = (c - lt)
		lt = c
		framerate = (60 / el)
		frametime = el
		module.targs = targs
		local ctarg = chooseTarget(targs)
		if module.config.aimbotMethod == 1 then
			local camdist = (game.Workspace.CurrentCamera.Focus.p - game.Workspace.CurrentCamera.CoordinateFrame.p).magnitude
			if game:GetService("Players").LocalPlayer.CameraMode.Value == 1 or UserInputService.MouseBehavior.Value >= 1 then
				module.firstPerson = true
			else
				module.firstPerson = false
			end
			if module.config.aimbot and (module.isKeyPressed(aimbotKey) or ((module.firstPerson or camdist <= 1) and module.isKeyPressed(fpsAimbotKey))) then
				--print("yeah aimbot")
				module.megadetect = 1
				if lastTarg and lastTarg[2] then
					if not module.config.aimbotThroughWalls then
						local blocked = module.isBlocked(lastTarg[2])
						if blocked then
							lastTarg = false
						end
					end
				end
				local targ = (lastTarg or ctarg) --chooseTarget(targs))
				if not targ then
					--print(tostring(module.config.aimbotTargetNearest) .. " => " .. tostring(module.closest) .. " => " .. tostring(module.closest.dist))
					if module.config.aimbotTargetNearest and module.closest and module.closest.dist <= 50 then
						--targ = module.closest.plr
						module.megadetect = 5
						targ = (lastTarg or chooseTarget(targs))
					end
				end
				if targ then
					interceptTarget(targ)
					lastTarg = targ
				else
					lastTarg = false
					targLine(false)
				end
			else
				lastTarg = false
				targLine(false)
			end
		elseif module.config.aimbotMethod == 2 then
			local camdist = (game.Workspace.CurrentCamera.Focus.p - game.Workspace.CurrentCamera.CoordinateFrame.p).magnitude
			if --[[game:GetService("Players").LocalPlayer.CameraMode.Value == 1 or]] UserInputService.MouseBehavior.Value == 1 then
				module.firstPerson = true
			else
				module.firstPerson = false
			end
			if module.config.aimbot and (module.isKeyPressed(aimbotKey) or ((module.firstPerson) and module.isKeyPressed(fpsAimbotKey))) and (not localHuman or (localHuman and localHuman.Health > 0)) then
				--print("yeah aimbot")
				module.megadetect = 1
				if lastTarg and lastTarg[2] then
					if not module.config.aimbotThroughWalls then
						local blocked = module.isBlocked(lastTarg[2])
						if blocked then
							lastTarg = false
						end
					end
					if lastTarg then
						local hum = lastTarg[2].Parent:FindFirstChildWhichIsA("Humanoid")
						if hum and hum.Health <= 0 then
							lastTarg = false
						end
					end
				end
				local targ = (lastTarg or ctarg) --chooseTarget(targs))
				if not targ then
					--print(tostring(module.config.aimbotTargetNearest) .. " => " .. tostring(module.closest) .. " => " .. tostring(module.closest.dist))
					if module.config.aimbotTargetNearest and module.closest and module.closest.dist <= 50 then
						--targ = module.closest.plr
						module.megadetect = 5
						targ = (lastTarg or chooseTarget(targs))
					end
				end
				if module.config.aimbotDampening then
					accuracyFactor = 100 - module.config.aimbotDampeningValue
				else
					accuracyFactor = 100
				end
				accFact =  (1 - ((accuracyFactor) / 100))
				accRandFact = 1 + (2 * accFact)
				accSpeedFact = 1 + ((accuracyFactor) / 100)
				if targ then
					--[[if module.firstPerson then
						FPSinterceptTarget(targ)
					else]]
						NEWinterceptTarget(targ, module.firstPerson)
					--end
					lastTarg = targ
				else
					lastTarg = false
					targLine(false)
				end
			else
				lastTarg = false
				targLine(false)
				lastDist = 0
			end
		else
			
		end
	end
	game:GetService("RunService"):BindToRenderStep("aim", Enum.RenderPriority.Last.Value, function()
		module.aimbotMainline(module.targets)
	end)
end

--HBE thing test guy

do
	local gw = game.Workspace
	local rs = game.ReplicatedStorage
	local rf = game.ReplicatedFirst
	local lp = game.Players.LocalPlayer
	local gd = function(r, p)
		local p1 = r.Unit:ClosestPoint(p)
		--print(tostring(p) .. " => " .. tostring(p1))
		local d1 = (p1 - p).magnitude
		return d1
	end
	for _, name in pairs({
		"FindPartOnRay",
		"FindPartOnRayWithIgnoreList",
		"FindPartOnRayWithWhitelist",
	}) do
		gw:AddCallHook(name, function(original, ray, ...)
			--[[local nometa = true
			if getfenv(3)["nometa"] or debug.getlocal(3, "nometa") or checkcaller() or is_protosmasher_caller() then
				return original(gw, ray, ...)
			end
			getfenv()["nometa"] = true]]
			local scrr = getfenv(3)["script"]
			if scrr then
				if scrr.Name ~= "CameraModule" and scrr.Name ~= script.Name and not scrr.Name:match("ectat") and (scrr:IsDescendantOf(rs) or scrr:IsDescendantOf(lp) or scrr:IsDescendantOf(rf) or (scrr:IsDescendantOf(gw) and lp.Character and scrr:IsDescendantOf(lp.Character))) then
					--print("DOING A RAYCAST HITBOX EXPAND")
					--print(scrr.Name)
					--local a = "0"
					if module.closestTarget then
						--a = "1"
						if module.config.hbe and module.config.hbeRadius then
							--a = "2"
							module.chooseTarget(module.targs, 999999)
							local d = gd(ray, module.closestTarget[2].Position)
							--warn(d)
							if d <= (1 + module.config.hbeRadius) then
								--a = "3"
								local cd = 9999999
								local cv = false
								for i2, v2 in pairs(module.closestTarget[2].Parent:GetChildren()) do
									if v2:IsA("BasePart") then
										local d2 = gd(ray, v2.Position)
										if d2 <= cd then
											cd = d2
											cv = v2
										end
									end
								end
								if cv then
									--a = "4"
									local o = {original(gw, ray, ...)}
									--print(a)
									local cpp = cv.Position + Vector3.new(math.random() * cv.Size.X - (cv.Size.X / 2), math.random() * cv.Size.Y - (cv.Size.Y / 2), math.random() * cv.Size.Z - (cv.Size.Z / 2))
									--cpp = cv.Position
									local items = {...}
									local ib = function(p)
										local cf = game.Workspace.CurrentCamera.CoordinateFrame.p
										local raya = Ray.new(cf, (p.Position - cf).unit * (p.Position - cf).magnitude)
										local hit, pos = original(gw, raya, unpack(items))
										if not hit or hit:IsDescendantOf(p.Parent) then
											return false
										else
											return true
										end
									end
									if module.config.hbeThroughWalls or not ib(cv) then
										return cv, cpp, o[3], o[4]
									end
								end
							end
						end
					end
					--print(a)
				end
			end
			return original(gw, ray, ...)
		end)
	end
end

--end of hbe test guy

do
	local bils = {}
	local osize = {}
	local ofss = {}
	module.addBillboard = function(obj, item, ofs)
		bils[obj] = item
		osize[obj] = UDim2.new(0, obj.AbsoluteSize.X, 0, obj.AbsoluteSize.Y)
		if ofs then
			ofss[obj] = ofs
		else
			ofss[obj] = UDim2.new(0, 0, 0)
		end
		--warn(osize[obj])
	end
	module.removeBillboard = function(obj)
		bils[obj] = nil
		osize[obj] = nil
		ofss[obj] = nil
	end
	--game:GetService("RunService"):BindToRenderStep("idk3", Enum.RenderPriority.Last.Value, function()
	game:GetService("RunService").Heartbeat:connect(function()
		local rootcf = game.Workspace.CurrentCamera.CoordinateFrame.p
		if module.getPos then
			for i, v in pairs(bils) do
				if v then
					local pos = module.getPos(v)
					if pos then
						i.Visible = true
						local dist = (v.Position - rootcf).magnitude
						local a = (module.lerpMinMax({
							{25, 1},
							{500 * 1, 0.1 * 2},
						}, dist))
						--print(a)
						local sz = UDim2.new(0, 0, 0, 0):lerp(osize[i], a)
						i.Position = UDim2.new(0, pos.x, 0, pos.y) -- - osize[i]:lerp(UDim2.new(0, 0, 0, 0), 0.5)
						--print(tostring(osize[i]) .. " => " .. tostring(sz))
						i.Size = sz
					else
						i.Visible = false
					end
				end
			end
		end
	end)
	
end

do
	local espTemplate = false
	do
		espTemplate = Instance.new("Part")
		espTemplate.Anchored = true
		espTemplate.Transparency = 1
		espTemplate.CanCollide = false
		espTemplate.Size = Vector3.new(4.25, 5.25, 0.05)
		local sGui = Instance.new("SurfaceGui")
		sGui.Active = false
		sGui.Adornee = espTemplate
		sGui.Face = Enum.NormalId.Front
		sGui.AlwaysOnTop = true
		sGui.LightInfluence = 0
		sGui.ResetOnSpawn = false
		sGui.CanvasSize = Vector2.new(400 * 4, 500 * 4)
		local siding = Instance.new("Frame")
		siding.BorderSizePixel = 0
		--module.addBillboard(exTemplate, game.Workspace:WaitForChild("Baseplate"))
		do
			module.createX = function(obj)
				local ib = module.isBlocked(obj)
				local exTemplate = Instance.new("Frame")
				exTemplate.Parent = module.ui._instance
				exTemplate.Size = UDim2.new(0, 50, 0, 50)
				exTemplate.BackgroundTransparency = 1
				local exTemplate2 = module.frameTemplate:clone()
				exTemplate2.Position = UDim2.new(0.5, 0, 0.5, 0)
				exTemplate2.Parent = exTemplate
				local exl = module.frameTemplate:clone()
				exl.Size = UDim2.new(1, 0, 0.05, 0)
				exl.Position = UDim2.new(-1, 0, -0.5, 0) --UDim2.new(0, 0, 0, 1)
				local t = (module.config.esp and (module.config.espBlockMode >= 2 and (ib and ((module.config.espTransparency / 100) * 0.5) or 0) or 0) or 1)
				exl.BackgroundTransparency = t
				exl.BorderSizePixel = 0
				exl.Rotation = 45
				exl.Parent = exTemplate2
				local exl2 = exl:clone()
				exl2.Rotation = 135
				exl2.Parent = exTemplate2
				module.addBillboard(exTemplate, obj)
				delay(0, function()
					repeat wait() until not obj:IsDescendantOf(game.Workspace)
					module.removeBillboard(exTemplate)
					exTemplate:Destroy()
				end)
				return {
					obj = exTemplate,
					cols = {exl, exl2}
				}
			end
		end
		for i, v in pairs({
			{
				Size = UDim2.new(0, 10, 1, 0),
			},
			{
				Position = UDim2.new(1, -10, 0, 0),
				Size = UDim2.new(0, 10, 1, 0),
			},
			{
				Position = UDim2.new(0, 10, 1, -10),
				Size = UDim2.new(1, -20, 0, 10),
			},
			{
				Position = UDim2.new(0, 10, 0, 0),
				Size = UDim2.new(1, -20, 0, 10),
			}
		}) do
			local fr = siding:clone()
			for i2, v2 in pairs(v) do
				fr[i2] = v2
			end
			fr.Parent = sGui
		end
		sGui.Parent = espTemplate
		local sGui2 = sGui:clone()
		sGui2.Face = Enum.NormalId.Back
		sGui2.Parent = espTemplate
	end
	-- Parent Esp Part into Folder in CoreGui
	local coreGuiFolder
	local an = 0
	local runESP = function()
		an = an + 1
		local curn = an + 0
		local doit = function()
			return an == curn
		end
		if coreGuiFolder then coreGuiFolder:Destroy() end
		coreGuiFolder = Instance.new("Folder", (testing and (game.Players.LocalPlayer and game.Players.LocalPlayer:WaitForChild("PlayerGui") or game.StarterGui) or game:GetService("CoreGui")))
		local cfs = {}
		module.espUpdCols = {}
		local friendly = Color3.new(0, 1, 170 / 255)
		local enemy = Color3.new(1, 140 / 255, 140 / 255)
		module.cols = {}
		local fhide = {}
		module.addESP = function(plr)
			if not doit() then return false end
			if plr ~= game.Players.LocalPlayer then
				local esp = espTemplate:clone()
				esp.Name = plr.Name
				local pn = plr.Name
				local espLabels = {}
				for i, v in pairs(esp:GetDescendants()) do
					if v:IsA("Frame") then
						table.insert(espLabels, v)
					elseif v:IsA("SurfaceGui") then
						uiItem(v)
					end
				end
				local nl = #espLabels
				local lcol = false
				local changeColor = function(col)
					if not doit() then return false end
					if typeof(col) == "number" then
						for i = 1, nl do
							espLabels[i].BackgroundTransparency = col
						end
					else
						local teamBased = module.config.espTeamBased
						if teamBased then
						else
							col = (plr.TeamColor == game.Players.LocalPlayer.TeamColor and friendly or enemy)
						end
						lcol = col
						for i = 1, nl do
							espLabels[i].BackgroundColor3 = col
						end
						esp.Color = col
						module.cols[pn] = col
					end
				end
				module.espUpdCols[plr.Name] = function(...)
					changeColor(..., plr.TeamColor.Color)
				end
				local espLabels2 = {}
				for i, v in pairs(esp:GetChildren()) do
					espLabels2[i] = {}
					for i2, v2 in pairs(v:GetChildren()) do
						table.insert(espLabels2[i], v2)
					end
				end
				local szs = function(s)
					return {
						{
							Size = UDim2.new(0, (s or 10), 1, 0),
						},
						{
							Position = UDim2.new(1, -(s or 10), 0, 0),
							Size = UDim2.new(0, (s or 10), 1, 0),
						},
						{
							Position = UDim2.new(0, (s or 10), 1, -(s or 10)),
							Size = UDim2.new(1, -2 * (s or 10), 0, (s or 10)),
						},
						{
							Position = UDim2.new(0, (s or 10), 0, 0),
							Size = UDim2.new(1, -2 * (s or 10), 0, (s or 10)),
						}
					}
				end
				local min = 20
				local base = 10
				local max = 2000 * 2
				local final = 50 * 4 * 4 * 2
				module.lerp = function(a, b, t)
				    return a * (1-t) + (b*t)
				end
				--[[
					scale = {
						{20, 10},
						{2000, 50},
						{interval, value},
					}
				--]]
				module.lerpMinMax = function(scale, t)
					local p = math.max(0, math.min(1, (t - scale[1][1]) / scale[2][1]))
					return module.lerp(scale[1][2], scale[2][2], p)
				end
				local lerp = module.lerp
				local getS = function(d)
					local prog = math.max(0, math.min(1, (d - min) / max))
					return lerp(base, final, prog)
				end
				local fixDist = function(d, o)
					local s = getS(d)
					if o then
						s = o
					end
					local szss = szs(s)
					for i, v in pairs(espLabels2) do
						for i2, v2 in pairs(v) do
							for i3, v3 in pairs(szss[i2]) do
								v2[i3] = v3
							end
						end
					end
				end
				fixDist(100, 10)
				local charAdded = function(char)
					if not doit() then return false end
					fhide[esp] = false
					delay(0, function()
						repeat wait() until char:FindFirstChildWhichIsA("Humanoid")
						local hum = char:FindFirstChildWhichIsA("Humanoid")
						local root = char:WaitForChild("HumanoidRootPart")
						hum.Died:connect(function()
							module.ignoreTargets[root] = true
							delay(10, function()
								module.ignoreTargets[root] = nil
							end)
							fhide[esp] = true
							local thing = module.createX(root)
							for i, v in pairs(thing.cols) do
								v.BackgroundColor3 = lcol
							end
						end)
					end)
					--[[do
						local root = char:WaitForChild("HumanoidRootPart")
						local thing = module.createX(root)
							for i, v in pairs(thing.cols) do
								v.BackgroundColor3 = lcol
							end
					end]]
					cfs[plr.Name] = {
						esp,
						char:WaitForChild("HumanoidRootPart"),
						plr,
						(char:FindFirstChild("Torso") or char:WaitForChild("HumanoidRootPart")),
						pn,
						fixDist,
					}
				end
				if plr.Character then
					charAdded(plr.Character)
				end
				changeColor(plr.TeamColor.Color)
				plr:GetPropertyChangedSignal("TeamColor"):connect(function()
					changeColor(plr.TeamColor.Color)
				end)
				plr.CharacterAdded:connect(charAdded)
				esp.Parent = coreGuiFolder
			end
		end
		if game.PlaceId == 863266079 then
			local addThing = function(obj)
				local esp = espTemplate:clone()
				local pn = obj --plr.Name
				local espLabels = {}
				for i, v in pairs(esp:GetDescendants()) do
					if v:IsA("Frame") then
						table.insert(espLabels, v)
					elseif v:IsA("SurfaceGui") then
						uiItem(v)
					end
				end
				local nl = #espLabels
				local lcol = false
				local changeColor = function(col)
					if not doit() then return false end
					if typeof(col) == "number" then
						for i = 1, nl do
							espLabels[i].BackgroundTransparency = col
						end
					else
						local teamBased = module.config.espTeamBased
						if teamBased then
						else
							col = enemy
						end
						lcol = col
						for i = 1, nl do
							espLabels[i].BackgroundColor3 = col
						end
						esp.Color = col
						module.cols[pn] = col
					end
				end
				module.espUpdCols[obj] = function(...)
					changeColor(..., Color3.new(1, 0, 0))
				end
				local espLabels2 = {}
				for i, v in pairs(esp:GetChildren()) do
					espLabels2[i] = {}
					for i2, v2 in pairs(v:GetChildren()) do
						table.insert(espLabels2[i], v2)
					end
				end
				local szs = function(s)
					return {
						{
							Size = UDim2.new(0, (s or 10), 1, 0),
						},
						{
							Position = UDim2.new(1, -(s or 10), 0, 0),
							Size = UDim2.new(0, (s or 10), 1, 0),
						},
						{
							Position = UDim2.new(0, (s or 10), 1, -(s or 10)),
							Size = UDim2.new(1, -2 * (s or 10), 0, (s or 10)),
						},
						{
							Position = UDim2.new(0, (s or 10), 0, 0),
							Size = UDim2.new(1, -2 * (s or 10), 0, (s or 10)),
						}
					}
				end
				local min = 20
				local base = 10
				local max = 2000 * 2
				local final = 50 * 4 * 4 * 2
				module.lerp = function(a, b, t)
				    return a * (1-t) + (b*t)
				end
				--[[
					scale = {
						{20, 10},
						{2000, 50},
						{interval, value},
					}
				--]]
				module.lerpMinMax = function(scale, t)
					local p = math.max(0, math.min(1, (t - scale[1][1]) / scale[2][1]))
					return module.lerp(scale[1][2], scale[2][2], p)
				end
				local lerp = module.lerp
				local getS = function(d)
					local prog = math.max(0, math.min(1, (d - min) / max))
					return lerp(base, final, prog)
				end
				local fixDist = function(d, o)
					local s = getS(d)
					if o then
						s = o
					end
					local szss = szs(s)
					for i, v in pairs(espLabels2) do
						for i2, v2 in pairs(v) do
							for i3, v3 in pairs(szss[i2]) do
								v2[i3] = v3
							end
						end
					end
				end
				if obj:WaitForChild("Humanoid").Health >= 0 then
				obj:WaitForChild("Humanoid").Died:connect(function()
					esp:Destroy()
					cfs[obj] = nil
				end)
				fixDist(100, 10)
				cfs[obj] = {
					esp,
					obj:WaitForChild("HumanoidRootPart"),
					{
						TeamColor = BrickColor.new("Bright red"),
						Name = obj,
						
					},
					(obj:FindFirstChild("Toros") or obj:WaitForChild("HumanoidRootPart")),
					pn,
					fixDist,
					(obj:FindFirstChild("UpperTorso") or obj:FindFirstChild("Torso")),
				}
				esp.Parent = coreGuiFolder
				end
			end
			spawn(function()
			local fold = game.Workspace:WaitForChild("Zombies"):WaitForChild("Mobs")
			fold.ChildAdded:connect(function(obj)
				addThing(obj)
			end)
			fold.ChildRemoved:connect(function(obj)
				ypcall(function() cfs[obj][1]:Destroy()
				cfs[obj] = nil end)
			end)
			for i, v in pairs(fold:GetChildren()) do
				spawn(function() addThing(v) end)
			end
			end)
		end
		if not testing or game.Players.LocalPlayer then
			local offset = CFrame.new(0, -0.5, 0)
			local infin = CFrame.new(999999, 999999, 999999)
			local ltr = {}
			game:GetService("RunService"):BindToRenderStep("idk_" .. curn, Enum.RenderPriority.Last.Value, function()
				if not doit() then game:GetService("RunService"):UnbindFromRenderStep("idk_" .. curn) else
				local ovr = false
				local rootcf = game.Workspace.CurrentCamera.CoordinateFrame
				local rootcf2 = game.Workspace.CurrentCamera.Focus.p
				local lpt = game.Players.LocalPlayer.TeamColor
				if not module.config.esp then
					ovr = infin
				end
				local targs = {}
				local d = 999999
				local clos = false
				local chars = {
					game.Players.LocalPlayer --UNCOMMENT WHEN FINISHED TESTING
				}
				for i, v in pairs(cfs) do
					if module.config.targetInvisible or (not v[7] or (v[7] and v[7].Transparency < 1)) then
						table.insert(chars, v[2].Parent)
					else
						
					end
				end
				if game.PlaceId == 863266079 then
					for i, v in pairs(game.Workspace:WaitForChild("Zombies"):WaitForChild("Mobs"):GetChildren()) do
						
					end
				end
				module.chars = chars
				for i, v in pairs(cfs) do
					local a = v[1]
					local b = v[2]
					local blocked = module.isBlocked(b)
					if not (module.config.targetInvisible or (not v[7] or (v[7] and v[7].Transparency < 1))) then
						module.espUpdCols[i](1)
					else
					
					local ot = 1
					--warn(ot or 0.5)
					if a and b and not fhide[a] and (module.config.espBlockMode >= 2 or not blocked) then
						if module.config.espBlockMode == 2 and blocked then
							local n = (module.config.espTransparency / 100) or 0.75
							if module.ui._instance.Enabled then ot = n end
							module.espUpdCols[i](ot)
							ltr[i] = ot
						elseif ltr[i] ~= 0 then
							if module.ui._instance.Enabled then ot = 0 end
							ltr[i] = ot
							module.espUpdCols[i](ot)
						end
						a.CFrame = (ovr or b.CFrame * offset)
					else
						a.CFrame = infin
					end
					--[[if not module.ui._instance.Enabled then
						module.espUpdCols[i](1)
					else
						module.espUpdCols[i](0)
					end]]
					local t = v[3].TeamColor
					if module.config.aimbotTargetEveryone == true or t ~= lpt then
						table.insert(targs, v)
						local d2 = (a.CFrame.p - rootcf2).magnitude
						if d2 < d and module.getPos(b) then
							d = d2
							clos = v
						end
					end
					local dist = (a.CFrame.p - rootcf.p).magnitude
					v[6](dist)
					
					end
				end
				module.targets = targs
				if clos then
					module.closest = {
						dist = d,
						plr = clos,
					}
				end
				end
			end)
			game.Players.LocalPlayer:GetPropertyChangedSignal("TeamColor"):connect(function()
				if doit() then
					for i, v in pairs(module.espUpdCols) do
						v()
					end
				end
			end)
		end
		game.Players.PlayerAdded:connect(module.addESP)
		game.Players.PlayerRemoving:connect(function(plr)
			local pn = plr.Name
			cfs[pn] = nil
			module.espUpdCols[pn] = nil
			if coreGuiFolder:FindFirstChild(pn) then
				coreGuiFolder:FindFirstChild(pn):Destroy()
			end
		end)
		for i, v in pairs(game.Players:GetPlayers()) do
			spawn(function() module.addESP(v) end)
		end
	end
	module.runESP = runESP
	runESP()
end

do
	-- PVEYE DETECTION
	local plabel = Instance.new("TextLabel")
	do
		plabel.BackgroundTransparency = 1
		plabel.Position = UDim2.new(0.6, 0, 0.15 + (1.5 * 0.015), 0)
		plabel.Size = UDim2.new(0.15, 0, 0.015, 0)
		plabel.TextColor3 = Color3.new(1, 0, 0)
		plabel.TextScaled = true
		plabel.TextWrapped = true
		plabel.Text = ""
		plabel.TextTransparency = 0.5
		plabel.Parent = module.ui._instance
	end
	spawn(function()
		detectPVEye()
		while wait(2) do
			detectPVEye()
		end
	end)
end

do
	ui.create("title", {
		text = "[ Aim Bot ]",
	}).parent(ui)
	ui.create("tab", function(tab)
		tab.add(ui.create("toggle", {
			value = module.config.aimbot,
			text = "Aim Bot",
		}, function(btn)
			btn.changed:connect(function(value)
				module.config.aimbot = value
			end)
		end))
		tab.add(ui.create("toggle", {
			value = module.config.aimbotTargetEveryone,
			text = "Targeting",
			values = {"Everyone", "Enemies"},
		}, function(btn)
			btn.changed:connect(function(value)
				module.config.aimbotTargetEveryone = value
			end)
		end))
		tab.add(ui.create("toggle", {
			value = module.config.aimbotTargetNearby,
			text = "CQC",
		}, function(btn)
			btn.changed:connect(function(value)
				module.config.aimbotTargetNearby = value
			end)
		end))
		tab.add(ui.create("toggle", {
			value = module.config.aimbotThroughWalls,
			text = "Through Walls",
		}, function(btn)
			btn.changed:connect(function(value)
				module.config.aimbotThroughWalls = value
			end)
		end))
		tab.add(ui.create("toggle", {
			value = module.config.aimbotDampening,
			text = "Realism",
		}, function(btn)
			btn.changed:connect(function(value)
				module.config.aimbotDampening = value
			end)
		end))
		tab.add(ui.create("slider", {
			min = 0,
			max = 100,
			value = module.config.aimbotDampeningValue,
		}, function(slider)
			slider.changed:connect(function(value)
				module.config.aimbotDampeningValue = value
			end)
		end))
		tab.add(ui.create("cycle", {
			value = module.config.aimbotMethod, --true,
			text = "Method",
			values = {{"Original", color.yellow}, {"New", color.green}}
		}, function(btn)
			btn.changed:connect(function(value)
				module.config.aimbotMethod = value
			end)
		end))
		tab.add(ui.create("toggle", {
			value = module.config.aimbotCamera,
			text = "Camera",
		}, function(btn)
			btn.changed:connect(function(value)
				module.config.aimbotCamera = value
			end)
		end))
		
		tab.add(ui.create("label2", {
			text = {"Keybind", aimbotKey.Name},
		}))
	end).parent(ui)
	ui.create("title", {
		text = "[ ESP ]",
	}).parent(ui)
	ui.create("tab", function(tab)
		tab.add(ui.create("toggle", {
			value = module.config.esp, --false,
			text = "ESP",
		}, function(btn)
			btn.changed:connect(function(value)
				module.config.esp = value
			end)
		end))
		tab.add(ui.create("toggle", {
			value = module.config.espTeamBased, --true,
			text = "Team Color",
		}, function(btn)
			btn.changed:connect(function(value)
				module.config.espTeamBased = value
				for i, v in pairs(module.espUpdCols) do
					v()
				end
			end)
		end))
		tab.add(ui.create("cycle", {
			value = module.config.espBlockMode, --true,
			text = "Behind Wall",
			values = {{"Hide", color.red}, {"Opacity", color.yellow}, {"Show", color.green}}
		}, function(btn)
			btn.changed:connect(function(value)
				module.config.espBlockMode = value
			end)
		end))
		tab.add(ui.create("slider", {
			min = 0,
			max = 100,
			value = module.config.espTransparency,
		}, function(slider)
			slider.changed:connect(function(value)
				module.config.espTransparency = value
			end)
		end))
	end).parent(ui)
	ui.create("title", {
		text = "[ HBE ]",
	}).parent(ui)
	ui.create("tab", function(tab)
		tab.add(ui.create("toggle", {
			value = module.config.hbe, --false,
			text = "HBE",
		}, function(btn)
			btn.changed:connect(function(value)
				module.config.hbe = value
			end)
		end))
		tab.add(ui.create("slider", {
			min = 0,
			max = 100,
			value = module.config.hbeRadius,
		}, function(slider)
			slider.changed:connect(function(value)
				module.config.hbeRadius = value
			end)
		end))
		tab.add(ui.create("toggle", {
			value = module.config.hbeThroughWalls,
			text = "Through Walls",
		}, function(btn)
			btn.changed:connect(function(value)
				module.config.hbeThroughWalls = value
			end)
		end))
	end).parent(ui)
	ui.create("title", {
		text = "[ Other ]",
	}).parent(ui)
	ui.create("tab", function(tab)
		tab.add(ui.create("toggle", {
			value = module.config.healthbar, --true,
			text = "Healthbar",
		}, function(btn)
			btn.changed:connect(function(value)
				module.config.healthbar = value
			end)
		end))
		tab.add(ui.create("toggle", {
			value = module.config.targetInvisible, --false,
			text = "Target Invisibles",
		}, function(btn)
			btn.changed:connect(function(value)
				module.config.targetInvisible = value
			end)
		end))
	end).parent(ui)
	ui.create("title", {
		text = "[ Info ]",
	}).parent(ui)
	ui.create("tab", function(tab)
		tab.add(ui.create("label2", {
			text = {"Keybind", openKey.Name},
		}))
		tab.add(ui.create("label2", {
			text = {"Creator", "vuk"},
		}))
		tab.add(ui.create("label2", {
			text = {"Version", version},
		}))
	end).parent(ui)
	--[[for i = 1, 50 do
		ui.create("title", {
			text = "yeah boi " .. i,
		}).parent(ui)
	end]]
end

return module
