--for hidden devs mods this is for a local script in starter character or starter player! btw, i made it in a local script since im limited to one script
local uis = game:GetService("UserInputService")
local Attachment = game.Workspace:WaitForChild("Victim")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local Mouse = player:GetMouse()
local Speller = workspace:WaitForChild("SpellCaster")
local Victim = workspace:WaitForChild("Victim")
local Animation = script.Grab
local track = character.Humanoid.Animator:LoadAnimation(Animation)

uis.InputBegan:Connect(function(input, gpe)
	if gpe == true then return end

	if input.KeyCode == Enum.KeyCode.G then
		if Attachment.Parent == character:FindFirstChild("HumanoidRootPart") then return end
		print("plr has pressed: " .. input.KeyCode.Name)
		print("fetch me their soul")
	end
end)


local rayParams = RaycastParams.new()
rayParams.FilterDescendantsInstances = {character}
rayParams.FilterType = Enum.RaycastFilterType.Exclude


game["Run Service"].RenderStepped:Connect(function(dT)
	local unitRay = Mouse.UnitRay
	local Origin = unitRay.Origin
	local direction = unitRay.Direction * 1000
	local result, pos = workspace:Raycast(Origin, direction, rayParams)


uis.InputBegan:Connect(function(input, gpe)
	if gpe == true then return end
	if input.KeyCode == Enum.KeyCode.G then
		if result then
			if not result.Instance.Parent:FindFirstChild("Humanoid") then return end
			
			if result.Instance.Parent:FindFirstChild("Humanoid") then
				print("found humanoid")
				Attachment.Parent = result.Instance.Parent:FindFirstChild("HumanoidRootPart")
				Speller.Parent = character:FindFirstChild("HumanoidRootPart")
				track:Play()
				while task.wait(0.3) do
					Speller.Position = character.HumanoidRootPart.Position
					Victim.Position = result.Instance.Parent:FindFirstChild("HumanoidRootPart").Position
						result.Instance.Parent:FindFirstChild("Humanoid").Health -= 0.05
				end
			end
		end
	end
	task.wait(3)
	Speller.Parent = nil
	Victim.Parent = nil
	Speller.Position = Vector3.new(0,100,0)
	Victim.Position = Vector3.new(0,110,0)
    end)
end)
