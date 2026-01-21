-- Jailbreak Auto Rob - Ready for loadstring (Delta Executor)

if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.PlaceId ~= 606849621 then
    warn("Script apenas para Jailbreak.")
    return
end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- UI Library
local Rayfield = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua"
))()

local Window = Rayfield:CreateWindow({
    Name = "Jailbreak Auto Rob",
    LoadingTitle = "Auto Rob",
    LoadingSubtitle = "Delta Executor",
    ConfigurationSaving = {
        Enabled = false
    },
    KeySystem = false
})

local FarmTab = Window:CreateTab("Farm", 4483362458)

-- Character
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
end)

local function SafeTP(cf)
    if HumanoidRootPart then
        HumanoidRootPart.Velocity = Vector3.zero
        HumanoidRootPart.CFrame = cf
    end
end

-- Auto Rob
local AutoRob = false

local Robberies = {
    {
        Name = "Bank",
        Check = function()
            return Workspace.Banks:GetChildren()[1].Open.Value
        end,
        CFrame = CFrame.new(10, 20, 800)
    },
    {
        Name = "Jewelry",
        Check = function()
            return Workspace.Jewelrys:GetChildren()[1].Open.Value
        end,
        CFrame = CFrame.new(130, 20, 1300)
    },
    {
        Name = "Museum",
        Check = function()
            return Workspace.Museum.Open.Value
        end,
        CFrame = CFrame.new(1100, 120, 1300)
    }
}

local function RunAutoRob()
    task.spawn(function()
        while AutoRob do
            for _, rob in ipairs(Robberies) do
                if not AutoRob then break end
                pcall(function()
                    if rob.Check() then
                        Rayfield:Notify({
                            Title = "Auto Rob",
                            Content = "Roubando: "..rob.Name,
                            Duration = 2
                        })
                        SafeTP(rob.CFrame)
                        task.wait(5)
                    end
                end)
            end
            task.wait(2)
        end
    end)
end

FarmTab:CreateToggle({
    Name = "Auto Rob",
    CurrentValue = false,
    Callback = function(v)
        AutoRob = v
        if v then
            RunAutoRob()
        end
    end
})

Rayfield:Notify({
    Title = "Auto Rob",
    Content = "Carregado com sucesso!",
    Duration = 4
})
