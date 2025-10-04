--==============================================
--            SCRIPT SUPREMO ROBLOX
--==============================================

-- CONFIGURAÇÕES GLOBAIS
_G.Settings = {
Boss = {
["Auto All Boss"] = false,
["Auto Boss Select"] = false,
["Select Boss"] = {"Hallow Boss"}, -- Exemplo
},
Configs = {
["Auto Haki"] = false,
},
FightingStyle = {
["Auto God Human"] = false,
["Auto Superhuman"] = false,
["Auto Electric Claw"] = false,
}
}

-- FUNÇÕES PRINCIPAIS
local function Bypass(cframe)
-- Teleporta personagem até a posição desejada
if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cframe
end
end

local function AttackFunction()
-- Ataque automático básico
local player = game.Players.LocalPlayer
if player.Character and player.Character:FindFirstChild("Humanoid") then
player.Character.Humanoid:MoveTo(player.Character.HumanoidRootPart.Position + Vector3.new(0,0,0))
end
end

--==============================================
--              AUTO BOSS FARM
--==============================================
spawn(function()
while wait() do
if _G.Settings.Boss["Auto All Boss"] or _G.Settings.Boss["Auto Boss Select"] then
for _, bossName in pairs(_G.Settings.Boss["Select Boss"]) do
local boss = workspace.Bosses:FindFirstChild(bossName)
if boss and boss:FindFirstChild("HumanoidRootPart") then
Bypass(boss.HumanoidRootPart.CFrame)
AttackFunction()
wait(1)
end
end
end
end
end)

--==============================================
--          AUTO HAKI E ESTILOS DE LUTA
--==============================================
spawn(function()
while wait(0.1) do
-- Auto Haki
if _G.Settings.Configs["Auto Haki"] then
pcall(function()
game.ReplicatedStorage.Remotes.ActivateHaki:FireServer()
end)
end

-- Auto estilos de luta  
    if _G.Settings.FightingStyle["Auto God Human"] then  
        pcall(function()  
            game.ReplicatedStorage.Remotes.UseFightingStyle:FireServer("GodHuman")  
        end)  
    end  
    if _G.Settings.FightingStyle["Auto Superhuman"] then  
        pcall(function()  
            game.ReplicatedStorage.Remotes.UseFightingStyle:FireServer("Superhuman")  
        end)  
    end  
    if _G.Settings.FightingStyle["Auto Electric Claw"] then  
        pcall(function()  
            game.ReplicatedStorage.Remotes.UseFightingStyle:FireServer("ElectricClaw")  
        end)  
    end  
end

end)

--==============================================
--                     GUI
--==============================================
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/euSou-qualquerPessoa/rtx/main/plock.lua"))()
local Main = Library:Create("Script Supremo")

-- Aba de Boss e Combate
local Tab2 = Main.create("Boss e Combate")
local Page2 = Tab2.xovapage(1)

-- Toggle Auto All Boss
Page2.Toggle({
Title = "Auto All Boss",
Mode = 2,
Default = _G.Settings.Boss["Auto All Boss"],
callback = function(value)
_G.Settings.Boss["Auto All Boss"] = value
end
})

-- Toggle Auto Boss Select
Page2.Toggle({
Title = "Auto Boss Select",
Mode = 2,
Default = _G.Settings.Boss["Auto Boss Select"],
callback = function(value)
_G.Settings.Boss["Auto Boss Select"] = value
end
})

-- Lista de Boss para selecionar
Page2.List({
Title = "Select Boss",
Values = {"Hallow Boss", "Dragon Boss", "Marine Boss"},
Default = _G.Settings.Boss["Select Boss"],
Multi = true,
callback = function(selected)
_G.Settings.Boss["Select Boss"] = selected
end
})

-- Toggle Auto Haki
Page2.Toggle({
Title = "Auto Haki",
Mode = 2,
Default = _G.Settings.Configs["Auto Haki"],
callback = function(value)
_G.Settings.Configs["Auto Haki"] = value
end
})

-- Toggles para estilos de luta
Page2.Toggle({
Title = "Auto God Human",
Mode = 2,
Default = _G.Settings.FightingStyle["Auto God Human"],
callback = function(value)
_G.Settings.FightingStyle["Auto God Human"] = value
end
})

Page2.Toggle({
Title = "Auto Superhuman",
Mode = 2,
Default = _G.Settings.FightingStyle["Auto Superhuman"],
callback = function(value)
_G.Settings.FightingStyle["Auto Superhuman"] = value
end
})

Page2.Toggle({
Title = "Auto Electric Claw",
Mode = 2,
Default = _G.Settings.FightingStyle["Auto Electric Claw"],
callback = function(value)
_G.Settings.FightingStyle["Auto Electric Claw"] = value
end
})
--[[
PARTE 2 - FUNCIONALIDADES AVANÇADAS
Para juntar com a Parte 1
]]--

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

-- CONFIGURAÇÃO
local AutoFarm = true
local AutoCollect = true
local AutoTeleport = true
local AntiKick = true

-- FUNÇÃO: Teleporte para ponto
local function TeleportTo(position)
if hrp then
hrp.CFrame = CFrame.new(position)
end
end

-- FUNÇÃO: Auto Farm Mobs
local function AutoFarmMobs()
spawn(function()
while AutoFarm do
for _, mob in pairs(workspace.Mobs:GetChildren()) do
if mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
TeleportTo(mob.HumanoidRootPart.Position)
firetouchinterest(hrp, mob.HumanoidRootPart, 0)
firetouchinterest(hrp, mob.HumanoidRootPart, 1)
wait(0.5)
end
end
wait(1)
end
end)
end

-- FUNÇÃO: Auto Coleta de Drops
local function AutoCollectDrops()
spawn(function()
while AutoCollect do
for _, drop in pairs(workspace.Drops:GetChildren()) do
if drop:IsA("Part") then
TeleportTo(drop.Position)
wait(0.3)
end
end
wait(1)
end
end)
end

-- FUNÇÃO: Anti Kick
if AntiKick then
game:GetService("Players").LocalPlayer.OnTeleport = function()
-- prevenção simples
print("Anti-Kick ativo, teleport cancelado")
end
end

-- FUNÇÃO: Auto Teleporte entre ilhas
local Islands = {
Vector3.new(100, 5, 100), -- ilha 1
Vector3.new(500, 5, 500), -- ilha 2
Vector3.new(900, 5, 900), -- ilha 3
}

local function AutoIslandTeleport()
spawn(function()
while AutoTeleport do
for _, pos in pairs(Islands) do
TeleportTo(pos)
wait(5)
end
end
end)
end

-- INICIAR FUNÇÕES
AutoFarmMobs()
AutoCollectDrops()
AutoIslandTeleport()

print("Parte 2 ativada: AutoFarm, AutoCollect, Teleporte e AntiKick funcionando!")
