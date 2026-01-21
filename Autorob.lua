-- Jailbreak Auto Rob - Delta Mobile (No UI)

if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.PlaceId ~= 606849621 then return end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
end)

local function SafeTP(cf)
    HumanoidRootPart.Velocity = Vector3.zero
    HumanoidRootPart.CFrame = cf
end

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

task.spawn(function()
    while true do
        for _, rob in ipairs(Robberies) do
            pcall(function()
                if rob.Check() then
                    SafeTP(rob.CFrame)
                    task.wait(6)
                end
            end)
        end
        task.wait(3)
    end
end)

warn("AUTO ROB ATIVO")
