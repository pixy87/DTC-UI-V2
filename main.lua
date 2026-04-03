-- Gui to Lua
-- Version: 3.2

-- Instances:

local DigToChinaUIV2 = Instance.new("ScreenGui")
local TextLabel = Instance.new("TextLabel")

--Properties:

DigToChinaUIV2.Name = "Dig To China UI V2"
DigToChinaUIV2.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
DigToChinaUIV2.Enabled = false
DigToChinaUIV2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

TextLabel.Parent = DigToChinaUIV2
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.155315608, 0, 0.137997434, 0)
TextLabel.Size = UDim2.new(0, 50, 0, 50)
TextLabel.Visible = false
TextLabel.Font = Enum.Font.Bangers
TextLabel.Text = "Auto China"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 15.000
TextLabel.TextWrapped = true

-- Scripts:

local function RGWMQ_fake_script() -- DigToChinaUIV2.LocalScript 
	local script = Instance.new('LocalScript', DigToChinaUIV2)

	local UISettings = getgenv().UISettings or {
		AutoChina = false,
		PTB = false,
		BTP = false,
		CTP = false,
		AutoCandy = false,
		AutoPresent = false
	}
	
	local playerGui = script.Parent.Parent
	local player = game.Players.LocalPlayer
	
	game.ReplicatedStorage.Events.NotificationText.NotificationTextBindable:Fire("       Loaded Script: Dig To China UI V2       ", "grey")
	
	local topbar = playerGui.UI.Topbar
	local baseButton = topbar.AutoRebirth
	local txt = script.Parent.TextLabel
	txt.Visible = true
	
	-----------------------------------------------------
	-- ========== AUTO CHINA BUTTON ==========
	-----------------------------------------------------
	local china = baseButton:Clone()
	china.Name = "AutoChina"
	china.Parent = topbar
	china.AutoRebirthINFO.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
	china.AutoRebirthINFO.UIStroke.Color = Color3.fromRGB(0, 0, 0)
	china.AutoRebirthINFO.Title.Text = "Auto China"
	china.AutoRebirthINFO.Info.Text = "Automatically takes you to China. Features: Deletes Terrain, Stronger Gravity, Teleports player above dig site. (Y to toggle)"
	if china.Rebirths then china.Rebirths:Destroy() end
	if china.Button and china.Button.ToggleAutoRebirther then china.Button.ToggleAutoRebirther:Destroy() end
	china.Button.Icon:Destroy()
	local chinaTxt = txt:Clone()
	chinaTxt.Text = "Auto China"
	chinaTxt.Parent = china.Button
	chinaTxt.Visible = true
	
	local chinaToggle = false
	local oldgrav = workspace.Gravity
	local terrain = workspace:FindFirstChildOfClass("Terrain")
	local autoChinaLoop
	
	local function chinaColors()
		if chinaToggle then
			china.BackgroundColor3 = Color3.fromRGB(28, 106, 41)
			china.Button.BackgroundColor3 = Color3.fromRGB(83, 255, 112)
		else
			china.BackgroundColor3 = Color3.fromRGB(141, 58, 94)
			china.Button.BackgroundColor3 = Color3.fromRGB(255, 69, 140)
		end
	end
	
	local function createChinaAnchor()
		local anchor = workspace:FindFirstChild("AutoChinaAnchor")
		if anchor then return anchor end
		anchor = Instance.new("Part")
		anchor.Name = "AutoChinaAnchor"
		anchor.Anchored = true
		anchor.CanCollide = false
		anchor.Size = Vector3.new(1,1,1)
		anchor.Position = Vector3.new(66.74,183.995,104.301)
		anchor.Parent = workspace
		return anchor
	end
	
	local function teleportToChina()
		local char = player.Character or player.CharacterAdded:Wait()
		local anchor = createChinaAnchor()
		if char and char:FindFirstChild("HumanoidRootPart") then
			char:MoveTo(anchor.Position)
		end
	end
	
	local function startAutoChina()
		workspace.Gravity = 1000
		createChinaAnchor()
		autoChinaLoop = task.spawn(function()
			local count = 0
			while chinaToggle do
				task.wait(1)
				count += 1
				if terrain then terrain:Clear() end
				if count >= 10 then
					count = 0
					teleportToChina()
				end
			end
		end)
	end
	
	local function stopAutoChina()
		chinaToggle = false
		chinaColors()
		workspace.Gravity = oldgrav
		local anchor = workspace:FindFirstChild("AutoChinaAnchor")
		if anchor then anchor:Destroy() end
	end
	
	local function toggleAutoChina()
		chinaToggle = not chinaToggle
		chinaColors()
		if chinaToggle then
			startAutoChina()
			game.ReplicatedStorage.Events.NotificationText.NotificationTextBindable:Fire("       Turned on Auto China!       ", "green")
			teleportToChina()
		else
			stopAutoChina()
			game.ReplicatedStorage.Events.NotificationText.NotificationTextBindable:Fire("       Turned off Auto China!       ", "red")
		end
		if game.SoundService:FindFirstChild("SFX") and game.SoundService.SFX:FindFirstChild("Click") then
			game.SoundService.SFX.Click:Play()
		end
	end
	
	china.Button.MouseButton1Click:Connect(toggleAutoChina)
	game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
		if not processed and input.KeyCode == Enum.KeyCode.Y then
			toggleAutoChina()
		end
	end)
	china.Button.MouseEnter:Connect(function() china.AutoRebirthINFO.Visible = true end)
	china.Button.MouseLeave:Connect(function() china.AutoRebirthINFO.Visible = false end)
	chinaColors()
	if UISettings.AutoChina then
		task.spawn(toggleAutoChina)
	end
	
	-----------------------------------------------------
	-- ========== AUTO CONVERT (PTB) ==========
	-----------------------------------------------------
	local convert = baseButton:Clone()
	convert.Name = "AutoConvert"
	convert.Parent = topbar
	convert.AutoRebirthINFO.BackgroundColor3 = Color3.fromRGB(20, 23, 52)
	convert.AutoRebirthINFO.UIStroke.Color = Color3.fromRGB(2, 0, 52)
	convert.AutoRebirthINFO.Title.Text = "Auto Convert (PTB)"
	convert.AutoRebirthINFO.Info.Text = "Automatically converts all Points into Bombs. (P to toggle)"
	if convert.Rebirths then convert.Rebirths:Destroy() end
	if convert.Button and convert.Button.ToggleAutoRebirther then convert.Button.ToggleAutoRebirther:Destroy() end
	convert.Button.Icon:Destroy()
	local convertTxt = txt:Clone()
	convertTxt.Text = "Auto Convert (PTB)"
	convertTxt.Parent = convert.Button
	convertTxt.Visible = true
	
	local convertToggle = false
	local convertLoop
	
	local function convertColors()
		if convertToggle then
			convert.BackgroundColor3 = Color3.fromRGB(28, 106, 41)
			convert.Button.BackgroundColor3 = Color3.fromRGB(83, 255, 112)
		else
			convert.BackgroundColor3 = Color3.fromRGB(141, 58, 94)
			convert.Button.BackgroundColor3 = Color3.fromRGB(255, 69, 140)
		end
	end
	
	local function startAutoConvert()
		convertLoop = task.spawn(function()
			while convertToggle do
				task.wait(0.000000000001)
				local points = player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Points")
				if points then
					local amount = points.Value
					if amount > 0 then
						local args = {"PTB", tostring(amount)}
						game:GetService("ReplicatedStorage").Events.UseBankConversion:FireServer(unpack(args))
					end
				end
			end
		end)
	end
	
	local function stopAutoConvert()
		convertToggle = false
		convertColors()
	end
	
	local function toggleAutoConvert()
		convertToggle = not convertToggle
		convertColors()
		if convertToggle then
			startAutoConvert()
			game.ReplicatedStorage.Events.NotificationText.NotificationTextBindable:Fire("       Turned on Auto Convert (PTB)!       ", "green")
		else
			stopAutoConvert()
			game.ReplicatedStorage.Events.NotificationText.NotificationTextBindable:Fire("       Turned off Auto Convert (PTB)!       ", "red")
		end
		if game.SoundService:FindFirstChild("SFX") and game.SoundService.SFX:FindFirstChild("Click") then
			game.SoundService.SFX.Click:Play()
		end
	end
	
	convert.Button.MouseButton1Click:Connect(toggleAutoConvert)
	game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
		if not processed and input.KeyCode == Enum.KeyCode.P then
			toggleAutoConvert()
		end
	end)
	convert.Button.MouseEnter:Connect(function() convert.AutoRebirthINFO.Visible = true end)
	convert.Button.MouseLeave:Connect(function() convert.AutoRebirthINFO.Visible = false end)
	convertColors()
	if UISettings.PTB then
		task.spawn(toggleAutoConvert)
	end
	
	-----------------------------------------------------
	-- ========== AUTO CONVERT (BTP) ==========
	-----------------------------------------------------
	local bombs = baseButton:Clone()
	bombs.Name = "AutoBombs"
	bombs.Parent = topbar
	bombs.AutoRebirthINFO.BackgroundColor3 = Color3.fromRGB(216, 42, 42)
	bombs.AutoRebirthINFO.UIStroke.Color = Color3.fromRGB(141, 36, 36)
	bombs.AutoRebirthINFO.Title.Text = "Auto Convert (BTP)"
	bombs.AutoRebirthINFO.Info.Text = "Automatically converts all Bombs into Points. (U to toggle)"
	if bombs.Rebirths then bombs.Rebirths:Destroy() end
	if bombs.Button and bombs.Button.ToggleAutoRebirther then bombs.Button.ToggleAutoRebirther:Destroy() end
	bombs.Button.Icon:Destroy()
	local bombsTxt = txt:Clone()
	bombsTxt.Text = "Auto Convert (BTP)"
	bombsTxt.Parent = bombs.Button
	bombsTxt.Visible = true
	
	local bombsToggle = false
	local bombsLoop
	
	local function bombsColors()
		if bombsToggle then
			bombs.BackgroundColor3 = Color3.fromRGB(28, 106, 41)
			bombs.Button.BackgroundColor3 = Color3.fromRGB(83, 255, 112)
		else
			bombs.BackgroundColor3 = Color3.fromRGB(141, 58, 94)
			bombs.Button.BackgroundColor3 = Color3.fromRGB(255, 69, 140)
		end
	end
	
	local function startAutoBombs()
		bombsLoop = task.spawn(function()
			while bombsToggle do
				task.wait(0.000000000001)
				local bombStat = player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Bombs")
				if bombStat then
					local amount = bombStat.Value
					if amount > 0 then
						local args = {"BTP", tostring(amount)}
						game:GetService("ReplicatedStorage").Events.UseBankConversion:FireServer(unpack(args))
					end
				end
			end
		end)
	end
	
	local function stopAutoBombs()
		bombsToggle = false
		bombsColors()
	end
	
	local function toggleAutoBombs()
		bombsToggle = not bombsToggle
		bombsColors()
		if bombsToggle then
			startAutoBombs()
			game.ReplicatedStorage.Events.NotificationText.NotificationTextBindable:Fire("       Turned on Auto Convert (BTP)!       ", "green")
		else
			stopAutoBombs()
			game.ReplicatedStorage.Events.NotificationText.NotificationTextBindable:Fire("       Turned off Auto Convert (BTP)!       ", "red")
		end
		if game.SoundService:FindFirstChild("SFX") and game.SoundService.SFX:FindFirstChild("Click") then
			game.SoundService.SFX.Click:Play()
		end
	end
	
	bombs.Button.MouseButton1Click:Connect(toggleAutoBombs)
	game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
		if not processed and input.KeyCode == Enum.KeyCode.U then
			toggleAutoBombs()
		end
	end)
	bombs.Button.MouseEnter:Connect(function() bombs.AutoRebirthINFO.Visible = true end)
	bombs.Button.MouseLeave:Connect(function() bombs.AutoRebirthINFO.Visible = false end)
	bombsColors()
	if UISettings.BTP then
		task.spawn(toggleAutoBombs)
	end
	
	-----------------------------------------------------
	-- ========== AUTO PRESENT (CHRISTMAS) ==========
	-----------------------------------------------------
	local present = baseButton:Clone()
	present.Name = "AutoPresent"
	present.Parent = topbar
	present.AutoRebirthINFO.BackgroundColor3 = Color3.fromRGB(0, 2, 94)
	present.AutoRebirthINFO.UIStroke.Color = Color3.fromRGB(0, 145, 255)
	present.AutoRebirthINFO.Title.Text = "Auto Present"
	present.AutoRebirthINFO.Info.Text = "Automatically delivers presents & fills gift bags."
	if present.Rebirths then present.Rebirths:Destroy() end
	if present.Button and present.Button.ToggleAutoRebirther then present.Button.ToggleAutoRebirther:Destroy() end
	present.Button.Icon:Destroy()
	
	local presentTxt = txt:Clone()
	presentTxt.Text = "Auto Present"
	presentTxt.Parent = present.Button
	presentTxt.Visible = true
	
	local presentToggle = false
	local presentLoop
	
	local function presentColors()
		if presentToggle then
			present.BackgroundColor3 = Color3.fromRGB(28, 106, 41)
			present.Button.BackgroundColor3 = Color3.fromRGB(83, 255, 112)
		else
			present.BackgroundColor3 = Color3.fromRGB(141, 58, 94)
			present.Button.BackgroundColor3 = Color3.fromRGB(255, 69, 140)
		end
	end
	
	local function startAutoPresent()
		presentLoop = task.spawn(function()
			while presentToggle do
				task.wait(0.000000000001)
	
				local player = game.Players.LocalPlayer
				local char = player.Character or player.CharacterAdded:Wait()
				local tool = char:FindFirstChildWhichIsA("Tool")
				local bag = workspace.ChristmasEvent.Decorations.GiftsCrash.Bag
				player.Character:MoveTo(bag.Position + Vector3.new(0,0,-5))
				if tool then
					local bag = tool:FindFirstChild("BagHandling")
					local drop = bag and bag:FindFirstChild("DropPresent")
					local giftsFolder = tool:FindFirstChild("Gifts")
					local gifts = giftsFolder and giftsFolder:GetChildren()
	
					local housesFolder = workspace:FindFirstChild("Houses")
					local nh = housesFolder and housesFolder:FindFirstChild("NeighborhoodHouses")
					local houses = nh and nh:GetChildren()
	
					if drop and gifts and #gifts > 0 and houses and #houses > 0 then
						local gift = gifts[math.random(1,#gifts)]
						local house = houses[math.random(1,#houses)]
						drop:FireServer(gift, house)
					end
				end
	
				pcall(function()
					local prompt = bag.Take
					if prompt then
						prompt.HoldDuration = 0
						fireproximityprompt(prompt)
					end
				end)
			end
		end)
	end
	
	local function stopAutoPresent()
		presentToggle = false
		presentColors()
	end
	
	local function toggleAutoPresent()
		presentToggle = not presentToggle
		presentColors()
	
		if presentToggle then
			startAutoPresent()
			game.ReplicatedStorage.Events.NotificationText.NotificationTextBindable:Fire("       Turned on Auto Present!       ", "green")
		else
			stopAutoPresent()
			game.ReplicatedStorage.Events.NotificationText.NotificationTextBindable:Fire("       Turned off Auto Present!       ", "red")
		end
	
		if game.SoundService:FindFirstChild("SFX") and game.SoundService.SFX:FindFirstChild("Click") then
			game.SoundService.SFX.Click:Play()
		end
	end
	
	present.Button.MouseButton1Click:Connect(toggleAutoPresent)
	game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
		if not processed and input.KeyCode == Enum.KeyCode.H then
			toggleAutoPresent()
		end
	end)
	
	present.Button.MouseEnter:Connect(function()
		present.AutoRebirthINFO.Visible = true
	end)
	
	present.Button.MouseLeave:Connect(function()
		present.AutoRebirthINFO.Visible = false
	end)
	
	presentColors()
	
	if UISettings.AutoPresent then
		task.spawn(toggleAutoPresent)
	end
	
	-----------------------------------------------------
	-- ========== AUTO CONVERT (CTP) ==========
	-----------------------------------------------------
	local candy = baseButton:Clone()
	candy.Name = "AutoCandy"
	candy.Parent = topbar
	candy.AutoRebirthINFO.BackgroundColor3 = Color3.fromRGB(94, 66, 0)
	candy.AutoRebirthINFO.UIStroke.Color = Color3.fromRGB(255, 149, 0)
	candy.AutoRebirthINFO.Title.Text = "Auto Convert (CTP)"
	candy.AutoRebirthINFO.Info.Text = "Automatically converts all Candy into Points. (C to toggle)"
	if candy.Rebirths then candy.Rebirths:Destroy() end
	if candy.Button and candy.Button.ToggleAutoRebirther then candy.Button.ToggleAutoRebirther:Destroy() end
	candy.Button.Icon:Destroy()
	local candytxt = txt:Clone()
	candytxt.Text = "Auto Convert (CTP)"
	candytxt.Parent = candy.Button
	candytxt.Visible = true
	
	local candytoggle = false
	local candyloop
	
	local function candycolors()
		if candytoggle then
			candy.BackgroundColor3 = Color3.fromRGB(28, 106, 41)
			candy.Button.BackgroundColor3 = Color3.fromRGB(83, 255, 112)
		else
			candy.BackgroundColor3 = Color3.fromRGB(141, 58, 94)
			candy.Button.BackgroundColor3 = Color3.fromRGB(255, 69, 140)
		end
	end
	
	local function startAutocandy()
		candyloop = task.spawn(function()
			while candytoggle do
				task.wait(0.000000000001)
				local candyStat = player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Candy")
				if candyStat then
					local amount = candyStat.Value
					if amount > 0 then
						local args = {"HALLOWEEN", tostring(amount)}
						game:GetService("ReplicatedStorage").Events.UseBankConversion:FireServer(unpack(args))
					end
				end
			end
		end)
	end
	
	local function stopAutocandy()
		candytoggle = false
		candycolors()
	end
	
	local function toggleAutocandy()
		candytoggle = not candytoggle
		candycolors()
		if candytoggle then
			startAutocandy()
			game.ReplicatedStorage.Events.NotificationText.NotificationTextBindable:Fire("       Turned on Auto Convert (CTP)!       ", "green")
		else
			stopAutocandy()
			game.ReplicatedStorage.Events.NotificationText.NotificationTextBindable:Fire("       Turned off Auto Convert (CTP)!       ", "red")
		end
		if game.SoundService:FindFirstChild("SFX") and game.SoundService.SFX:FindFirstChild("Click") then
			game.SoundService.SFX.Click:Play()
		end
	end
	
	candy.Button.MouseButton1Click:Connect(toggleAutocandy)
	game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
		if not processed and input.KeyCode == Enum.KeyCode.C then
			toggleAutocandy()
		end
	end)
	candy.Button.MouseEnter:Connect(function() candy.AutoRebirthINFO.Visible = true end)
	candy.Button.MouseLeave:Connect(function() candy.AutoRebirthINFO.Visible = false end)
	candycolors()
	if UISettings.CTP then
		task.spawn(toggleAutocandy)
	end
	
	-----------------------------------------------------
	-- ========== AUTO CANDY (HALLOWEEN) ==========
	-----------------------------------------------------
	local candy2 = baseButton:Clone()
	candy2.Name = "AutoCandy2"
	candy2.Parent = topbar
	candy2.AutoRebirthINFO.BackgroundColor3 = Color3.fromRGB(94, 66, 0)
	candy2.AutoRebirthINFO.UIStroke.Color = Color3.fromRGB(255, 149, 0)
	candy2.AutoRebirthINFO.Title.Text = "Auto Candy"
	candy2.AutoRebirthINFO.Info.Text = "Automatically teleports to LargeHouse and spam collects candy. (H to toggle)"
	if candy2.Rebirths then candy2.Rebirths:Destroy() end
	if candy2.Button and candy2.Button.ToggleAutoRebirther then candy2.Button.ToggleAutoRebirther:Destroy() end
	candy2.Button.Icon:Destroy()
	local candy2Txt = txt:Clone()
	candy2Txt.Text = "Auto Candy"
	candy2Txt.Parent = candy2.Button
	candy2Txt.Visible = true
	
	local candy2Toggle = false
	
	local function candy2Colors()
		if candy2Toggle then
			candy2.BackgroundColor3 = Color3.fromRGB(28, 106, 41)
			candy2.Button.BackgroundColor3 = Color3.fromRGB(83, 255, 112)
		else
			candy2.BackgroundColor3 = Color3.fromRGB(141, 58, 94)
			candy2.Button.BackgroundColor3 = Color3.fromRGB(255, 69, 140)
		end
	end
	
	local function startAutoCandy2()
		task.spawn(function()
			local HOUSES_FOLDER_PATH = workspace:WaitForChild("Halloween"):WaitForChild("Houses")
			local house = HOUSES_FOLDER_PATH:WaitForChild("LargeHouse")
			local door = house:FindFirstChild("Door", true)
	
			local function handlePrompt(prompt)
				if not prompt:IsA("ProximityPrompt") then return end
				prompt.HoldDuration = 0
				prompt.MaxActivationDistance = math.huge
				task.spawn(function()
					while candy2Toggle and prompt.Parent and prompt:IsDescendantOf(HOUSES_FOLDER_PATH) do
						task.wait(0.000000000001)
						player.Character:MoveTo(door.Position + Vector3.new(0,0,-5))
						pcall(function()
							fireproximityprompt(prompt)
						end)
					end
				end)
			end
	
			local function scanFolder(folder)
				for _, obj in ipairs(folder:GetDescendants()) do
					if obj:IsA("ProximityPrompt") then
						handlePrompt(obj)
					end
				end
			end
	
			scanFolder(HOUSES_FOLDER_PATH)
	
			HOUSES_FOLDER_PATH.DescendantAdded:Connect(function(desc)
				if candy2Toggle and desc:IsA("ProximityPrompt") then
					handlePrompt(desc)
				end
			end)
		end)
	end
	
	local function stopAutoCandy2()
		candy2Toggle = false
		candy2Colors()
	end
	
	local function toggleAutoCandy2()
		candy2Toggle = not candy2Toggle
		candy2Colors()
		if candy2Toggle then
			startAutoCandy2()
			game.ReplicatedStorage.Events.NotificationText.NotificationTextBindable:Fire("       Turned on Auto Candy!       ", "green")
		else
			stopAutoCandy2()
			game.ReplicatedStorage.Events.NotificationText.NotificationTextBindable:Fire("       Turned off Auto Candy!       ", "red")
		end
		if game.SoundService:FindFirstChild("SFX") and game.SoundService.SFX:FindFirstChild("Click") then
			game.SoundService.SFX.Click:Play()
		end
	end
	
	candy2.Button.MouseButton1Click:Connect(toggleAutoCandy2)
	game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
		if not processed and input.KeyCode == Enum.KeyCode.H then
			toggleAutoCandy2()
		end
	end)
	candy2.Button.MouseEnter:Connect(function() candy2.AutoRebirthINFO.Visible = true end)
	candy2.Button.MouseLeave:Connect(function() candy2.AutoRebirthINFO.Visible = false end)
	candy2Colors()
	if UISettings.AutoCandy then
		task.spawn(toggleAutoCandy2)
	end
	
	-----------------------------------------------------
	-- ========== BUTTONS TOGGLE ==========
	-----------------------------------------------------
	local btn = baseButton:Clone()
	btn.Name = "ButtonToggle"
	btn.Parent = topbar
	btn.AutoRebirthINFO.BackgroundColor3 = Color3.fromRGB(0, 2, 94)
	btn.AutoRebirthINFO.UIStroke.Color = Color3.fromRGB(0, 145, 255)
	btn.AutoRebirthINFO.Title.Text = "Buttons Toggle"
	btn.AutoRebirthINFO.Info.Text = "Switches between Christmas and Normal buttons."
	if btn.Rebirths then btn.Rebirths:Destroy() end
	if btn.Button and btn.Button.ToggleAutoRebirther then btn.Button.ToggleAutoRebirther:Destroy() end
	btn.Button.Icon:Destroy()
	local btntxt = txt:Clone()
	btntxt.Text = "Christmas"
	btntxt.TextSize = 13
	btntxt.Visible = true
	btntxt.Parent = btn.Button
	
	local btnToggle = false
	
	local function btncolors()
		if btnToggle then
			btn.BackgroundColor3 = Color3.fromRGB(106, 106, 106)
			btn.Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		else
			btn.BackgroundColor3 = Color3.fromRGB(0, 2, 94)
			btn.Button.BackgroundColor3 = Color3.fromRGB(0, 145, 255)
		end
	end
	
	local function togglebuttons()
		btnToggle = not btnToggle
		btncolors()
		if btnToggle then
			candy.Visible = false
			candy2.Visible = false
			china.Visible = false
			convert.Visible = false
			bombs.Visible = false
			present.Visible = true
			btntxt.TextSize = 15
			btntxt.Text = "Normal"
			btn.AutoRebirthINFO.BackgroundColor3 = Color3.fromRGB(106, 106, 106)
			btn.AutoRebirthINFO.UIStroke.Color = Color3.fromRGB(255, 255, 255)
			game.ReplicatedStorage.Events.NotificationText.NotificationTextBindable:Fire("       Switched to Christmas Buttons       ", "grey")
		else
			candy.Visible = false
			candy2.Visible = false
			china.Visible = true
			convert.Visible = true
			bombs.Visible = true
			present.Visible = false
			btntxt.TextSize = 13
			btntxt.Text = "Christmas"
			btn.AutoRebirthINFO.BackgroundColor3 = Color3.fromRGB(0, 2, 94)
			btn.AutoRebirthINFO.UIStroke.Color = Color3.fromRGB(0, 145, 255)
			game.ReplicatedStorage.Events.NotificationText.NotificationTextBindable:Fire("       Switched to Normal Buttons       ", "grey")
		end
		if game.SoundService:FindFirstChild("SFX") and game.SoundService.SFX:FindFirstChild("Click") then
			game.SoundService.SFX.Click:Play()
		end
	end
	
	btn.Button.MouseButton1Click:Connect(togglebuttons)
	btn.Button.MouseEnter:Connect(function() btn.AutoRebirthINFO.Visible = true end)
	btn.Button.MouseLeave:Connect(function() btn.AutoRebirthINFO.Visible = false end)
	btncolors()
	
	btn.Visible = false
	candy.Visible = false
	candy2.Visible = false
	china.Visible = true
	convert.Visible = true
	bombs.Visible = true
	present.Visible = false
	
	task.wait(3)
	game.ReplicatedStorage.Events.NotificationText.NotificationTextBindable:Fire("       Join our discord: discord.gg/EACbG6SHXX       ", "grey")
end
coroutine.wrap(RGWMQ_fake_script)()
