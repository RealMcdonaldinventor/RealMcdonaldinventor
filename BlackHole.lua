--Sorry if the script is messy, you can improve it tho--
--Some of the variables--
local Player = game:GetService("Players").LocalPlayer
local Hum = Player.Character:WaitForChild("Humanoid")
local Mouse = Player:GetMouse()
local Folder = Instance.new("Folder")
local Part = Instance.new("Part")
local Attachment1 = Instance.new("Attachment")
local Updated = Mouse.Hit + Vector3.new(0, 1, 0)
local tool = Instance.new("Tool")
local Speed = Instance.new("IntValue")
local loop
tool.RequiresHandle = false
tool.Name = "Equip to tp black hole"
Part.Anchored = true
Part.CanCollide = false
Part.Transparency = 0
Speed.Parent = Folder
Speed.Name = "Speed"
Speed.Value = 50
Folder.Parent = workspace
Folder.Name = "Codysecretyayay"
Part.Parent = Folder
Attachment1.Parent = Part
Attachment1.Name = "Codysecretyayay"
tool.Parent = Player.Backpack
--Network Access--
local NetworkAccess = coroutine.create(function()
  settings().Physics.AllowSleep = false
  loop = game:GetService("RunService").RenderStepped:Connect(function()
    for _, Players in next, game:GetService("Players"):GetPlayers() do
      if Players ~= Player then
        Players.MaximumSimulationRadius = 0 
        sethiddenproperty(Players, "SimulationRadius", 0) 
        end 
    end
    Player.MaximumSimulationRadius = 999999999999999999
    setsimulationradius(99999999999999999,999999999999999) 
  end)
end) 
coroutine.resume(NetworkAccess)
--Main function--
local function ForcePart(v)
  if v:IsA("BasePart") and v.Anchored == false and v.Parent:FindFirstChild("Humanoid") == nil and v.Parent:FindFirstChild("Head") == nil and v.Name ~= "Handle" then
    Mouse.TargetFilter = v
    for _, x in next, v:GetChildren() do
      if x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or x:IsA("BodyThrust") or x:IsA("BodyVelocity") or x:IsA("RocketPropulsion") then
        x:Destroy()
      end
    end
    if v:FindFirstChild("Attachment") then
      v:FindFirstChild("Attachment"):Destroy()
    end
    if v:FindFirstChild("AlignPosition") then
      v:FindFirstChild("AlignPosition"):Destroy()
    end
    if v:FindFirstChild("Torque") then
      v:FindFirstChild("Torque"):Destroy()
    end
    v.CanCollide = false
    Torque = Instance.new("Torque")
    AlignPosition = Instance.new("AlignPosition")
    Attachment2 = Instance.new("Attachment")
    Torque.Parent = v
    Torque.Name = "Codysecretyayay"
    AlignPosition.Parent = v
    AlignPosition.Name = "AlignPos123"
    Attachment2.Parent = v
    Attachment2.Name = "Codysecretyayay"
    Torque.Torque = Vector3.new(100000, 100000, 100000)
    Torque.Attachment0 = Attachment2
    AlignPosition.MaxForce = 9999999999999999
    AlignPosition.MaxVelocity = math.huge
    AlignPosition.Responsiveness = Speed.Value
    AlignPosition.Attachment0 = Attachment2 
    AlignPosition.Attachment1 = Attachment1
  end
end
--Change black hole speed--
local SpeedChanged = Speed.Changed:Connect(function()
  for _, v in pairs(workspace:GetDescendants()) do
    if v.Name == "AlignPos123" then
      v.Responsiveness = Speed.Value
    end
  end
end)
--Get the parts--
for _, v in next, workspace:GetDescendants() do
  ForcePart(v)
end
local Descadded = workspace.DescendantAdded:Connect(function(v)
  ForcePart(v)
end)
local toolactive = tool.Activated:Connect(function()
  if Mouse.Button1Down then
    Updated = Mouse.Hit + Vector3.new(0,1,0)
  end
end)
--Tp the black hole--
local tpparts = coroutine.create(function()
  while game:GetService("RunService").RenderStepped:Wait() do
    Attachment1.WorldCFrame = Updated
  end
end)
coroutine.resume(tpparts)
--Cleaning up after player dies/Black hole is disabled--
local function onDied()
  for _, otd in pairs(game:GetDescendants()) do
    if otd.Name == "Codysecretyayay" or otd.Name == "AlignPos123" then
      otd:Destroy()
    end
  end
  coroutine.close(tpparts)
  loop:Disconnect()
  coroutine.close(NetworkAccess)
  SpeedChanged:Disconnect()
  toolactive:Disconnect()
  Descadded:Disconnect()
  script:Destroy()
end
Hum.Died:Connect(onDied)
