local Players = game:GetService("Players") 
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui") 
gui.ResetOnSpawn = false 
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame") 
frame.Size = UDim2.new(0, 240, 0, 640) 
frame.Position = UDim2.new(0, 20, 0, 20) 
frame.BackgroundColor3 = Color3.fromRGB(19, 134, 61) 
frame.BorderSizePixel = 0 
frame.Parent = gui

-- dragging (unchanged) 
local dragging = false 
local dragStart 
local startPos 
local dragInput

frame.InputBegan:Connect(function(input) 
	if input.UserInputType == Enum.UserInputType.MouseButton1 
	or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true 
		dragStart = input.Position 
		startPos = frame.Position

		input.Changed:Connect(function() 
			if input.UserInputState == Enum.UserInputState.End then 
				dragging = false 
				end 
			end) 
		end 
	end)

frame.InputChanged:Connect(function(input) 
	if input.UserInputType == Enum.UserInputType.MouseMovement 
	or input.UserInputType == Enum.UserInputType.Touch then 
		dragInput = input 
		end 
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if dragging and input == dragInput then 
		local delta = input.Position - dragStart 
		frame.Position = UDim2.new( 
			startPos.X.Scale, 
			startPos.X.Offset + delta.X, 
			startPos.Y.Scale, 
			startPos.Y.Offset + delta.Y ) 
			end 
		end)

	frame.InputChanged:Connect(function(input) 
	if input.UserInputType == Enum.UserInputType.MouseMovement 
	then 
		dragInput = input 
		end 
	end)

	UserInputService.InputChanged:Connect(function(input) 
	if input == dragInput and dragging then 
		local delta = input.Position - dragStart 
		frame.Position = UDim2.new( 
			startPos.X.Scale, 
			startPos.X.Offset + delta.X, 
			startPos.Y.Scale, 
			startPos.Y.Offset + delta.Y ) 
			end 
		end)

		local function makeMobileFriendly(button) 
		button.AutoButtonColor = true 
		button.TextScaled = true 
		button.Font = Enum.Font.GothamBold 
		button.TextSize = 14 
		end

		-- UI 
		local tpButton = Instance.new("TextButton") 
		tpButton.Size = UDim2.new(0, 220, 0, 35) 
		tpButton.Position = UDim2.new(0, 10, 0, 10) 
		tpButton.Text = "Teleport To Pos" 
		tpButton.Parent = frame

	local posBox = Instance.new("TextBox") 
	posBox.Size = UDim2.new(0, 220, 0, 30) 
	posBox.Position = UDim2.new(0, 10, 0, 50) 
	posBox.PlaceholderText = "X, Y, Z" 
	posBox.Text = "" 
	posBox.Parent = frame

	local copyButton = Instance.new("TextButton") 
	copyButton.Size = UDim2.new(0, 220, 0, 35) 
	copyButton.Position = UDim2.new(0, 10, 0, 90) 
	copyButton.Text = "Copy Current Position" 
	copyButton.Parent = frame

	local posLabel = Instance.new("TextLabel") 
	posLabel.Size = UDim2.new(0, 220, 0, 30) 
	posLabel.Position = UDim2.new(0, 10, 0, 130) 
	posLabel.BackgroundTransparency = 1 
	posLabel.TextColor3 = Color3.new(6, 192, 74) 
	posLabel.Text = "Position: Loading..." 
	posLabel.Parent = frame

	local speedBox = Instance.new("TextBox") 
	speedBox.Size = UDim2.new(0, 220, 0, 30) 
	speedBox.Position = UDim2.new(0, 10, 0, 170) 
	speedBox.Text = "16" 
	speedBox.PlaceholderText = "WalkSpeed" 
	speedBox.Parent = frame

	local speedButton = Instance.new("TextButton") 
	speedButton.Size = UDim2.new(0, 220, 0, 35) 
	speedButton.Position = UDim2.new(0, 10, 0, 210) 
	speedButton.Text = "Set Speed" 
	speedButton.Parent = frame

	local UIScale = Instance.new("UIScale") 
	UIScale.Parent = frame

	local function updateScale() 
		local viewport = workspace.CurrentCamera.ViewportSize

	-- base scale for 1080p reference 
		local scale = math.clamp(viewport.X / 1920, 0.75, 1.25)
		UIScale.Scale = scale 
	end

	local creditsButton = Instance.new("TextButton")
creditsButton.Size = UDim2.new(0, 220, 0, 35)
creditsButton.Position = UDim2.new(0, 10, 0, 570) -- adjust if needed
creditsButton.Text = "Credits"
creditsButton.Parent = frame
local creditsFrame = Instance.new("Frame")
creditsFrame.Size = UDim2.new(0, 300, 0, 150)
creditsFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
creditsFrame.BackgroundColor3 = Color3.fromRGB(6, 192, 74)
creditsFrame.BorderSizePixel = 0
creditsFrame.Visible = false
creditsFrame.Parent = gui

local creditsText = Instance.new("TextLabel")
creditsText.Size = UDim2.new(1, -20, 1, -50)
creditsText.Position = UDim2.new(0, 10, 0, 10)
creditsText.BackgroundTransparency = 1
creditsText.TextColor3 = Color3.new(6, 192, 74)
creditsText.TextScaled = true
creditsText.Font = Enum.Font.GothamBold
creditsText.Text = "Grow Anything Script\n\nMade By vlexlys"
creditsText.Parent = creditsFrame

local closeCredits = Instance.new("TextButton")
closeCredits.Size = UDim2.new(0, 100, 0, 30)
closeCredits.Position = UDim2.new(0.5, -50, 1, -40)
closeCredits.Text = "Close"
closeCredits.Parent = creditsFrame
creditsButton.MouseButton1Click:Connect(function()
	creditsFrame.Visible = true
end)

closeCredits.MouseButton1Click:Connect(function()
	creditsFrame.Visible = false
end)

local jumpBox = Instance.new("TextBox")
jumpBox.Size = UDim2.new(0, 220, 0, 30)
jumpBox.Position = UDim2.new(0, 10, 0, 250)
jumpBox.Text = "50"
jumpBox.PlaceholderText = "JumpPower"
jumpBox.Parent = frame

local jumpButton = Instance.new("TextButton")
jumpButton.Size = UDim2.new(0, 220, 0, 35)
jumpButton.Position = UDim2.new(0, 10, 0, 290)
jumpButton.Text = "Set Jump Power"
jumpButton.Parent = frame
jumpButton.MouseButton1Click:Connect(function()
	local jumpPower = tonumber(jumpBox.Text)
	local char = player.Character

	if jumpPower and char and char:FindFirstChild("Humanoid") then
		local hum = char.Humanoid
		hum.UseJumpPower = true
		hum.JumpPower = jumpPower
	end
end)

local iyButton = Instance.new("TextButton")
iyButton.Size = UDim2.new(0, 220, 0, 35)
iyButton.Position = UDim2.new(0, 10, 0, 530) -- adjust as needed
iyButton.Text = "Open Infinite Yield"
iyButton.Parent = frame
iyButton.MouseButton1Click:Connect(function()
	pcall(function()
		loadstring(game:HttpGet(
			"https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"
		))()
	end)
end)

	updateScale()
		workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)

		-- teleport 
		tpButton.MouseButton1Click:Connect(function() 
		local x, y, z = posBox.Text:match("([^,]+),%s*([^,]+),%s*([^,]+)")

		x, y, z = tonumber(x), tonumber(y), tonumber(z)

		local char = player.Character 
		if char and char:FindFirstChild("HumanoidRootPart") and x then 
			char.HumanoidRootPart.CFrame = CFrame.new(x, y, z) 
			end 
		end)

		-- speed 
		speedButton.MouseButton1Click:Connect(function() 
		local speed = tonumber(speedBox.Text) 
		local char = player.Character

		if speed and char and char:FindFirstChild("Humanoid") 
		then char.Humanoid.WalkSpeed = speed 
		end 
	end)

	copyButton.MouseButton1Click:Connect(function() 
	local char = player.Character 
	if char and char:FindFirstChild("HumanoidRootPart") then 
		local p = char.HumanoidRootPart.Position 
		local text = string.format("%.2f, %.2f, %.2f", p.X, p.Y, p.Z)

		posBox.Text = text 
		if setclipboard then setclipboard(text) 
			end 
		end 
	end)
	
	-- live position loop (ONLY THIS LOOP) 
	task.spawn(function() 
		while true do 
			local char = player.Character 
			if char and char:FindFirstChild("HumanoidRootPart") then 
				local p = char.HumanoidRootPart.Position 
				posLabel.Text = string.format("Pos: %.1f, %.1f, %.1f", p.X, p.Y, p.Z) 
				end 
				task.wait(0.1) 
			end 
		end)

		local sharkButton = Instance.new("TextButton") 
		sharkButton.Size = UDim2.new(0, 220, 0, 35) 
		sharkButton.Position = UDim2.new(0, 10, 0, 450) -- adjust if needed 
		sharkButton.Text = "Event Completion Request" 
		sharkButton.Parent = frame

	sharkButton.MouseButton1Click:Connect(function() 
		pcall(function() 
			local Event = game:GetService("ReplicatedStorage") 
			:WaitForChild("Remotes") 
			:WaitForChild("Network") 
			:WaitForChild("RemoteFunction") 
			
			Event:InvokeServer("RequestSharkCompletion") 
			end) 
		end)

		local petButton = Instance.new("TextButton")
petButton.Size = UDim2.new(0, 220, 0, 35)
petButton.Position = UDim2.new(0, 10, 0, 490) -- adjust if needed
petButton.Text = "Teleport To Pet"
petButton.Parent = frame

petButton.MouseButton1Click:Connect(function()
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")

	if hrp then
		hrp.CFrame = CFrame.new(-49, 4, 22)
	end
end)

		-- auto sell system (SEPARATE) 
		local Event = game:GetService("ReplicatedStorage") 
		:WaitForChild("Remotes") 
		:WaitForChild("Network") 
		:WaitForChild("RemoteFunction")

	local autoSellEnabled = false

	local autoSellButton = Instance.new("TextButton") 
	autoSellButton.Size = UDim2.new(0, 220, 0, 35) 
	autoSellButton.Position = UDim2.new(0, 10, 0, 330) 
	autoSellButton.Text = "Auto Sell: OFF" 
	autoSellButton.Parent = frame

	autoSellButton.MouseButton1Click:Connect(function()
		autoSellEnabled = not autoSellEnabled 
		autoSellButton.Text = autoSellEnabled and "Auto Sell: ON" or "Auto Sell: OFF" 
	end)

	task.spawn(function() 
		while true do 
			if autoSellEnabled then 
				pcall(function() 
				Event:InvokeServer("DialogInit", workspace.NPCs.Seller, "SellInventory") 
				end) 
			end 
			task.wait(1) 
		end 
	end)

	local flyEnabled = false 
	local flyButton = Instance.new("TextButton") 
	flyButton.Size = UDim2.new(0, 220, 0, 35) 
	flyButton.Position = UDim2.new(0, 10, 0, 370) 
	flyButton.Text = "Fly: OFF" 
	flyButton.Parent = frame 
	local UserInputService = game:GetService("UserInputService") 
	local RunService = game:GetService("RunService")

	local flying = false 
	local flySpeed = 100

	local bodyVelocity 
	local moveVector = Vector3.zero

	local keys = { 
		W = false, 
		A = false, 
		S = false, 
		D = false, 
		Space = false, 
		LeftShift = false 
	}

	UserInputService.InputBegan:Connect(function(input, gpe) 
		if gpe then return end 
		
		local key = input.KeyCode.Name 
		if keys[key] ~= nil 
			then keys[key] = true 
		end 
	end)

	UserInputService.InputEnded:Connect(function(input) 
		local key = input.KeyCode.Name 
		if keys[key] ~= nil then 
			keys[key] = false 
			end 
		end)
		
		flyButton.MouseButton1Click:Connect(function() 
			flyEnabled = not flyEnabled

			local char = player.Character 
			local hrp = char and char:FindFirstChild("HumanoidRootPart") 
			local hum = char and char:FindFirstChild("Humanoid")

			if flyEnabled then 
				flyButton.Text = "Fly: ON"
				
				if hrp then 
					bodyVelocity = Instance.new("BodyVelocity") 
					bodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9) 
					bodyVelocity.Velocity = Vector3.zero 
					bodyVelocity.Parent = hrp 
				end

				if hum then hum.PlatformStand = true 
				end 
				else flyButton.Text = "Fly: OFF" 
				
				if bodyVelocity then 
					bodyVelocity:Destroy() 
					bodyVelocity = nil 
				end

				if hum then 
					hum.PlatformStand = false 
				end 
			end 
		end)

		RunService.RenderStepped:Connect(function() 
			if not flyEnabled then return end

			local char = player.Character 
			local hrp = char and char:FindFirstChild("HumanoidRootPart") 
			if not hrp or not bodyVelocity then return end 
			
			local cam = workspace.CurrentCamera 
			local direction = Vector3.zero

			if keys.W then direction += cam.CFrame.LookVector end 
			if keys.S then direction -= cam.CFrame.LookVector end 
			if keys.D then direction += cam.CFrame.RightVector end 
			if keys.A then direction -= cam.CFrame.RightVector end 
			if keys.Space then direction += Vector3.new(0, 1, 0) end 
			if keys.LeftShift then direction -= Vector3.new(0, 1, 0) end

			if direction.Magnitude > 0 then 
				direction = direction.Unit 
			end

			bodyVelocity.Velocity = direction * flySpeed 
		end)

		local destroyButton = Instance.new("TextButton") 
		destroyButton.Size = UDim2.new(0, 220, 0, 35) 
		destroyButton.Position = UDim2.new(0, 10, 0, 410) 
		destroyButton.Text = "Exit Cheat" 
		destroyButton.Parent = frame 
		destroyButton.MouseButton1Click:Connect(function() 
		-- disable toggles so loops stop cleanly 
		flyEnabled = false 
		autoSellEnabled = false

		-- remove GUI completely 
		gui:Destroy() 
	end)
