-- Universal Jailbreak Hub - Auto Rob (Delta Executor)
if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.PlaceId ~= 606849621 then
    warn("Este script funciona apenas no Jailbreak.")
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
    Name = "Universal Jailbreak Hub",
    LoadingTitle = "Auto Rob",
    LoadingSubtitle = "Delta Executor",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "UniversalJB",
        FileName = "AutoRob"
    },
    KeySystem = false
})

local FarmTab = Window:CreateTab("Farm", 4483362458)

-- Character handling
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
end)

local function SafeTP(cframe)
    if HumanoidRootPart then
        HumanoidRootPart.Velocity = Vector3.zero
        HumanoidRootPart.CFrame = cframe
    end
end

-- Auto Rob
local AutoRob = false

local Robberies = {
    {
        Name = "Bank",
        OpenCheck = function()
            return Workspace.Banks:GetChildren()[1].Open.Value
        end,
        Position = CFrame.new(10, 20, 800)
    },
    {
        Name = "Jewelry",
        OpenCheck = function()
            return Workspace.Jewelrys:GetChildren()[1].Open.Value
        end,
        Position = CFrame.new(130, 20, 1300)
    },
    {
        Name = "Museum",
        OpenCheck = function()
            return Workspace.Museum.Open.Value
        end,
        Position = CFrame.new(1100, 120, 1300)
    }
}

local function StartAutoRob()
    task.spawn(function()
        while AutoRob do
            pcall(function()
                for _, rob in pairs(Robberies) do
                    if not AutoRob then break end
                    if rob.OpenCheck() then
                        Rayfield:Notify({
                            Title = "Auto Rob",
                            Content = "Roubando: "..rob.Name,
                            Duration = 2
                        })
                        SafeTP(rob.Position)
                        task.wait(5)
                    end
                end
            end)
            task.wait(2)
        end
    end)
end

FarmTab:CreateToggle({
    Name = "Auto Rob",
    CurrentValue = false,
    Callback = function(Value)
        AutoRob = Value
        if Value then
            StartAutoRob()
        end
    end
})

Rayfield:Notify({
    Title = "Universal Jailbreak Hub",
    Content = "Auto Rob carregado!",
    Duration = 5
})
