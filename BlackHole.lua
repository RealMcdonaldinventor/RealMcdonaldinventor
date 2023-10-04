tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Equip to tp black hole"
tool.Parent = Player.Backpack
local Folder = Instance.new("Folder",workspace)
Folder.Name = "Fdr01"
local Part = Instance.new("Part",Folder)
local Attachment1 = Instance.new("Attachment",Part)
Attachment1.Name = "At01"
Part.Anchored = true
Part.CanCollide = false
Part.Transparency = 0
local NetworkAccess = coroutine.create(function()
    settings().Physics.AllowSleep = false
    while game:GetService("RunService").RenderStepped:Wait() do
      if Hum.Health <= 0 then
        break
      end
        for _, Players in next, game:GetService("Players"):GetPlayers() do
            if Players ~= Player then
                Players.MaximumSimulationRadius = 0 
                sethiddenproperty(Players, "SimulationRadius", 0)
           end 
        end
        Player.MaximumSimulationRadius = 99999999999999999999
        setsimulationradius(99999999999999999999,99999999999999999999)
    end 
end)
coroutine.resume(NetworkAccess)
local function ForcePart(v)
        if Hum.Health <= 0 then
        return
      end
    if v:IsA("BasePart") and v.Anchored == false and v.Parent:FindFirstChild("Humanoid") == nil and v.Parent:FindFirstChild("Head") == nil and v.Name ~= "Handle" then
        Mouse.TargetFilter = v
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
        Torque = Instance.new("Torque", v)
      Torque.Name = "T01"
        Torque.Torque = Vector3.new(100000, 100000, 100000)
        AlignPosition = Instance.new("AlignPosition", v)
      AlignPosition.Name = "Al01"
        Attachment2 = Instance.new("Attachment", v)
      Attachment2.Name = "At02"
        Torque.Attachment0 = Attachment2
        AlignPosition.MaxForce = 9999999999999999
        AlignPosition.MaxVelocity = math.huge
        AlignPosition.Responsiveness = 500
        AlignPosition.Attachment0 = Attachment2 
        AlignPosition.Attachment1 = Attachment1
    end
end
for _, v in next, workspace:GetDescendants() do
  if Hum.Health <= 0 then
    break
  end
    ForcePart(v)
end
local connections
connections = workspace.DescendantAdded:Connect(function(v)
  if Hum.Health <= 0 then
    connections:Disconnect()
  end
    ForcePart(v)
end)
spawn(function()
    while game:GetService("RunService").RenderStepped:Wait() do
            if Hum.Health <= 0 then
        break
      end
        Attachment1.Position = (Char.Head.Position + Char.Head.Position.Unit * 10) + Char.Head.Orien
    end
end)
local Died
    Died = Hum.Died:Connect(function()
      task.wait(1)
      for _,v in pairs(game:GetDescendants()) do
        if v.Name == "At02" or v.Name == "At01" or v.Name == "T01" or v.Name == "Al01" or v.Name == "Fdr01" then
          v:Destroy()
        end
      end
      Folder:Destroy()
      AlignPosition:Destroy()
      Attachment2:Destroy()
      Attachment1:Destroy()
      script:Destroy()
      Died:Disconnect()
    end)
