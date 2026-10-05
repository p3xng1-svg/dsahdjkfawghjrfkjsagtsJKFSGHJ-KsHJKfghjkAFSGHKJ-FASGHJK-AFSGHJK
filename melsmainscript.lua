--// MELS MAIN - DaHood UNDETECTED (NEW SKIN CHANGER + WHITELIST)
--// Place in StarterPlayer > StarterPlayerScripts
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")

--==================================================
-- UI SOUNDS
--==================================================
local ContentProvider = game:GetService("ContentProvider")

local _hoverSound = Instance.new("Sound")
_hoverSound.Name = "MelsUIHover"
_hoverSound.SoundId = "rbxassetid://9120299506"
_hoverSound.Volume = 0.18
_hoverSound.PlaybackSpeed = 2.0
_hoverSound.Parent = SoundService

local _clickSound = Instance.new("Sound")
_clickSound.Name = "MelsUIClick"
_clickSound.SoundId = "rbxassetid://113397864512278"
_clickSound.Volume = 0.28
_clickSound.PlaybackSpeed = 1.0
_clickSound.Parent = SoundService

task.spawn(function()
    pcall(function()
        ContentProvider:PreloadAsync({_hoverSound, _clickSound})
    end)
end)

local function _playUISound(sound, duration)
    if not sound or sound.SoundId == "" then return end
    sound:Stop()
    sound.TimePosition = 0
    SoundService:PlayLocalSound(sound)
    if duration then
        task.delay(duration, function()
            if sound.IsPlaying then
                sound:Stop()
            end
        end)
    end
end

local function _playHover()
    _playUISound(_hoverSound, 0.12)
end

local function _playClick()
    _playUISound(_clickSound, 0.08)
end

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local mouse = Player:GetMouse()
local camera = workspace.CurrentCamera

--==================================================
-- WHITELIST STATE (defined before targeting funcs)
--==================================================
local _whitelisted = {}
local _whitelistRows = {}
local _wlListFrame = nil
local _wlCountLabel = nil

local function _isWhitelisted(plr)
    if not plr then return false end
    return _whitelisted[plr.UserId] == true
end

local oldGui = CoreGui:FindFirstChild("_ui")
if oldGui then oldGui:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "_ui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

--==================================================
-- NEW SKIN CHANGER CONFIG (shared.Saved)
--==================================================

shared.Saved = {
    ["GunModifiers"] = {
        ["SkinChanger"] = {
            ["Enabled"] = true,
            ["Skins"] = {
                ["[Knife]"] = "Golden",
                ["[Double-Barrel SG]"] = "Default",
                ["[TacticalShotgun]"] = "Default",
                ["[Revolver]"] = "Default",
                ["[Silencer]"] = "Default",
                ["[Glock]"] = "Default",
                ["[AR]"] = "Default",
                ["[AK47]"] = "Default",
                ["[SMG]"] = "Default",
                ["[P90]"] = "Default",
                ["[LMG]"] = "Default",
                ["[DrumGun]"] = "Default",
                ["[AUG]"] = "Default",
                ["[Rifle]"] = "Default",
                ["[SilencerAR]"] = "Default",
                ["[Shotgun]"] = "Default",
                ["[Drum-Shotgun]"] = "Default",
                ["[Deagle]"] = "Default",
                ["[Flintlock]"] = "Default",
            }
        },
    },
}

local skinLoaderLoaded = false
pcall(function()
    -- ============================================================
    -- INLINED SKIN CHANGER (was: pastebin.com/raw/sBm1auiD)
    -- ============================================================
    local v1 = unpack or table.unpack
    if not LPH_OBFUSCATED or LPH_OBFUSCATED == nil then
        function LPH_JIT_MAX(...)
            return ...
        end
        function LPH_NO_VIRTUALIZE(...)
            return ...
        end
    end
    local Players = game:GetService("Players")
    local Workspace = game:GetService("Workspace")
    local RunService = game:GetService("RunService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    game:GetService("HttpService")
    local LocalPlayer = Players.LocalPlayer
    local _ = math.random
    local rad = math.rad
    local new = CFrame.new
    local new2 = Vector3.new
    local _pcall = pcall
    local _xpcall = xpcall
    local _ = task.spawn
    local _ = task.delay
    local wait = task.wait
    local function v16(p1)
        warn("[SkinChanger Error]:", (tostring(p1)))
        return p1
    end
    local SkinAssets = ReplicatedStorage:FindFirstChild("SkinAssets")
    local t1 = {}
    local t2 = {}
    local t3 = {}
    local u21
    function t1.Register(p2)
        local v36 = type(p2) ~= "table"
        if not v36 then
            v36 = type(p2.Name) ~= "string"
        end
        if v36 then
            return false
        end
        table.insert(t2, p2)
        if type(p2.GameIds) == "table" then
            for _, v in ipairs(p2.GameIds) do
                if type(v) == "number" then
                    t3[v] = p2
                end
            end
        end
        return true
    end
    function t1.HasFeature(p3, p4)
        if not p4 then
            p4 = t1.ResolveGameDefinition()
        end
        local v41 = not p4
        if not v41 then
            v41 = type(p4.Features) ~= "table"
        end
        if v41 then
            return false
        end
        return p4.Features[p3] == true
    end
    t1.ResolveGameDefinition = LPH_NO_VIRTUALIZE(function()
        return u21
    end)
    local Register = t1.Register
    local t4 = {
        SkinChanger = true
    }
    local t5 = {
        UsesBodyEffects = true,
        KnockedValueName = "K.O",
        GrabConstraintName = "GRABBING_CONSTRAINT"
    }
    local t6 = {
        MainEvent = {
            Root = "ReplicatedStorage",
            Path = { "MainEvent" },
            ClassName = "RemoteEvent",
            Timeout = 12
        }
    }
    local t7 = {
        Emulate = true,
        CleanLocalScripts = true,
        Remote = "MainEvent",
        Args = {
            "Handle",
            "MuzzlePos",
            "HitPosition",
            "HitInstance",
            "HitNormal"
        },
        ServerTime = "Shotgun"
    }
    Register({
        Name = "Da Hood",
        GameIds = { 1008451066 },
        Features = t4,
        Metadata = t5,
        Remotes = t6,
        ShootGun = t7
    })
    u21 = t3[game.GameId]
    if not u21 then
        for _, v in ipairs(t2) do
            local Match = v.Match
            if Match then
                Match = type(v.Match) == "function"
            end
            if Match then
                local v30, v31 = _pcall(v.Match)
                if v30 then
                    v30 = v31 == true
                end
                if v30 then
                    break
                end
            end
        end
    end
    game:GetService("Stats")
    local HttpService = game:GetService("HttpService")
    local MarketplaceService = game:GetService("MarketplaceService")
    if t1.HasFeature("SkinChanger") then
        (function()
            local t13 = {
                value1 = function()
                    return shared.Saved.GunModifiers.SkinChanger
                end,
                value2 = {},
                value3 = {},
                value4 = {},
                value5 = SkinAssets,
                value6 = ReplicatedStorage:FindFirstChild("SkinModules"),
                value7 = nil
            }
            local function v43(p5)
                local v77 = p5:lower():gsub(" ", "")
                local v78 = v77 == "goldenagetanto"
                if not v78 then
                    v78 = v77 == "gpo-knife"
                    if not v78 then
                        v78 = v77 == "gpo-knifeprestige"
                        if not v78 then
                            v78 = v77 == "heaven"
                            if not v78 then
                                v78 = v77 == "lovekukri"
                                if not v78 then
                                    v78 = v77 == "purpledagger"
                                    if not v78 then
                                        v78 = v77 == "bluedagger"
                                        if not v78 then
                                            v78 = v77 == "greendagger" or v77 == "reddagger"
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                return v78
            end
            local function v44(p6, p7)
                local t14 = {}
                local GetDescendants = p6.GetDescendants
                local _next = next
                local v84, v85 = GetDescendants(p6)
                while true do
                    local v86
                    v85, v86 = _next(v84, v85)
                    if not v85 then
                        break
                    end
                    if v86:IsA("BasePart") then
                        local v87 = v86.Name == "Handle.R"
                        if not v87 then
                            v87 = p6 == v86.Parent
                            if v87 then
                                v87 = v86.Name == "Handle"
                            end
                        end
                        if not v87 then
                            local _skinclone = v86:GetAttribute("_skinclone")
                            if not _skinclone then
                                _skinclone = p7
                                if p7 then
                                    _skinclone = v86 == p7 or v86:IsDescendantOf(p7)
                                end
                            end
                            if not _skinclone then
                                local Transparency = v86.Transparency
                                local LocalTransparencyModifier = v86.LocalTransparencyModifier
                                t14[v86] = {
                                    Transparency = Transparency,
                                    LocalTransparencyModifier = LocalTransparencyModifier
                                }
                                v86.Transparency = 1
                                v86.LocalTransparencyModifier = 1
                            end
                        end
                    end
                end
                return t14
            end
            local function v45(p8)
                if not p8 then
                    return
                end
                local _next = next
                local v93
                while true do
                    local v94
                    v93, v94 = _next(p8, v93)
                    if not v93 then
                        break
                    end
                    local v95 = v93
                    if v93 then
                        v95 = v93.Parent
                        if v95 then
                            v95 = type(v94) == "table"
                        end
                    end
                    if v95 then
                        v93.Transparency = v94.Transparency
                        v93.LocalTransparencyModifier = v94.LocalTransparencyModifier
                    end
                end
            end
            local function v46(p9, p10)
                local v98 = t13.value3[p9]
                local v99 = p10
                if p10 then
                    v99 = v98 and v98.hiddenParts
                end
                local v100 = v99 or nil
                if v98 then
                    if v98.track then
                        v98.track:Stop()
                        v98.track:Destroy()
                        v98.track = nil
                    end
                    if v98.welds then
                        local _next = next
                        local welds = v98.welds
                        local v103
                        while true do
                            local v104
                            v103, v104 = _next(welds, v103)
                            if not v103 then
                                break
                            end
                            if v104 then
                                v104:Destroy()
                            end
                        end
                    end
                    if v98.sounds then
                        local _next = next
                        local sounds = v98.sounds
                        local v107
                        while true do
                            local v108
                            v107, v108 = _next(sounds, v107)
                            if not v107 then
                                break
                            end
                            if v108 and v108.Parent then
                                v108:Destroy()
                            end
                        end
                    end
                    if not p10 then
                        v45(v98.hiddenParts)
                        v100 = nil
                    end
                end
                local Default = p9:FindFirstChild("Default")
                if Default then
                    local GetChildren = Default.GetChildren
                    local _next = next
                    local v112, v113 = GetChildren(Default)
                    while true do
                        local v114
                        v113, v114 = _next(v112, v113)
                        if not v113 then
                            break
                        end
                        local v115 = v114.Name == "Handle.R"
                        if not v115 then
                            v115 = v114:GetAttribute("_skinclone")
                        end
                        if v115 then
                            v114:Destroy()
                        end
                    end
                end
                t13.value3[p9] = nil
                return v100
            end
            function t13.value8(p11, p12, p13)
                if not v43(p13) then
                    return
                end
                if p11 ~= p12.Parent then
                    return
                end
                local Humanoid = p11:FindFirstChild("Humanoid")
                local RightHand = p11:FindFirstChild("RightHand")
                if not Humanoid or not RightHand then
                    return
                end
                local v121 = t13.value3[p12]
                local v122 = v121
                local g130
                local g155
                if v122 then
                    v122 = v121.welds
                    if v122 then
                        v122 = #v121.welds > 0
                    end
                end
                if v122 then
                    local Default = p12:FindFirstChild("Default")
                    if Default then
                        Default = p12:FindFirstChild("Default"):FindFirstChild("Handle.R")
                    end
                    if Default and Default.Parent then
                        local Motor6D = Default:FindFirstChildOfClass("Motor6D")
                        if Motor6D then
                            Motor6D.Part0 = RightHand
                        end
                        if not v121.hiddenParts then
                            local v125
                            local _next = next
                            local v127, v128 = p12:FindFirstChild("Default"):GetChildren()
                            local v129
                            repeat
                                v128, v129 = _next(v127, v128)
                                if not v128 then
                                    g130 = true
                                end
                                if g130 then
                                    break
                                end
                            until v129:GetAttribute("_skinclone")
                            if not g130 then
                                v125 = v129
                            end
                            g130 = false
                            v121.hiddenParts = v44(p12, v125)
                        end
                        local Animator = Humanoid:FindFirstChildOfClass("Animator")
                        if Animator then
                            local v132 = p13:lower():gsub(" ", "")
                            local s2
                            local s1
                            if v132 == "goldenagetanto" then
                                s1 = "rbxassetid://13473404819"
                                s2 = "rbxassetid://5917819099"
                            elseif v132 == "gpo-knife" or v132 == "gpo-knifeprestige" then
                                s1 = "rbxassetid://14014278925"
                                s2 = "rbxassetid://4604390759"
                            elseif v132 == "heaven" then
                                s1 = "rbxassetid://14500266726"
                                s2 = "rbxassetid://14489860007"
                            elseif v132 == "purpledagger" then
                                s1 = "rbxassetid://17824999722"
                                s2 = "rbxassetid://17822743153"
                            elseif v132 == "bluedagger" then
                                s1 = "rbxassetid://17824995184"
                                s2 = "rbxassetid://17822737046"
                            elseif v132 == "greendagger" then
                                s1 = "rbxassetid://17825004320"
                                s2 = "rbxassetid://17822741762"
                            elseif v132 == "reddagger" then
                                s1 = "rbxassetid://17825008844"
                                s2 = "rbxassetid://17822952417"
                            end
                            if s1 then
                                if v121.track then
                                    v121.track:Stop()
                                    v121.track:Destroy()
                                    v121.track = nil
                                end
                                local Animation = Instance.new("Animation")
                                Animation.AnimationId = s1
                                local track = Animator:LoadAnimation(Animation)
                                track.Looped = false
                                track:Play()
                                v121.track = track
                                Animation:Destroy()
                                track.Ended:Once(function()
                                    if v121.track == track then
                                        v121.track = nil
                                    end
                                    track:Destroy()
                                end)
                            end
                            if s2 then
                                local Sound = Instance.new("Sound")
                                Sound.SoundId = s2
                                Sound.Parent = Workspace
                                Sound:Play()
                                table.insert(v121.sounds, Sound)
                                Sound.Ended:Connect(function()
                                    Sound:Destroy()
                                end)
                            end
                        end
                        return
                    end
                end
                local v138 = v46(p12, true)
                t13.value3[p12] = {
                    track = nil,
                    welds = {},
                    sounds = {},
                    hiddenParts = v138
                }
                local v139 = t13.value3[p12]
                local Default = p12:FindFirstChild("Default")
                if not Default then
                    return
                end
                if not v139.hiddenParts then
                    v139.hiddenParts = v44(p12, nil)
                end
                local value6 = t13.value6
                if value6 then
                    value6 = t13.value6:FindFirstChild("Knives")
                end
                if not value6 then
                    return
                end
                local p13_2 = value6:FindFirstChild(p13)
                if not p13_2 then
                    return
                end
                local clone = p13_2:Clone()
                clone.Name = p13
                clone:SetAttribute("_skinclone", true)
                local Part = Instance.new("Part")
                Part.Name = "Handle.R"
                Part.Transparency = 1
                Part.CanCollide = false
                Part.Anchored = false
                Part.Size = new2(0.001, 0.001, 0.001)
                Part.Massless = true
                Part.Parent = Default
                local Motor6D = Instance.new("Motor6D")
                Motor6D.Name = "Handle.R"
                Motor6D.Part0 = RightHand
                Motor6D.Part1 = Part
                local s4
                Motor6D.Parent = Part
                local v147
                local s3
                local v149 = p13:lower():gsub(" ", "")
                if v149 == "goldenagetanto" then
                    v147 = new(0, -0.2, -1.2) * CFrame.Angles(rad(90), rad(263.7), rad(180))
                    s3 = "rbxassetid://13473404819"
                    s4 = "rbxassetid://5917819099"
                elseif v149 == "gpo-knife" or v149 == "gpo-knifeprestige" then
                    v147 = new(0, -0.32, -1.07) * CFrame.Angles(rad(90), rad(-97.4), rad(90))
                    s3 = "rbxassetid://14014278925"
                    s4 = "rbxassetid://4604390759"
                elseif v149 == "heaven" then
                    v147 = new(-0.02, -0.82, 0.2) * CFrame.Angles(rad(64.42), rad(3.79), rad(0))
                    s3 = "rbxassetid://14500266726"
                    s4 = "rbxassetid://14489860007"
                elseif v149 == "lovekukri" then
                    v147 = new(-0.14, 0.14, -1.62) * CFrame.Angles(rad(-90), rad(180), rad(-4.97))
                elseif v149 == "purpledagger" then
                    v147 = new(-0.13, -0.24, -1.8) * CFrame.Angles(rad(89.05), rad(96.63), rad(180))
                    s3 = "rbxassetid://17824999722"
                    s4 = "rbxassetid://17822743153"
                elseif v149 == "bluedagger" then
                    v147 = new(-0.13, -0.24, -1.8) * CFrame.Angles(rad(89.05), rad(96.63), rad(180))
                    s3 = "rbxassetid://17824995184"
                    s4 = "rbxassetid://17822737046"
                elseif v149 == "greendagger" then
                    v147 = new(-0.13, -0.24, -1.07) * CFrame.Angles(rad(89.05), rad(96.63), rad(180))
                    s3 = "rbxassetid://17825004320"
                    s4 = "rbxassetid://17822741762"
                elseif v149 == "reddagger" then
                    v147 = new(-0.13, -0.24, -1.07) * CFrame.Angles(rad(89.05), rad(96.63), rad(180))
                    s3 = "rbxassetid://17825008844"
                    s4 = "rbxassetid://17822952417"
                end
                if not v147 then
                    return
                end
                if clone:IsA("Model") then
                    if not clone.PrimaryPart then
                        local GetChildren = clone.GetChildren
                        local _next = next
                        local v152, v153 = GetChildren(clone)
                        local v154
                        repeat
                            v153, v154 = _next(v152, v153)
                            if not v153 then
                                g155 = true
                            end
                            if g155 then
                                break
                            end
                        until v154:IsA("BasePart")
                        if not g155 then
                            clone.PrimaryPart = v154
                        end
                    end
                    g155 = false
                    if clone.PrimaryPart then
                        local _next = next
                        local v157, v158 = clone:GetDescendants()
                        while true do
                            local v159
                            v158, v159 = _next(v157, v158)
                            if not v158 then
                                break
                            end
                            if v159:IsA("BasePart") then
                                v159.CanCollide = false
                                v159.Massless = true
                                v159.Anchored = false
                                local Weld = Instance.new("Weld")
                                Weld.Part0 = Part
                                Weld.Part1 = v159
                                Weld.C0 = v147
                                Weld.C1 = v159.CFrame:ToObjectSpace(clone.PrimaryPart.CFrame)
                                Weld.Parent = v159
                                table.insert(v139.welds, Weld)
                            end
                        end
                    end
                    clone.Parent = Default
                elseif clone:IsA("BasePart") then
                    clone.CanCollide = false
                    clone.Massless = true
                    clone.Anchored = false
                    clone.Parent = Default
                    local Weld = Instance.new("Weld")
                    Weld.Part0 = Part
                    Weld.Part1 = clone
                    Weld.C0 = v147
                    Weld.Parent = clone
                    table.insert(v139.welds, Weld)
                end
                v139.hiddenParts = v44(p12, clone)
                local Animator = Humanoid:FindFirstChildOfClass("Animator")
                if not Animator then
                    Animator = Instance.new("Animator")
                    Animator.Parent = Humanoid
                end
                if s3 then
                    local Animation = Instance.new("Animation")
                    Animation.AnimationId = s3
                    local track = Animator:LoadAnimation(Animation)
                    track.Looped = false
                    track:Play()
                    v139.track = track
                    Animation:Destroy()
                    track.Ended:Once(function()
                        if v139.track == track then
                            v139.track = nil
                        end
                        track:Destroy()
                    end)
                end
                if s4 then
                    local Sound = Instance.new("Sound")
                    Sound.SoundId = s4
                    Sound.Parent = Workspace
                    Sound:Play()
                    table.insert(v139.sounds, Sound)
                    Sound.Ended:Connect(function()
                        Sound:Destroy()
                    end)
                end
            end
            t13.value9 = nil
            local function v47()
                if t13.value7 then
                    return t13.value7
                end
                local value6 = t13.value6
                if value6 then
                    value6 = t13.value6:IsA("ModuleScript")
                end
                if value6 then
                    t13.value9 = t13.value6:Clone()
                    local t15, v168 = _xpcall(require, v16, t13.value9)
                    if t15 then
                        t13.value7 = v168
                    end
                end
                return t13.value7
            end
            local function v48(p14, p15)
                local v171 = v47()
                if not v171 then
                    return nil
                end
                local v172 = v171[p14] or v171["[" .. p14:gsub("%[", ""):gsub("%]", "") .. "]"]
                if not v172 then
                    return nil
                end
                return v172[p15] or v172[p15:gsub("-", " ")] or v172[p15:gsub("-", "")]
            end
            function t13.value10(p16, _, p18)
                if not t13.value6 then
                    return nil
                end
                if p18 then
                    local v176 = p16:lower():gsub(" ", "")
                    local Knives = t13.value6:FindFirstChild("Knives")
                    if Knives then
                        local GetChildren = Knives.GetChildren
                        local _next = next
                        local v180, v181 = GetChildren(Knives)
                        local v183
                        repeat
                            local g182 = false
                            repeat
                                while true do
                                    v181, v183 = _next(v180, v181)
                                    if not v181 then
                                        return nil
                                    end
                                    if v183:IsA("MeshPart") then
                                        break
                                    end
                                    if v183:IsA("Folder") or v183:IsA("Model") then
                                        local v184 = p16 == v183.Name
                                        if not v184 then
                                            v184 = v176 == v183.Name:lower():gsub(" ", "")
                                        end
                                        if v184 then
                                            local _next2 = next
                                            local v186, v187 = v183:GetChildren()
                                            local v188
                                            repeat
                                                v187, v188 = _next2(v186, v187)
                                                if not v187 then
                                                    g182 = true
                                                end
                                                if g182 then
                                                    break
                                                end
                                            until v188:IsA("MeshPart")
                                            if not g182 then
                                                return v188
                                            end
                                        end
                                    end
                                    if g182 then
                                        break
                                    end
                                end
                                if g182 then
                                    break
                                end
                                local v189 = p16 == v183.Name
                                if not v189 then
                                    v189 = v176 == v183.Name:lower():gsub(" ", "")
                                end
                            until v189
                        until not g182
                        return v183
                    end
                    return nil
                end
                local Meshes = t13.value6:FindFirstChild("Meshes")
                if not Meshes then
                    return nil
                end
                local t16 = {
                    p16,
                    p16:gsub(" ", ""),
                    p16:gsub(" ", "_")
                }
                local _next = next
                local v193
                local v200
                repeat
                    local g194 = false
                    local v196
                    repeat
                        local v195
                        v193, v195 = _next(t16, v193)
                        if not v193 then
                            return nil
                        end
                        v196 = Meshes:FindFirstChild(v195)
                    until v196
                    local _next3 = next
                    local v198, v199 = v196:GetChildren()
                    repeat
                        v199, v200 = _next3(v198, v199)
                        if not v199 then
                            g194 = true
                        end
                        if g194 then
                            break
                        end
                    until v200:IsA("MeshPart")
                until not g194
                return v200
            end
            local cFrame = CFrame.new(-0.00207519531, 0.0318723917, 0.0401077271, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            local cFrame2 = CFrame.new(-0.00207519531, 0.0318723917, 0.0401077271, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            t13.value11 = {
                ["[Silencer]:Electric"] = cFrame,
                ["[Glock]:Electric"] = cFrame2
            }
            function t13.value12(p19, p20, p21)
                local v204 = p21
                if p21 then
                    v204 = p21.CFrame
                    if v204 then
                        v204 = typeof(p21.CFrame) == "CFrame"
                    end
                end
                if v204 then
                    return p21.CFrame
                end
                local v205 = t13.value11[p19.Name .. ":" .. p20]
                if not v205 then
                    v205 = CFrame.new()
                end
                return v205
            end
            local function v51(p22, p23, p24)
                local t17 = {}
                local t18 = {
                    Muzzle = true,
                    Aim = true
                }
                local _next = next
                local v212, v213 = p22:GetDescendants()
                while true do
                    local v214
                    v213, v214 = _next(v212, v213)
                    if not v213 then
                        break
                    end
                    if v214:IsA("BasePart") then
                        local v215 = p24
                        if p24 then
                            v215 = v214 == p24 or v214:IsDescendantOf(p24)
                        end
                        if not v215 and not t18[v214.Name] and (v214 == p23 or v214:IsDescendantOf(p23)) then
                            t17[v214] = v214.Transparency
                            v214.Transparency = 1
                        end
                    end
                end
                return t17
            end
            function t13.value13(p25, p26, p27)
                local clone = p26:Clone()
                clone.Anchored = false
                clone.CanCollide = false
                clone.Name = "\000"
                clone.CFrame = p25.CFrame
                local Weld = Instance.new("Weld")
                Weld.Part0 = clone
                Weld.Part1 = p25
                Weld.C0 = p27:Inverse()
                Weld.Name = "\000"
                Weld.Parent = clone
                p25.Transparency = 1
                clone.Parent = p25
                return clone
            end
            function t13.value14(p28, p29)
                if not p28 or p28.TextureID == nil then
                    return nil
                end
                local TextureID = p28.TextureID
                local v224 = typeof(TextureID) == "Instance"
                if v224 then
                    v224 = TextureID:IsA("MeshPart")
                end
                if v224 then
                    return TextureID
                end
                if not t13.value6 then
                    return nil
                end
                local Meshes = t13.value6:FindFirstChild("Meshes")
                if not Meshes then
                    return nil
                end
                local p29_2 = Meshes:FindFirstChild(p29)
                if not p29_2 then
                    p29_2 = Meshes:FindFirstChild(p29:gsub(" ", ""))
                    if not p29_2 then
                        local t19 = { p29:gsub(" ", "_") }
                        p29_2 = Meshes:FindFirstChild(v1(t19))
                        if not p29_2 then
                            local t20 = { p29:gsub("-", " ") }
                            p29_2 = Meshes:FindFirstChild(v1(t20))
                            if not p29_2 then
                                p29_2 = Meshes:FindFirstChild(p29:gsub("-", ""))
                            end
                        end
                    end
                end
                if not p29_2 then
                    return nil
                end
                local v229 = type(TextureID) == "string" and TextureID or TextureID.Name
                if v229 and v229 ~= "" then
                    local v230 = p29_2:FindFirstChild(v229)
                    local v231 = v230
                    if v230 then
                        v231 = v230:IsA("MeshPart")
                    end
                    if v231 then
                        return v230
                    end
                end
                return nil
            end
            function t13.value15(p30, p31)
                if not t13.value5 then
                    return nil
                end
                local GunShootSounds = t13.value5:FindFirstChild("GunShootSounds")
                if not GunShootSounds then
                    return nil
                end
                local p30_2 = GunShootSounds:FindFirstChild(p30)
                if not p30_2 then
                    return nil
                end
                local p31_2 = p30_2:FindFirstChild(p31)
                if not p31_2 then
                    local t21 = { p31:gsub("-", " ") }
                    p31_2 = p30_2:FindFirstChild(v1(t21))
                    if not p31_2 then
                        p31_2 = p30_2:FindFirstChild(p31:gsub("-", ""))
                    end
                end
                local v238 = p31_2
                if p31_2 then
                    v238 = p31_2:IsA("StringValue")
                end
                if v238 then
                    return p31_2.Value
                end
                return nil
            end
            local function v52(p32, p33, p34)
                local v242 = not t13.value5
                if not v242 then
                    v242 = not p32 or not p33
                end
                if v242 then
                    return
                end
                local v243 = t13.value2[p32]
                if not v243 then
                    return
                end
                local GunHandleParticle = t13.value5:FindFirstChild("GunHandleParticle")
                if not GunHandleParticle then
                    return
                end
                local p34_2 = GunHandleParticle:FindFirstChild(p34)
                if not p34_2 then
                    p34_2 = GunHandleParticle:FindFirstChild(p34:gsub("-", " "))
                    if not p34_2 then
                        p34_2 = GunHandleParticle:FindFirstChild(p34:gsub("-", ""))
                    end
                end
                if not p34_2 then
                    return
                end
                local ParticleEmitter = p34_2:FindFirstChildOfClass("ParticleEmitter")
                if not ParticleEmitter then
                    return
                end
                local clone = ParticleEmitter:Clone()
                clone.Parent = p33
                clone.Name = "\000"
                table.insert(v243.ClonedChildren, clone)
            end
            function t13.value16(p35)
                if not p35 or not t13.value2[p35] then
                    return
                end
                v46(p35)
                local v249 = t13.value2[p35]
                if v249.Connections then
                    local _next = next
                    local Connections = v249.Connections
                    local v252
                    while true do
                        local v253
                        v252, v253 = _next(Connections, v252)
                        if not v252 then
                            break
                        end
                        if v253 and v253.Connected then
                            v253:Disconnect()
                        end
                    end
                end
                local v254
                local _next = next
                local v256 = v249.ClonedChildren or {}
                while true do
                    local v257
                    v254, v257 = _next(v256, v254)
                    if not v254 then
                        break
                    end
                    if v257 and v257.Parent then
                        v257:Destroy()
                    end
                end
                if v249.HiddenParts then
                    local _next4 = next
                    local HiddenParts = v249.HiddenParts
                    local v260
                    while true do
                        local v261
                        v260, v261 = _next4(HiddenParts, v260)
                        if not v260 then
                            break
                        end
                        if v260 and v260.Parent then
                            v260.Transparency = v261
                        end
                    end
                end
                local Default = v249.Default
                if Default then
                    Default = v249.Default.Parent
                end
                if Default then
                    local _next5 = next
                    local v264, v265 = v249.Default:GetChildren()
                    while true do
                        local v266
                        v265, v266 = _next5(v264, v265)
                        if not v265 then
                            break
                        end
                        if v266.Name == "\000" then
                            v266:Destroy()
                        end
                    end
                    v249.Default.Transparency = v249.OriginalTransparency or 0
                    v249.Default.LocalTransparencyModifier = v249.OriginalLTM or 0
                    v249.Default.TextureID = v249.OriginalTextureID or ""
                end
                local _next6 = next
                local v268, v269 = p35:GetChildren()
                while true do
                    local v270
                    v269, v270 = _next6(v268, v269)
                    if not v269 then
                        break
                    end
                    if v270.Name == "\000" then
                        v270:Destroy()
                    end
                end
                if v249.OriginalGripCFrame then
                    _pcall(function()
                        p35.GripCFrame = v249.OriginalGripCFrame
                    end)
                end
                local ShootSound = v249.ShootSound
                if ShootSound then
                    ShootSound = v249.OriginalShootSoundId
                end
                if ShootSound then
                    v249.ShootSound.SoundId = v249.OriginalShootSoundId
                end
                local Handle = p35:FindFirstChild("Handle")
                if Handle then
                    Handle:SetAttribute("SkinName", v249.OriginalSkinName or "")
                    local GetChildren = Handle.GetChildren
                    local _next7 = next
                    local v275, v276 = GetChildren(Handle)
                    while true do
                        local v277
                        v276, v277 = _next7(v275, v276)
                        if not v276 then
                            break
                        end
                        if v277.Name == "\000" then
                            v277:Destroy()
                        end
                    end
                end
                t13.value2[p35] = nil
            end
            function t13.value17(p36, p37)
                if not p36 then
                    return
                end
                local v280 = t13.value2[p36]
                local g288
                local g303
                local g324
                local g367
                local g382
                local g396
                if v280 then
                    v280 = p37 == t13.value2[p36].SkinName
                end
                if v280 then
                    return
                end
                local Handle = p36:FindFirstChild("Handle")
                if not Handle then
                    return
                end
                local Default = p36:FindFirstChild("Default")
                local v283 = not Default
                if not v283 then
                    v283 = not Default:IsA("MeshPart")
                end
                if v283 then
                    Default = Handle:FindFirstChildOfClass("MeshPart")
                    if not Default then
                        local _next = next
                        local v285, v286 = p36:GetDescendants()
                        local v287
                        repeat
                            v286, v287 = _next(v285, v286)
                            if not v286 then
                                g288 = true
                            end
                            if g288 then
                                break
                            end
                        until v287:IsA("MeshPart")
                        if not g288 then
                            Default = v287
                        end
                    end
                end
                g288 = false
                if not Default then
                    local v289 = p36.Name:lower():find("knife") ~= nil
                    if not v289 then
                        v289 = p36.Name == "[Knife]"
                    end
                    if v289 then
                        if t13.value2[p36] then
                            t13.value16(p36)
                        end
                        local v290 = v48(p36.Name, p37)
                        local v291, v292 = _pcall(function()
                            return p36.GripCFrame
                        end)
                        local value2 = t13.value2
                        local v294 = Handle:GetAttribute("SkinName") or ""
                        local v295 = v291 and v292
                        if not v295 then
                            v295 = CFrame.new()
                        end
                        value2[p36] = {
                            SkinName = p37,
                            OriginalSkinName = v294,
                            OriginalGripCFrame = v295,
                            ClonedChildren = {},
                            Connections = {}
                        }
                        Handle:SetAttribute("SkinName", p37)
                        local connection = Handle:GetAttributeChangedSignal("SkinName"):Connect(function()
                            if Handle:GetAttribute("SkinName") ~= p37 then
                                Handle:SetAttribute("SkinName", p37)
                            end
                        end)
                        table.insert(t13.value2[p36].Connections, connection)
                        local v297 = v290
                        if v297 then
                            v297 = v290.CFrame
                            if v297 then
                                v297 = typeof(v290.CFrame) == "CFrame"
                            end
                        end
                        if v297 then
                            _pcall(function()
                                p36.GripCFrame = v290.CFrame
                            end)
                        end
                        return
                    end
                    return
                end
                local v298
                local _next = next
                local v300, v301 = p36:GetDescendants()
                local v302
                repeat
                    v301, v302 = _next(v300, v301)
                    if not v301 then
                        g303 = true
                    end
                    if g303 then
                        break
                    end
                    local v304 = v302:IsA("Sound")
                    if v304 then
                        v304 = v302.Name == "Shoot"
                        if not v304 then
                            v304 = v302.Name == "ShootSound"
                        end
                    end
                until v304
                if not g303 then
                    v298 = v302
                end
                g303 = false
                if t13.value2[p36] then
                    t13.value16(p36)
                end
                local value2 = t13.value2
                local TextureID = Default.TextureID
                local DefaultTransparency = Default.Transparency
                local v308 = Handle:GetAttribute("SkinName") or ""
                local v309 = Default
                local v310 = v298 and v298.SoundId or nil
                value2[p36] = {
                    SkinName = p37,
                    OriginalTextureID = TextureID,
                    OriginalTransparency = DefaultTransparency,
                    OriginalSkinName = v308,
                    Default = v309,
                    ShootSound = v298,
                    OriginalShootSoundId = v310,
                    ClonedChildren = {},
                    Connections = {},
                    HiddenParts = {}
                }
                Handle:SetAttribute("SkinName", p37)
                local connection = Handle:GetAttributeChangedSignal("SkinName"):Connect(function()
                    if Handle:GetAttribute("SkinName") ~= p37 then
                        Handle:SetAttribute("SkinName", p37)
                    end
                end)
                table.insert(t13.value2[p36].Connections, connection)
                local v312 = p36.Name:lower():find("knife") ~= nil
                if not v312 then
                    v312 = p36.Name == "[Knife]"
                end
                local v313 = p36.Name:lower():sub(2, -2)
                local v314 = v48(p36.Name, p37)
                local v315
                local v316 = not v312 and t13.value14(v314, p37) or nil
                if v312 then
                    if not v43(p37) then
                        v315 = t13.value10(p37, nil, true)
                    end
                elseif t13.value6 then
                    local Meshes = t13.value6:FindFirstChild("Meshes")
                    if Meshes then
                        local p37_2 = Meshes:FindFirstChild(p37)
                        if not p37_2 then
                            p37_2 = Meshes:FindFirstChild(p37:gsub(" ", ""))
                            if not p37_2 then
                                local t22 = { p37:gsub(" ", "_") }
                                p37_2 = Meshes:FindFirstChild(v1(t22))
                                if not p37_2 then
                                    p37_2 = Meshes:FindFirstChild(p37:gsub("-", " "))
                                    if not p37_2 then
                                        p37_2 = Meshes:FindFirstChild(p37:gsub("-", ""))
                                    end
                                end
                            end
                        end
                        if p37_2 then
                            v315 = if not p37_2:IsA("MeshPart") then p37_2:GetChildren() else p37_2
                        end
                    end
                end
                if not v316 and v315 then
                    local v320 = typeof(v315) == "Instance"
                    if v320 then
                        v320 = v315:IsA("MeshPart")
                    end
                    if v320 then
                        v316 = v315
                    elseif type(v315) == "table" then
                        local _next8 = next
                        local v322
                        local v323
                        repeat
                            repeat
                                v322, v323 = _next8(v315, v322)
                                if not v322 then
                                    g324 = true
                                end
                                if g324 then
                                    break
                                end
                                local v325 = typeof(v323) == "Instance"
                                if v325 then
                                    v325 = v323:IsA("MeshPart")
                                end
                            until v325
                            if g324 then
                                break
                            end
                            if v323.Name == p36.Name then
                                v316 = v323
                                g324 = true
                            end
                            if g324 then
                                break
                            end
                            local v326 = v323.Name:lower()
                            if v326:find("rpg") and v313 == "rpg" then
                                v316 = v323
                                g324 = true
                            end
                            if g324 then
                                break
                            end
                            if v326:find("aug") and v313 == "aug" then
                                v316 = v323
                                g324 = true
                            end
                            if g324 then
                                break
                            end
                            if v326:find("tac") and v313 == "tacticalshotgun" then
                                v316 = v323
                                g324 = true
                            end
                            if g324 then
                                break
                            end
                            if v326:find("rev") and v313 == "revolver" then
                                v316 = v323
                                g324 = true
                            end
                            if g324 then
                                break
                            end
                            local v327 = v326:find("db")
                            if not v327 then
                                v327 = v326:find("double")
                            end
                            if v327 then
                                v327 = v313 == "double-barrel sg" or v313 == "double-barrelsg"
                            end
                            if v327 then
                                v316 = v323
                                g324 = true
                            end
                            if g324 then
                                break
                            end
                            if v326:find("knife") and v312 then
                                v316 = v323
                                g324 = true
                            end
                            if g324 then
                                break
                            end
                            if v326:find("rifle") and v313 == "rifle" then
                                v316 = v323
                                g324 = true
                            end
                            if g324 then
                                break
                            end
                            if v326:find("flame") and v313 == "flamethrower" then
                                v316 = v323
                                g324 = true
                            end
                            if g324 then
                                break
                            end
                            if v326:find("drum") and v313 == "drumgun" then
                                v316 = v323
                                g324 = true
                            end
                            if g324 then
                                break
                            end
                            if v326:find("ak") and v313 == "ak47" then
                                v316 = v323
                                g324 = true
                            end
                            if g324 then
                                break
                            end
                            if v326:find("smg") and v313 == "smg" then
                                v316 = v323
                                g324 = true
                            end
                            if g324 then
                                break
                            end
                            if v326:find("lmg") and v313 == "lmg" then
                                v316 = v323
                                g324 = true
                            end
                            if g324 then
                                break
                            end
                            if v326:find("p90") and v313 == "p90" then
                                v316 = v323
                                g324 = true
                            end
                            if g324 then
                                break
                            end
                            if v326 == "ar" and v313 == "ar" then
                                v316 = v323
                                g324 = true
                            end
                            if g324 then
                                break
                            end
                            local v328 = v313 == "silencerar"
                            if v328 then
                                v328 = v326:find("silencerar") or v326:find("silencedar")
                            end
                            if v328 then
                                v316 = v323
                                g324 = true
                            end
                            if g324 then
                                break
                            end
                            local v329 = v313 == "silencer"
                            if v329 then
                                v329 = v326:find("silencer")
                                if v329 then
                                    v329 = not v326:find("silencerar")
                                    if v329 then
                                        v329 = not v326:find("silencedar")
                                    end
                                end
                            end
                            if v329 then
                                v316 = v323
                                g324 = true
                            end
                            if g324 then
                                break
                            end
                            local v330 = v313 == "silencer"
                            if v330 then
                                v330 = v326:find("supp") or v326 == "sil"
                            end
                            if v330 then
                                v316 = v323
                                g324 = true
                            end
                            if g324 then
                                break
                            end
                            local v331 = v313 == "silencer"
                            if v331 then
                                v331 = v326:find("glock")
                            end
                            if v331 then
                                v316 = v323
                                g324 = true
                            end
                            if g324 then
                                break
                            end
                            if v326:find("glock") and v313 == "glock" then
                                v316 = v323
                                g324 = true
                            end
                            if g324 then
                                break
                            end
                        until v326:find("deagle") and v313 == "deagle"
                        if not g324 then
                            if not g324 then
                                if not g324 then
                                    if not g324 then
                                        if not g324 then
                                            if not g324 then
                                                if not g324 then
                                                    if not g324 then
                                                        if not g324 then
                                                            if not g324 then
                                                                if not g324 then
                                                                    if not g324 then
                                                                        if not g324 then
                                                                            if not g324 then
                                                                                if not g324 then
                                                                                    if not g324 then
                                                                                        if not g324 then
                                                                                            if not g324 then
                                                                                                if not g324 then
                                                                                                    if not g324 then
                                                                                                        if not g324 then
                                                                                                            v316 = v323
                                                                                                        end
                                                                                                    end
                                                                                                end
                                                                                            end
                                                                                        end
                                                                                    end
                                                                                end
                                                                            end
                                                                        end
                                                                    end
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                        g324 = false
                        if not v316 then
                            v316 = t13.value10(p37, p36.Name, false)
                            if not v316 then
                                v316 = t13.value10(p37, v313, false)
                                if not v316 then
                                    v316 = t13.value10(p37, "[" .. v313 .. "]", false)
                                end
                            end
                        end
                        if not v316 then
                            local v332 = v313:gsub("[^%w]", "")
                            local t23 = {}
                            local _next9 = next
                            local v335
                            while true do
                                local v336
                                v335, v336 = _next9(v315, v335)
                                if not v335 then
                                    break
                                end
                                local v337 = typeof(v336) == "Instance"
                                if v337 then
                                    v337 = v336:IsA("MeshPart")
                                end
                                if v337 then
                                    local v338 = v336.Name:lower():gsub("[^%w]", "")
                                    if v338 == v332 or v338:find(v332, 1, true) then
                                        table.insert(t23, v336)
                                    end
                                end
                            end
                            if #t23 == 1 then
                                v316 = t23[1]
                            elseif #t23 > 1 then
                                v316 = t23[1]
                            end
                        end
                    end
                end
                if not v316 and not v312 then
                    v316 = t13.value10(p37, p36.Name, false)
                    if not v316 then
                        v316 = t13.value10(p37, v313, false)
                        if not v316 then
                            v316 = t13.value10(p37, "[" .. v313 .. "]", false)
                        end
                    end
                end
                if v316 then
                    local v339 = t13.value12(p36, p37, v314)
                    local v340 = t13.value13(Default, v316, v339)
                    t13.value2[p36].HiddenParts = v51(p36, Default, v340)
                    table.insert(t13.value2[p36].ClonedChildren, v340)
                else
                    local v341 = v314
                    if v341 then
                        v341 = v314.TextureID
                    end
                    if v341 then
                        local TextureID2 = v314.TextureID
                        local v343 = typeof(TextureID2) == "Instance"
                        if v343 then
                            v343 = TextureID2:IsA("MeshPart")
                        end
                        if v343 then
                            local v344 = t13.value12(p36, p37, v314)
                            local v345 = t13.value13(Default, TextureID2, v344)
                            t13.value2[p36].HiddenParts = v51(p36, Default, v345)
                            table.insert(t13.value2[p36].ClonedChildren, v345)
                        elseif type(TextureID2) == "string" then
                            local v346 = t13.value2[p36]
                            v346.HiddenParts = v51(p36, Default, nil)
                            Default.TextureID = TextureID2
                            Default.Transparency = 0
                        end
                    else
                        if not v312 then
                            t13.value16(p36)
                            return
                        end
                        if v43(p37) then
                            return
                        end
                        t13.value2[p36].OriginalLTM = Default.LocalTransparencyModifier
                        Default.LocalTransparencyModifier = 1
                        local v348 = v314
                        if v348 then
                            v348 = v314.CFrame
                            if v348 then
                                v348 = typeof(v314.CFrame) == "CFrame"
                            end
                        end
                        if v348 then
                            local v349, v350 = _pcall(function()
                                return p36.GripCFrame
                            end)
                            local v351 = t13.value2[p36]
                            local v352 = v349 and v350
                            if not v352 then
                                v352 = CFrame.new()
                            end
                            v351.OriginalGripCFrame = v352
                            _pcall(function()
                                p36.GripCFrame = v314.CFrame
                            end)
                        end
                        if p37:lower():gsub("[%-%s]", ""):find("galactic") then
                            local v353 = v314
                            if v353 then
                                v353 = v314.CFrame
                                if v353 then
                                    v353 = typeof(v314.CFrame) == "CFrame"
                                end
                            end
                            if v353 then
                                v353 = v314.CFrame
                            end
                            if not v353 then
                                v353 = CFrame.new(-0.261539459, 0.0143127441, 0.0307006836, 0, 1, 0, 0, 0, 1, 1, 0, 0)
                            end
                            local v354 = v353
                            local MeshPart = Instance.new("MeshPart")
                            MeshPart.Name = "Cylinder.005"
                            MeshPart:SetAttribute("_skinclone", true)
                            MeshPart.MeshId = "rbxassetid://13631448149"
                            MeshPart.TextureID = "rbxassetid://13631435304"
                            MeshPart.Size = Vector3.new(0.41470247507095, 1.676903963089, 0.41470256447792)
                            MeshPart.Material = Enum.Material.SmoothPlastic
                            MeshPart.Color = Color3.fromRGB(163, 162, 165)
                            MeshPart.Transparency = 0
                            MeshPart.CanCollide = false
                            MeshPart.Anchored = true
                            MeshPart.Massless = true
                            MeshPart.CFrame = Default.CFrame * v354 * CFrame.new(0, 0.0946066007, 0)
                            MeshPart.Parent = p36
                            table.insert(t13.value2[p36].ClonedChildren, MeshPart)
                            local MeshPart2 = Instance.new("MeshPart")
                            MeshPart2.Name = "Cylinder.006"
                            MeshPart2:SetAttribute("_skinclone", true)
                            MeshPart2.MeshId = "rbxassetid://13631448150"
                            MeshPart2.TextureID = ""
                            MeshPart2.Size = Vector3.new(0.22626356780529, 3.3346450328827, 0.22626411914825)
                            MeshPart2.Material = Enum.Material.Neon
                            MeshPart2.Color = Color3.fromRGB(218, 134, 122)
                            MeshPart2.Transparency = 0
                            MeshPart2.CanCollide = false
                            MeshPart2.Anchored = true
                            MeshPart2.Massless = true
                            MeshPart2.CFrame = Default.CFrame * v354 * CFrame.new(0, 2.31074929, 0)
                            MeshPart2.Parent = p36
                            table.insert(t13.value2[p36].ClonedChildren, MeshPart2)
                            local connection2 = RunService.Heartbeat:Connect(function()
                                local v470 = not Default.Parent
                                if not v470 then
                                    v470 = not MeshPart2.Parent
                                end
                                if v470 then
                                    return
                                end
                                local v471 = Default.CFrame * v354
                                MeshPart.CFrame = v471 * CFrame.new(0, 0.0946066007, 0)
                                MeshPart2.CFrame = v471 * CFrame.new(0, 2.31074929, 0)
                            end)
                            table.insert(t13.value2[p36].Connections, connection2)
                        end
                    end
                end
                local _next10 = next
                local v359, v360 = Handle:GetChildren()
                while true do
                    local v361
                    v360, v361 = _next10(v359, v360)
                    if not v360 then
                        break
                    end
                    if #v361.Name == 0 then
                        v361:Destroy()
                    end
                end
                v52(p36, Handle, p37)
                if v312 and t13.value5 then
                    local SkinScripts = t13.value5:FindFirstChild("SkinScripts")
                    if SkinScripts then
                        local _next11 = next
                        local v364, v365 = SkinScripts:GetChildren()
                        local v366
                        repeat
                            v365, v366 = _next11(v364, v365)
                            if not v365 then
                                g367 = true
                            end
                            if g367 then
                                break
                            end
                        until v366.Name:lower():gsub(" ", "") == p37:lower():gsub(" ", "")
                        if not g367 then
                            local Sound = v366:FindFirstChildOfClass("Sound")
                            if Sound then
                                local clone = Sound:Clone()
                                clone.Name = "\000"
                                clone.Parent = Handle
                                clone:Play()
                                game.Debris:AddItem(clone, 3)
                            end
                            local _next12 = next
                            local v371, v372 = v366:GetDescendants()
                            while true do
                                local v373
                                v372, v373 = _next12(v371, v372)
                                if not v372 then
                                    break
                                end
                                if v373:IsA("Sound") or v373:IsA("StringValue") then
                                    local v374 = v373.Name:lower():gsub(" ", "")
                                    local v375 = v373:IsA("Sound") and v373.SoundId or v373.Value
                                    if not (not v375 or v375 == "") then
                                        local v376 = v374 == "equipsfx"
                                        if not v376 then
                                            v376 = v374 == "sfx"
                                            if not v376 then
                                                v376 = v374 == "equip" or v374 == "tantoequip"
                                            end
                                        end
                                        if v376 then
                                            t13.value2[p36].KnifeEquipSound = v375
                                        elseif v374 == "attacksfx" or v374 == "attack" then
                                            t13.value2[p36].KnifeAttackSound = v375
                                        end
                                    end
                                end
                            end
                        end
                    end
                    g367 = false
                    local SkinScriptsStorage = t13.value5:FindFirstChild("SkinScriptsStorage")
                    if SkinScriptsStorage then
                        local _next13 = next
                        local v379, v380 = SkinScriptsStorage:GetChildren()
                        local v381
                        repeat
                            v380, v381 = _next13(v379, v380)
                            if not v380 then
                                g382 = true
                            end
                            if g382 then
                                break
                            end
                        until v381.Name:lower():gsub(" ", "") == p37:lower():gsub(" ", "")
                        if not g382 then
                            local GetDescendants = v381.GetDescendants
                            local _next14 = next
                            local v385, v386 = GetDescendants(v381)
                            local v387
                            repeat
                                repeat
                                    v386, v387 = _next14(v385, v386)
                                    if not v386 then
                                        g382 = true
                                    end
                                    if g382 then
                                        break
                                    end
                                until v387:IsA("Animation")
                                if g382 then
                                    break
                                end
                                local v388 = v387.Name:lower():gsub(" ", "")
                                local v389 = v388 == "knife"
                                if not v389 then
                                    v389 = v388 == "equipknife"
                                    if not v389 then
                                        v389 = v388 == "knifeequip" or v388 == "tantoequip"
                                    end
                                end
                            until v389
                            if not g382 then
                                t13.value2[p36].KnifeEquipAnim = v387
                            end
                        end
                    end
                    g382 = false
                    local KnifeSkinAnimation = t13.value5:FindFirstChild("KnifeSkinAnimation")
                    if KnifeSkinAnimation then
                        local GetChildren = KnifeSkinAnimation.GetChildren
                        local _next15 = next
                        local v393, v394 = GetChildren(KnifeSkinAnimation)
                        local v395
                        repeat
                            v394, v395 = _next15(v393, v394)
                            if not v394 then
                                g396 = true
                            end
                            if g396 then
                                break
                            end
                        until v395.Name:lower():gsub(" ", "") == p37:lower():gsub(" ", "")
                        if not g396 then
                            local GetDescendants = v395.GetDescendants
                            local _next16 = next
                            local v399, v400 = GetDescendants(v395)
                            local v401
                            repeat
                                v400, v401 = _next16(v399, v400)
                                if not v400 then
                                    g396 = true
                                end
                                if g396 then
                                    break
                                end
                            until v401:IsA("Animation")
                            if not g396 then
                                t13.value2[p36].KnifeAttackAnim = v401
                            end
                        end
                    end
                end
                g396 = false
                local v402 = v312
                if v312 then
                    v402 = p37:lower():gsub(" ", "") == "goldenagetanto"
                end
                if v402 then
                    if not t13.value2[p36].KnifeEquipAnim then
                        local Animation = Instance.new("Animation")
                        Animation.AnimationId = "rbxassetid://13473404819"
                        t13.value2[p36].KnifeEquipAnim = Animation
                    else
                        t13.value2[p36].KnifeEquipAnim.AnimationId = "rbxassetid://13473404819"
                    end
                end
                if v312 then
                    v312 = p37:lower():gsub(" ", "") == "gpoknife"
                    if not v312 then
                        v312 = p37:lower():gsub(" ", "") == "gpoknifeprestige"
                    end
                end
                if v312 then
                    if not t13.value2[p36].KnifeEquipAnim then
                        local Animation = Instance.new("Animation")
                        Animation.AnimationId = "rbxassetid://102007904524177"
                        t13.value2[p36].KnifeEquipAnim = Animation
                    else
                        t13.value2[p36].KnifeEquipAnim.AnimationId = "rbxassetid://102007904524177"
                    end
                end
                local v405 = t13.value15(p36.Name, p37)
                local v406 = v405
                if v405 then
                    v406 = t13.value2[p36].ShootSound
                end
                if v406 then
                    t13.value2[p36].ShootSound.SoundId = v405
                end
            end
            local function v53(p38)
                local v408 = t13.value1()
                if not v408.Enabled then
                    return nil
                end
                local Skins = v408.Skins
                local v410 = Skins[p38.Name] or Skins["[" .. p38.Name:gsub("%[", ""):gsub("%]", "") .. "]"]
                local v411 = not v410
                if not v411 then
                    v411 = v410 == ""
                    if not v411 then
                        v411 = v410 == "None" or v410 == "Default"
                    end
                end
                if v411 then
                    return nil
                end
                return v410
            end
            function t13.value18(p39)
                local v413 = v53(p39)
                local v414 = t13.value2[p39]
                if v413 == (v414 and v414.SkinName or nil) then
                    return
                end
                if v414 then
                    t13.value16(p39)
                end
                if not v413 then
                    t13.value4[p39] = nil
                    return
                end
                t13.value4[p39] = v413
                local v415 = p39.Name:lower():find("knife") ~= nil
                if not v415 then
                    v415 = p39.Name == "[Knife]"
                end
                if v415 and v43(v413) then
                    if t13.value2[p39] then
                        t13.value16(p39)
                    end
                    local Handle = p39:FindFirstChild("Handle")
                    if not Handle then
                        return
                    end
                    local value2 = t13.value2
                    local v418 = Handle:GetAttribute("SkinName") or ""
                    value2[p39] = {
                        SkinName = v413,
                        OriginalSkinName = v418,
                        ClonedChildren = {},
                        Connections = {}
                    }
                    Handle:SetAttribute("SkinName", v413)
                    local connection = Handle:GetAttributeChangedSignal("SkinName"):Connect(function()
                        if Handle:GetAttribute("SkinName") ~= v413 then
                            Handle:SetAttribute("SkinName", v413)
                        end
                    end)
                    table.insert(t13.value2[p39].Connections, connection)
                    v52(p39, Handle, v413)
                    local v420 = not t13.value3[p39]
                    if not v420 then
                        v420 = not t13.value3[p39].hiddenParts
                    end
                    if v420 then
                        t13.value3[p39] = t13.value3[p39] or {}
                        t13.value3[p39].hiddenParts = v44(p39, nil)
                    end
                    local connection3 = p39.Equipped:Connect(function()
                        if not t13.value2[p39] then
                            EquipConn:Disconnect()
                            return
                        end
                        local p39Parent = p39.Parent
                        if p39Parent ~= LocalPlayer.Character then
                            return
                        end
                        t13.value8(p39Parent, p39, v413)
                    end)
                    if not t13.value2[p39].Connections then
                        t13.value2[p39].Connections = {}
                    end
                    table.insert(t13.value2[p39].Connections, connection3)
                    local Character = LocalPlayer.Character
                    if Character then
                        Character = p39.Parent == LocalPlayer.Character
                    end
                    if Character then
                        t13.value8(LocalPlayer.Character, p39, v413)
                    end
                    local v423 = t13.value2[p39]
                    if v423 then
                        v423 = t13.value2[p39].KnifeAttackAnim
                        if not v423 then
                            v423 = t13.value2[p39].KnifeAttackSound
                        end
                    end
                    if v423 then
                        local connection4 = p39.Activated:Connect(function()
                            local v473 = t13.value2[p39]
                            if not v473 then
                                AttackConn:Disconnect()
                                return
                            end
                            if v473.KnifeAttackSound then
                                local Sound = Instance.new("Sound")
                                Sound.SoundId = v473.KnifeAttackSound
                                Sound.Volume = 1
                                Sound.Parent = p39:FindFirstChild("Handle") or p39
                                Sound:Play()
                                game.Debris:AddItem(Sound, 3)
                            end
                            if v473.KnifeAttackAnim then
                                local Character2 = LocalPlayer.Character
                                if Character2 then
                                    local Humanoid = Character2:FindFirstChildOfClass("Humanoid")
                                    if Humanoid then
                                        local Animator = Humanoid:FindFirstChildOfClass("Animator")
                                        if not Animator then
                                            Animator = Instance.new("Animator")
                                            Animator.Parent = Humanoid
                                        end
                                        local Animation = Instance.new("Animation")
                                        Animation.AnimationId = v473.KnifeAttackAnim.AnimationId
                                        local track = Animator:LoadAnimation(Animation)
                                        track.Priority = Enum.AnimationPriority.Action
                                        track:Play()
                                        Animation:Destroy()
                                    end
                                end
                            end
                        end)
                        table.insert(t13.value2[p39].Connections, connection4)
                        return
                    end
                else
                    t13.value17(p39, v413)
                    if not t13.value2[p39] then
                        return
                    end
                    local connection = p39.Equipped:Connect(function()
                        if not t13.value2[p39] then
                            EquipConn:Disconnect()
                            return
                        end
                        if p39.Parent ~= LocalPlayer.Character then
                            return
                        end
                        t13.value17(p39, v413)
                    end)
                    if not t13.value2[p39].Connections then
                        t13.value2[p39].Connections = {}
                    end
                    table.insert(t13.value2[p39].Connections, connection)
                    local Character = LocalPlayer.Character
                    if Character then
                        Character = p39.Parent == LocalPlayer.Character
                    end
                    if Character then
                        t13.value17(p39, v413)
                    end
                end
            end
            local function v54(p40)
                if not p40 then
                    return
                end
                local GetChildren = p40.GetChildren
                local _next = next
                local v430, v431 = GetChildren(p40)
                while true do
                    local v432
                    v431, v432 = _next(v430, v431)
                    if not v431 then
                        break
                    end
                    if v432:IsA("Tool") then
                        t13.value18(v432)
                    end
                end
                p40.ChildAdded:Connect(function(child)
                    if child:IsA("Tool") then
                        wait(0.1)
                        t13.value18(child)
                    end
                end)
            end
            local function v55(p41)
                if not p41 then
                    return
                end
                local _next = next
                local v435, v436 = p41:GetChildren()
                while true do
                    local v437
                    v436, v437 = _next(v435, v436)
                    if not v436 then
                        break
                    end
                    if v437:IsA("Tool") then
                        t13.value18(v437)
                    end
                end
                p41.ChildAdded:Connect(function(child)
                    if child:IsA("Tool") then
                        wait(0.1)
                        t13.value18(child)
                    end
                end)
            end
            v47()
            local Character = LocalPlayer.Character
            if not Character then
                Character = LocalPlayer.CharacterAdded:Wait()
            end
            local Backpack = LocalPlayer:WaitForChild("Backpack", 5)
            v54(Character)
            if Backpack then
                v55(Backpack)
            end
            LocalPlayer.CharacterAdded:Connect(function(character)
                wait(0.5)
                v54(character)
                local Backpack2 = LocalPlayer:WaitForChild("Backpack", 5)
                if Backpack2 then
                    v55(Backpack2)
                end
            end)
            function t13.value19()
                local Character3 = LocalPlayer.Character
                if Character3 then
                    local _next = next
                    local v442, v443 = Character3:GetChildren()
                    while true do
                        local v444
                        v443, v444 = _next(v442, v443)
                        if not v443 then
                            break
                        end
                        if v444:IsA("Tool") then
                            t13.value18(v444)
                        end
                    end
                end
                local Backpack3 = LocalPlayer:FindFirstChildOfClass("Backpack")
                if Backpack3 then
                    local GetChildren = Backpack3.GetChildren
                    local _next = next
                    local v448, v449 = GetChildren(Backpack3)
                    while true do
                        local v450
                        v449, v450 = _next(v448, v449)
                        if not v449 then
                            break
                        end
                        if v450:IsA("Tool") then
                            t13.value18(v450)
                        end
                    end
                end
                local v451
                local _next = next
                local value4 = t13.value4
                while true do
                    v451 = _next(value4, v451)
                    if not v451 then
                        break
                    end
                    if not v451.Parent then
                        t13.value4[v451] = nil
                    end
                end
            end
            t13.value20 = ""
            RunService.Heartbeat:Connect(function()
                local v454 = t13.value1()
                local str = tostring(v454.Enabled)
                local Skins = v454.Skins
                if Skins then
                    local _next = next
                    local v458
                    while true do
                        local v459
                        v458, v459 = _next(Skins, v458)
                        if not v458 then
                            break
                        end
                        str ..= v458 .. tostring(v459)
                    end
                end
                if str ~= t13.value20 then
                    t13.value19()
                end
            end)
        end)()
    end
    -- ============================================================
    -- END INLINED SKIN CHANGER
    -- ============================================================
    skinLoaderLoaded = true
end)
--==================================================
-- SKIN LISTS FOR DROPDOWNS
--==================================================

local defaultGunSkins = {
    "Default",
    "Valentine",
    "Galaxy",
    "Luck",
    "Inferno",
    "Red Hot",
    "Christmas Wrap",
    "Electric",
    "Golden",
    "Shadow"
}

local doubleRevolverSkins = {
    "Default",
    "Valentine",
    "Galaxy",
    "Luck",
    "Inferno",
    "Red Hot",
    "Christmas Wrap",
    "Golden Age",
    "Electric",
    "Golden",
    "Shadow"
}

local knifeSkins = {
    "Default",
    "Golden",
    "Golden Age Tanto",
    "GPO-Knife",
    "GPO-Knife Prestige",
    "Heaven",
    "Love Kukri",
    "Purple Dagger",
    "Blue Dagger",
    "Green Dagger",
    "Red Dagger",
    "Portal",
    "Emerald Butterfly",
    "Boy",
    "Girl",
    "Dragon",
    "Void",
    "Wild West",
    "Iced Out",
    "Reptile",
    "Emerald",
    "Ribbon"
}

local weaponConfigs = {
    ['[Double-Barrel SG]'] = { name = "Double-Barrel SG", skins = doubleRevolverSkins },
    ['[Revolver]'] = { name = "Revolver", skins = doubleRevolverSkins },
    ['[TacticalShotgun]'] = { name = "TacticalShotgun", skins = defaultGunSkins },
    ['[Shotgun]'] = { name = "Shotgun", skins = defaultGunSkins },
    ['[SilencerAR]'] = { name = "SilencerAR", skins = defaultGunSkins },
    ['[Silencer]'] = { name = "Silencer", skins = defaultGunSkins },
    ['[Glock]'] = { name = "Glock", skins = defaultGunSkins },
    ['[AR]'] = { name = "AR", skins = defaultGunSkins },
    ['[AK47]'] = { name = "AK47", skins = defaultGunSkins },
    ['[SMG]'] = { name = "SMG", skins = defaultGunSkins },
    ['[P90]'] = { name = "P90", skins = defaultGunSkins },
    ['[LMG]'] = { name = "LMG", skins = defaultGunSkins },
    ['[DrumGun]'] = { name = "DrumGun", skins = defaultGunSkins },
    ['[AUG]'] = { name = "AUG", skins = defaultGunSkins },
    ['[Rifle]'] = { name = "Rifle", skins = defaultGunSkins },
    ['[Drum-Shotgun]'] = { name = "Drum-Shotgun", skins = defaultGunSkins },
    ['[Deagle]'] = { name = "Deagle", skins = defaultGunSkins },
    ['[Flintlock]'] = { name = "Flintlock", skins = defaultGunSkins },
    ['[Knife]'] = { name = "Knife", skins = knifeSkins }
}

--==================================================
-- TIME CHANGER VARIABLES
--==================================================

local _timeOverride = false
local _timeTarget = Lighting.ClockTime

--==================================================
-- ORIGINAL MELS VARIABLES
--==================================================

local _silent = true
local _fov = 1000
local _spread = 100
local _exclude = false
local _wall = false
local _knock = false
local _aimPart = "Head"
local _menuKey = "F6"
local _uiVisible = true

local _camlock = false
local _camPart = "Head"
local _camSmooth = 0.3
local _camMode = "Always"
local _camBind = "C"
local _camActive = false

local _teleport = false
local _teleBind = "T"
local _teleActive = false

local _esp = false
local _espBind = "P"
local _espActive = false
local _espBox = false
local _espName = false
local _espColor = Color3.fromRGB(145, 100, 220)

local _speed = false
local _jump = false
local _speedVal = 50
local _jumpVal = 100
local _speedActive = false
local _jumpActive = false
local _speedBind = "X"
local _jumpBind = "Z"

local _headSize = 1
local _hitTrans = 0.7
local _hitColor = Color3.fromRGB(145, 100, 220)
local _headless = false
local _korblox = false
local _hitbox = false

local _fogColor = Color3.fromRGB(200, 195, 215)
local _fogIntensity = 500

--==================================================
-- ORIGINAL FUNCTIONS
--==================================================

local function _checkKnock(char)
    if not _knock then return false end
    local effects = char:FindFirstChild("Bodyeffects") or char:FindFirstChild("BodyEffects")
    if not effects then return false end
    local ko = effects:FindFirstChild("K.O") or effects:FindFirstChild("KO")
    local dead = effects:FindFirstChild("Dead")
    if ko and ko.Value == true then return true end
    if dead and dead.Value == true then return true end
    return false
end

local function _getPart(char)
    local closest = nil
    local shortest = math.huge
    local mpos = Vector2.new(mouse.X, mouse.Y)
    local parts = {"Head", "HumanoidRootPart", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot", "RightUpperLeg", "RightLowerLeg", "RightFoot", "LeftUpperArm", "LeftLowerArm", "LeftHand", "RightUpperArm", "RightLowerArm", "RightHand"}
    for _, pName in pairs(parts) do
        local p = char:FindFirstChild(pName)
        if p then
            local pos, on = camera:WorldToScreenPoint(p.Position)
            if on then
                local dist = (Vector2.new(pos.X, pos.Y) - mpos).Magnitude
                if dist < shortest then
                    shortest = dist
                    closest = p
                end
            end
        end
    end
    return closest or char:FindFirstChild("Head")
end

local function _getTarget()
    if not _silent then return nil end
    local mpos = Vector2.new(mouse.X, mouse.Y)
    local best = nil
    local bestDist = _fov
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= Player and not _isWhitelisted(v) and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            if not _checkKnock(v.Character) then
                local part
                if _aimPart == "Closest Part" then
                    part = _getPart(v.Character)
                elseif _aimPart == "Body" then
                    part = v.Character:FindFirstChild("HumanoidRootPart")
                elseif _aimPart == "Left Leg" then
                    part = v.Character:FindFirstChild("LeftUpperLeg") or v.Character:FindFirstChild("LeftLeg")
                elseif _aimPart == "Right Leg" then
                    part = v.Character:FindFirstChild("RightUpperLeg") or v.Character:FindFirstChild("RightLeg")
                elseif _aimPart == "Left Arm" then
                    part = v.Character:FindFirstChild("LeftUpperArm") or v.Character:FindFirstChild("LeftArm")
                elseif _aimPart == "Right Arm" then
                    part = v.Character:FindFirstChild("RightUpperArm") or v.Character:FindFirstChild("RightArm")
                else
                    part = v.Character:FindFirstChild("Head")
                end
                if part then
                    local pos, on = camera:WorldToScreenPoint(part.Position)
                    if on then
                        local vec = Vector2.new(pos.X, pos.Y)
                        local dist = (vec - mpos).Magnitude
                        if dist < bestDist then
                            if _wall then
                                local ray = Ray.new(camera.CFrame.Position, (part.Position - camera.CFrame.Position).Unit * 500)
                                local hit = workspace:FindPartOnRayWithIgnoreList(ray, {Player.Character, camera})
                                if hit and hit:IsDescendantOf(v.Character) then
                                    bestDist = dist
                                    best = part
                                end
                            else
                                bestDist = dist
                                best = part
                            end
                        end
                    end
                end
            end
        end
    end
    return best
end

local function _getCamTarget()
    local closest = nil
    local closestDist = math.huge
    local vp = camera.ViewportSize
    local center = Vector2.new(vp.X/2, vp.Y/2)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Player and not _isWhitelisted(p) and p.Character then
            local hum = p.Character:FindFirstChild("Humanoid")
            if hum and hum.Health > 0 then
                local part = nil
                if _camPart == "Head" then
                    part = p.Character:FindFirstChild("Head")
                elseif _camPart == "Body" then
                    part = p.Character:FindFirstChild("HumanoidRootPart")
                elseif _camPart == "Closest Part" then
                    part = _getPart(p.Character)
                end
                if part then
                    local pos, on = camera:WorldToViewportPoint(part.Position)
                    if on then
                        local p2 = Vector2.new(pos.X, pos.Y)
                        local dist = (p2 - center).Magnitude
                        if dist < closestDist then
                            closest = part
                            closestDist = dist
                        end
                    end
                end
            end
        end
    end
    return closest
end

local _gh, _old
local _ok, _res = pcall(function()
    return require(game:GetService("ReplicatedStorage").Modules.GunHandler)
end)
if _ok then
    _gh = _res
    _old = _gh.getAim
    _gh.getAim = function(origin, maxDist)
        if _exclude then
            local tool = Player.Character and Player.Character:FindFirstChildOfClass("Tool")
            if tool and (tool.Name == "[Revolver]" or tool.Name == "Revolver") then
                return _old(origin, maxDist)
            end
        end
        if _silent then
            local target = _getTarget()
            if target then
                local dir = (target.Position - origin).Unit
                local dist = (target.Position - origin).Magnitude
                return dir, math.min(dist, maxDist or 200)
            end
        end
        return _old(origin, maxDist)
    end
end

local _spreadLib
pcall(function()
    local gunHandlerScript = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("GunHandler")
    _spreadLib = require(gunHandlerScript:WaitForChild("Spread"))
end)

if _spreadLib and type(_spreadLib.roll) == "function" then
    local _originalRoll = _spreadLib.roll
    local function _scaleVec(v)
        if typeof(v) ~= "Vector3" then return v end
        return v * (_spread / 100)
    end
    _spreadLib.roll = function(...)
        if type(checkcaller) == "function" and checkcaller() then
            return _originalRoll(...)
        end
        local result = _originalRoll(...)
        if typeof(result) == "table" then
            local scaled = table.create(#result)
            for i = 1, #result do
                scaled[i] = _scaleVec(result[i])
            end
            return scaled
        end
        return _scaleVec(result)
    end
end

--==================================================
-- THEMES
--==================================================

local _themes = {
    Pink = {
        Main = Color3.fromRGB(255, 230, 240),
        Sidebar = Color3.fromRGB(255, 190, 215),
        Content = Color3.fromRGB(255, 245, 250),
        Panel = Color3.fromRGB(255, 235, 245),
        Accent = Color3.fromRGB(255, 130, 180),
        AccentLight = Color3.fromRGB(255, 220, 235),
        Text = Color3.fromRGB(255, 110, 165),
        Stroke = Color3.fromRGB(255, 150, 190),
        DarkText = Color3.fromRGB(200, 80, 130)
    },
    Purple = {
        Main = Color3.fromRGB(235, 220, 255),
        Sidebar = Color3.fromRGB(190, 160, 235),
        Content = Color3.fromRGB(248, 243, 255),
        Panel = Color3.fromRGB(230, 215, 250),
        Accent = Color3.fromRGB(145, 100, 220),
        AccentLight = Color3.fromRGB(220, 200, 250),
        Text = Color3.fromRGB(120, 75, 190),
        Stroke = Color3.fromRGB(170, 125, 225),
        DarkText = Color3.fromRGB(90, 50, 150)
    },
    Yellow = {
        Main = Color3.fromRGB(255, 245, 190),
        Sidebar = Color3.fromRGB(255, 220, 120),
        Content = Color3.fromRGB(255, 252, 230),
        Panel = Color3.fromRGB(255, 240, 185),
        Accent = Color3.fromRGB(235, 175, 45),
        AccentLight = Color3.fromRGB(255, 235, 160),
        Text = Color3.fromRGB(190, 130, 20),
        Stroke = Color3.fromRGB(245, 195, 70),
        DarkText = Color3.fromRGB(150, 100, 10)
    },
    Green = {
        Main = Color3.fromRGB(220, 250, 225),
        Sidebar = Color3.fromRGB(150, 220, 170),
        Content = Color3.fromRGB(240, 255, 242),
        Panel = Color3.fromRGB(210, 245, 215),
        Accent = Color3.fromRGB(75, 175, 105),
        AccentLight = Color3.fromRGB(185, 235, 195),
        Text = Color3.fromRGB(50, 135, 75),
        Stroke = Color3.fromRGB(105, 195, 130),
        DarkText = Color3.fromRGB(30, 100, 50)
    },
    Blue = {
        Main = Color3.fromRGB(220, 240, 255),
        Sidebar = Color3.fromRGB(150, 200, 245),
        Content = Color3.fromRGB(240, 250, 255),
        Panel = Color3.fromRGB(210, 235, 255),
        Accent = Color3.fromRGB(70, 145, 220),
        AccentLight = Color3.fromRGB(185, 220, 250),
        Text = Color3.fromRGB(45, 110, 185),
        Stroke = Color3.fromRGB(100, 165, 230),
        DarkText = Color3.fromRGB(25, 80, 145)
    },
    Orange = {
        Main = Color3.fromRGB(255, 230, 205),
        Sidebar = Color3.fromRGB(255, 175, 120),
        Content = Color3.fromRGB(255, 245, 235),
        Panel = Color3.fromRGB(255, 220, 190),
        Accent = Color3.fromRGB(235, 120, 50),
        AccentLight = Color3.fromRGB(255, 205, 165),
        Text = Color3.fromRGB(190, 85, 25),
        Stroke = Color3.fromRGB(245, 145, 75),
        DarkText = Color3.fromRGB(150, 60, 15)
    }
}

local _currTheme = "Pink"
local _currentAccent = _themes.Pink.Accent

--==================================================
-- GUI CREATION (ORIGINAL SIZE 680x480)
--==================================================

local _main = Instance.new("Frame")
_main.Name = "_main"
_main.Size = UDim2.fromOffset(680, 480)
_main.Position = UDim2.fromScale(0.5, 0.5)
_main.AnchorPoint = Vector2.new(0.5, 0.5)
_main.BackgroundColor3 = _themes.Pink.Main
_main.BorderSizePixel = 0
_main.Parent = ScreenGui

local _mainCorner = Instance.new("UICorner")
_mainCorner.CornerRadius = UDim.new(0, 18)
_mainCorner.Parent = _main

local _mainStroke = Instance.new("UIStroke")
_mainStroke.Name = "_mainStroke"
_mainStroke.Color = _themes.Pink.Stroke
_mainStroke.Thickness = 2
_mainStroke.Parent = _main

local _dragBar = Instance.new("Frame")
_dragBar.Name = "_dragBar"
_dragBar.Size = UDim2.new(1, 0, 0, 44)
_dragBar.Position = UDim2.new(0, 0, 0, 0)
_dragBar.BackgroundTransparency = 1
_dragBar.ZIndex = 100
_dragBar.Parent = _main

--==================================================
-- DRAGGABLE WINDOW
--==================================================
local _dragging = false
local _dragStart = nil
local _startPos = nil
local _dragConnection = nil

_dragBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        _dragging = true
        _dragStart = input.Position
        _startPos = _main.Position

        if _dragConnection then
            _dragConnection:Disconnect()
        end

        _dragConnection = UIS.InputChanged:Connect(function(move)
            if not _dragging then return end
            if move.UserInputType ~= Enum.UserInputType.MouseMovement
                and move.UserInputType ~= Enum.UserInputType.Touch then
                return
            end

            local delta = move.Position - _dragStart
            _main.Position = UDim2.new(
                _startPos.X.Scale,
                _startPos.X.Offset + delta.X,
                _startPos.Y.Scale,
                _startPos.Y.Offset + delta.Y
            )
        end)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        _dragging = false
        if _dragConnection then
            _dragConnection:Disconnect()
            _dragConnection = nil
        end
    end
end)

local _sidebar = Instance.new("Frame")
_sidebar.Name = "_sidebar"
_sidebar.Size = UDim2.new(0, 195, 1, 0)
_sidebar.BackgroundColor3 = _themes.Pink.Sidebar
_sidebar.BorderSizePixel = 0
_sidebar.Parent = _main

local _sidebarCorner = Instance.new("UICorner")
_sidebarCorner.CornerRadius = UDim.new(0, 18)
_sidebarCorner.Parent = _sidebar

local _sidebarFill = Instance.new("Frame")
_sidebarFill.Name = "_sidebarFill"
_sidebarFill.Size = UDim2.new(0, 30, 1, 0)
_sidebarFill.Position = UDim2.new(1, -30, 0, 0)
_sidebarFill.BackgroundColor3 = _themes.Pink.Sidebar
_sidebarFill.BorderSizePixel = 0
_sidebarFill.Parent = _sidebar

local _title = Instance.new("TextLabel")
_title.Name = "_title"
_title.Size = UDim2.new(1, 0, 0, 45)
_title.Position = UDim2.new(0, 0, 0, 8)
_title.BackgroundTransparency = 1
_title.Text = "Lucky"
_title.TextColor3 = _themes.Pink.Accent
_title.TextXAlignment = Enum.TextXAlignment.Center
_title.TextYAlignment = Enum.TextYAlignment.Center
_title.Font = Enum.Font.FredokaOne
_title.TextSize = 26
_title.Parent = _sidebar

local _tabHolder = Instance.new("ScrollingFrame")
_tabHolder.Name = "_tabs"
_tabHolder.Size = UDim2.new(1, -16, 1, -155)
_tabHolder.Position = UDim2.new(0, 8, 0, 58)
_tabHolder.BackgroundTransparency = 1
_tabHolder.BorderSizePixel = 0
_tabHolder.ScrollBarThickness = 3
_tabHolder.ScrollBarImageTransparency = 0.4
_tabHolder.AutomaticCanvasSize = Enum.AutomaticSize.Y
_tabHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
_tabHolder.Parent = _sidebar

local _tabLayout = Instance.new("UIListLayout")
_tabLayout.Padding = UDim.new(0, 6)
_tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
_tabLayout.Parent = _tabHolder

local _profile = Instance.new("Frame")
_profile.Name = "_profile"
_profile.Size = UDim2.new(1, -16, 0, 70)
_profile.Position = UDim2.new(0, 8, 1, -78)
_profile.BackgroundColor3 = _themes.Pink.AccentLight
_profile.BorderSizePixel = 0
_profile.ZIndex = 10
_profile.Parent = _sidebar

local _profileCorner = Instance.new("UICorner")
_profileCorner.CornerRadius = UDim.new(0, 10)
_profileCorner.Parent = _profile

local _avatar = Instance.new("ImageLabel")
_avatar.Name = "_avatar"
_avatar.Size = UDim2.fromOffset(46, 46)
_avatar.Position = UDim2.new(0, 8, 0.5, -23)
_avatar.BackgroundTransparency = 1
_avatar.ZIndex = 11
_avatar.Parent = _profile

local _avatarCorner = Instance.new("UICorner")
_avatarCorner.CornerRadius = UDim.new(1, 0)
_avatarCorner.Parent = _avatar

local _displayName = Instance.new("TextLabel")
_displayName.Name = "_display"
_displayName.Size = UDim2.new(1, -65, 0, 26)
_displayName.Position = UDim2.new(0, 60, 0.5, -18)
_displayName.BackgroundTransparency = 1
_displayName.Text = Player.DisplayName
_displayName.TextColor3 = _themes.Pink.Text
_displayName.Font = Enum.Font.FredokaOne
_displayName.TextSize = 14
_displayName.TextXAlignment = Enum.TextXAlignment.Left
_displayName.TextTruncate = Enum.TextTruncate.AtEnd
_displayName.ZIndex = 11
_displayName.Parent = _profile

local _username = Instance.new("TextLabel")
_username.Name = "_username"
_username.Size = UDim2.new(1, -65, 0, 18)
_username.Position = UDim2.new(0, 60, 0.5, 8)
_username.BackgroundTransparency = 1
_username.Text = "@" .. Player.Name
_username.TextColor3 = _themes.Pink.Text
_username.Font = Enum.Font.Gotham
_username.TextSize = 10
_username.TextXAlignment = Enum.TextXAlignment.Left
_username.TextTruncate = Enum.TextTruncate.AtEnd
_username.ZIndex = 11
_username.Parent = _profile

task.spawn(function()
    local ok, img = pcall(function()
        return Players:GetUserThumbnailAsync(Player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
    end)
    if ok then _avatar.Image = img end
end)

local _content = Instance.new("Frame")
_content.Name = "_content"
_content.Size = UDim2.new(1, -215, 1, -30)
_content.Position = UDim2.new(0, 205, 0, 15)
_content.BackgroundColor3 = _themes.Pink.Content
_content.BorderSizePixel = 0
_content.Parent = _main

local _contentCorner = Instance.new("UICorner")
_contentCorner.CornerRadius = UDim.new(0, 14)
_contentCorner.Parent = _content

local _pageHolder = Instance.new("Frame")
_pageHolder.Name = "_pages"
_pageHolder.Size = UDim2.new(1, -30, 1, -65)
_pageHolder.Position = UDim2.new(0, 15, 0, 55)
_pageHolder.BackgroundTransparency = 1
_pageHolder.Parent = _content

local _tabList = {
    "Silent Aim",
    "Fog",
    "Hitbox",
    "Misc",
    "Camlock",
    "Teleport",
    "Avatar",
    "Time Changer",
    "Skin Changer",
    "Whitelist",
    "Theme",
    "Settings"
}
local _pages = {}
local _buttons = {}
local _themeButtons = {}
local _killBtn = nil
local _uiElements = {}
local _skinDropdowns = {}

--==================================================
-- UI HELPERS
--==================================================

local function _makeToggle(parent, y, text, val, cb)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -20, 0, 34)
    row.Position = UDim2.new(0, 10, 0, y)
    row.BackgroundTransparency = 1
    row.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.55, 0, 1, 0)
    label.Text = text
    label.TextColor3 = _themes[_currTheme].Text
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row
    
    local container = Instance.new("Frame")
    container.Size = UDim2.new(0, 44, 0, 24)
    container.Position = UDim2.new(1, -52, 0.5, -12)
    container.BackgroundColor3 = val and _themes[_currTheme].Accent or Color3.fromRGB(200, 200, 210)
    container.BackgroundTransparency = val and 0.3 or 0.4
    container.BorderSizePixel = 0
    container.Parent = row
    local corner = Instance.new("UICorner", container)
    corner.CornerRadius = UDim.new(1, 0)
    
    local thumb = Instance.new("Frame")
    thumb.Size = UDim2.new(0, 18, 0, 18)
    thumb.Position = val and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
    thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    thumb.BorderSizePixel = 0
    thumb.Parent = container
    local tCorner = Instance.new("UICorner", thumb)
    tCorner.CornerRadius = UDim.new(1, 0)
    
    local isOn = val
    
    local toggleElement = {
        type = "toggle",
        container = container,
        label = label,
        thumb = thumb,
        isOn = isOn
    }
    table.insert(_uiElements, toggleElement)
    
    local function anim(target)
        local color = target and _themes[_currTheme].Accent or Color3.fromRGB(200, 200, 210)
        local trans = target and 0.3 or 0.4
        local pos = target and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
        TweenService:Create(container, TweenInfo.new(0.2), {BackgroundColor3 = color, BackgroundTransparency = trans}):Play()
        TweenService:Create(thumb, TweenInfo.new(0.2), {Position = pos}):Play()
    end
    
    local function toggle()
        isOn = not isOn
        toggleElement.isOn = isOn
        _playClick()
        anim(isOn)
        if cb then cb(isOn) end
    end
    
    container.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then toggle() end
    end)
    thumb.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then toggle() end
    end)
    return row
end

local function _makeSlider(parent, y, text, val, min, max, step, cb)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -20, 0, 34)
    row.Position = UDim2.new(0, 10, 0, y)
    row.BackgroundTransparency = 1
    row.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.2, 0, 1, 0)
    label.Text = text
    label.TextColor3 = _themes[_currTheme].Text
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row
    
    local valLabel = Instance.new("TextLabel")
    valLabel.Size = UDim2.new(0.08, 0, 1, 0)
    valLabel.Position = UDim2.new(0.92, 0, 0, 0)
    if step and step < 0.01 then
        valLabel.Text = string.format("%.3f", val)
    elseif step and step < 1 then
        valLabel.Text = string.format("%.2f", val)
    else
        valLabel.Text = tostring(val)
    end
    valLabel.TextColor3 = _themes[_currTheme].Accent
    valLabel.TextSize = 13
    valLabel.Font = Enum.Font.GothamBold
    valLabel.BackgroundTransparency = 1
    valLabel.TextXAlignment = Enum.TextXAlignment.Right
    valLabel.Parent = row
    
    local trackC = Instance.new("Frame")
    trackC.Size = UDim2.new(0.68, 0, 1, 0)
    trackC.Position = UDim2.new(0.22, 0, 0, 0)
    trackC.BackgroundTransparency = 1
    trackC.Parent = row
    
    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, 0, 0.3, 0)
    track.Position = UDim2.new(0, 0, 0.5, -0.15)
    track.BackgroundColor3 = Color3.fromRGB(200, 200, 210)
    track.BackgroundTransparency = 0.5
    track.BorderSizePixel = 0
    track.Parent = trackC
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)
    
    local fill = Instance.new("Frame")
    local p = (val - min) / (max - min)
    fill.Size = UDim2.new(p, 0, 1, 0)
    fill.BackgroundColor3 = _themes[_currTheme].Accent
    fill.BackgroundTransparency = 0.3
    fill.BorderSizePixel = 0
    fill.Parent = track
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
    
    local thumb = Instance.new("Frame")
    thumb.Size = UDim2.new(0, 16, 0, 16)
    thumb.Position = UDim2.new(p, -8, 0.5, -8)
    thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    thumb.BorderSizePixel = 2
    thumb.BorderColor3 = _themes[_currTheme].Accent
    thumb.Parent = trackC
    Instance.new("UICorner", thumb).CornerRadius = UDim.new(1, 0)
    
    table.insert(_uiElements, {
        type = "slider",
        label = label,
        valLabel = valLabel,
        fill = fill,
        thumb = thumb
    })
    
    local conn, dragging
    local function update(input)
        local tPos = track.AbsolutePosition
        local tSize = track.AbsoluteSize
        local pos = input.Position.X - tPos.X
        local perc = math.clamp(pos / tSize.X, 0, 1)
        local value = min + (perc * (max - min))
        if step then
            value = math.round(value / step) * step
        else
            value = math.round(value)
        end
        value = math.max(min, math.min(max, value))
        local np = (value - min) / (max - min)
        fill.Size = UDim2.new(np, 0, 1, 0)
        thumb.Position = UDim2.new(np, -8, 0.5, -8)
        if step and step < 0.01 then
            valLabel.Text = string.format("%.3f", value)
        elseif step and step < 1 then
            valLabel.Text = string.format("%.2f", value)
        else
            valLabel.Text = tostring(value)
        end
        cb(value)
    end
    
    thumb.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            _playClick()
            dragging = true
            if conn then conn:Disconnect() end
            conn = UIS.InputChanged:Connect(function(move)
                if dragging and move.UserInputType == Enum.UserInputType.MouseMovement then
                    update(move)
                end
            end)
        end
    end)
    
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
            if conn then conn:Disconnect() conn = nil end
        end
    end)
    return row
end

local function _makeDropdown(parent, y, text, items, def, cb)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -20, 0, 34)
    row.Position = UDim2.new(0, 10, 0, y)
    row.BackgroundTransparency = 1
    row.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.25, 0, 1, 0)
    label.Text = text
    label.TextColor3 = _themes[_currTheme].Text
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row
    
    local main = Instance.new("TextButton")
    main.Size = UDim2.new(0, 160, 0, 30)
    main.Position = UDim2.new(1, -170, 0.5, -15)
    main.BackgroundColor3 = _themes[_currTheme].AccentLight
    main.BackgroundTransparency = 0.4
    main.Text = items[def or 1]
    main.TextColor3 = _themes[_currTheme].Text
    main.Font = Enum.Font.Gotham
    main.TextSize = 12
    main.ZIndex = 5
    main.Parent = row
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 6)
    
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(0, 160, 0, math.min(#items * 28, 120))
    scroll.Position = UDim2.new(1, -170, 0, 34)
    scroll.BackgroundColor3 = _themes[_currTheme].Panel
    scroll.BackgroundTransparency = 0.1
    scroll.BorderSizePixel = 0
    scroll.Visible = false
    scroll.ZIndex = 6
    scroll.CanvasSize = UDim2.new(0, 0, 0, #items * 28)
    scroll.ScrollBarThickness = 2
    scroll.ScrollBarImageColor3 = _themes[_currTheme].Accent
    scroll.Parent = row
    Instance.new("UICorner", scroll).CornerRadius = UDim.new(0, 6)
    
    local scrollItems = {}
    for i, item in ipairs(items) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 26)
        btn.Position = UDim2.new(0, 0, 0, (i-1) * 28)
        btn.BackgroundColor3 = _themes[_currTheme].Panel
        btn.BackgroundTransparency = 0.2
        btn.Text = "  " .. item
        btn.TextColor3 = _themes[_currTheme].Text
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 12
        btn.ZIndex = 7
        btn.Parent = scroll
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
        btn.MouseEnter:Connect(function()
            _playHover()
        end)
        table.insert(scrollItems, btn)
        btn.MouseButton1Click:Connect(function()
            _playClick()
            main.Text = item
            scroll.Visible = false
            cb(i, item)
        end)
    end
    
    table.insert(_uiElements, {
        type = "dropdown",
        label = label,
        main = main,
        scroll = scroll,
        items = scrollItems
    })
    
    main.MouseButton1Click:Connect(function()
        _playClick()
        scroll.Visible = not scroll.Visible
    end)
    return row
end

local function _makeKeybind(parent, y, text, def, cb)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -20, 0, 34)
    row.Position = UDim2.new(0, 10, 0, y)
    row.BackgroundTransparency = 1
    row.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Text = text
    label.TextColor3 = _themes[_currTheme].Text
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 90, 0, 30)
    btn.Position = UDim2.new(1, -100, 0.5, -15)
    btn.BackgroundColor3 = _themes[_currTheme].AccentLight
    btn.BackgroundTransparency = 0.4
    btn.Text = def
    btn.TextColor3 = _themes[_currTheme].Text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.Parent = row
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    table.insert(_uiElements, {
        type = "keybind",
        label = label,
        btn = btn
    })
    
    local binding = false
    btn.MouseButton1Click:Connect(function()
        binding = true
        btn.BackgroundColor3 = _themes[_currTheme].Accent
        btn.BackgroundTransparency = 0.2
        btn.Text = "..."
    end)
    
    UIS.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if binding and input.UserInputType == Enum.UserInputType.Keyboard then
            local name = input.KeyCode.Name
            btn.Text = name
            btn.BackgroundColor3 = _themes[_currTheme].AccentLight
            btn.BackgroundTransparency = 0.4
            binding = false
            if cb then cb(name) end
        end
    end)
    return row
end

--==================================================
-- TIME CHANGER FUNCTIONS
--==================================================

local function _formatTime(hour)
    hour = hour % 24
    local h = math.floor(hour)
    local m = math.floor((hour - h) * 60)
    return string.format("%02d:%02d", h, m)
end

local function _setTime(hour)
    hour = math.clamp(hour, 0, 24)
    _timeTarget = hour
    Lighting:SetAttribute("DayTimeValue", hour)
end

--==================================================
-- SKIN DROPDOWN (writes directly to shared.Saved)
--==================================================

local function _writeSkin(weaponKey, skinName)
    if not shared.Saved then shared.Saved = {} end
    if not shared.Saved.GunModifiers then shared.Saved.GunModifiers = {} end
    if not shared.Saved.GunModifiers.SkinChanger then shared.Saved.GunModifiers.SkinChanger = {} end
    if not shared.Saved.GunModifiers.SkinChanger.Skins then shared.Saved.GunModifiers.SkinChanger.Skins = {} end
    shared.Saved.GunModifiers.SkinChanger.Skins[weaponKey] = skinName
end

local function _readSkin(weaponKey, fallback)
    if shared.Saved and shared.Saved.GunModifiers and shared.Saved.GunModifiers.SkinChanger
        and shared.Saved.GunModifiers.SkinChanger.Skins then
        local v = shared.Saved.GunModifiers.SkinChanger.Skins[weaponKey]
        if v then return v end
    end
    return fallback or "Default"
end

local function _makeSkinDropdown(parent, y, weaponKey, weaponName, options)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -20, 0, 38)
    row.Position = UDim2.new(0, 10, 0, y)
    row.BackgroundTransparency = 1
    row.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.35, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = weaponName
    label.TextColor3 = _themes[_currTheme].Text
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row
    
    local currentSkin = _readSkin(weaponKey, options[1] or "Default")
    
    local main = Instance.new("TextButton")
    main.Size = UDim2.new(0.5, 0, 0, 30)
    main.Position = UDim2.new(0.42, 0, 0.5, -15)
    main.BackgroundColor3 = _themes[_currTheme].AccentLight
    main.BackgroundTransparency = 0.3
    main.BorderSizePixel = 0
    main.Text = currentSkin
    main.TextColor3 = _themes[_currTheme].Text
    main.TextSize = 12
    main.Font = Enum.Font.Gotham
    main.ZIndex = 5
    main.Parent = row
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 6)
    
    local maxHeight = math.min(#options * 28, 250)
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(0.5, 0, 0, maxHeight)
    scroll.Position = UDim2.new(0.42, 0, 1, 2)
    scroll.BackgroundColor3 = _themes[_currTheme].Panel
    scroll.BackgroundTransparency = 0.1
    scroll.BorderSizePixel = 0
    scroll.Visible = false
    scroll.ZIndex = 10
    scroll.CanvasSize = UDim2.new(0, 0, 0, #options * 28)
    scroll.ScrollBarThickness = 2
    scroll.ScrollBarImageColor3 = _themes[_currTheme].Accent
    scroll.Parent = row
    Instance.new("UICorner", scroll).CornerRadius = UDim.new(0, 6)
    
    table.insert(_uiElements, {
        type = "dropdown",
        label = label,
        main = main,
        scroll = scroll
    })
    
    for i, option in ipairs(options) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 26)
        btn.Position = UDim2.new(0, 0, 0, (i-1) * 28)
        btn.BackgroundColor3 = _themes[_currTheme].Panel
        btn.BackgroundTransparency = 0.2
        btn.Text = "  " .. option
        btn.TextColor3 = _themes[_currTheme].Text
        btn.TextSize = 12
        btn.Font = Enum.Font.Gotham
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.ZIndex = 11
        btn.Parent = scroll
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
        
        btn.MouseEnter:Connect(function()
            _playHover()
            btn.BackgroundTransparency = 0
            btn.BackgroundColor3 = _themes[_currTheme].Accent
            btn.BackgroundTransparency = 0.2
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundTransparency = 0.2
            btn.BackgroundColor3 = _themes[_currTheme].Panel
            btn.TextColor3 = _themes[_currTheme].Text
        end)
        
        btn.MouseButton1Click:Connect(function()
            _playClick()
            main.Text = option
            scroll.Visible = false
            _writeSkin(weaponKey, option)
        end)
    end
    
    main.MouseButton1Click:Connect(function()
        scroll.Visible = not scroll.Visible
        for _, other in pairs(_skinDropdowns) do
            if other ~= scroll then
                other.Visible = false
            end
        end
    end)
    
    _skinDropdowns[weaponKey] = scroll
    return row
end

--==================================================
-- KILL FUNCTION
--==================================================

local function _kill()
    if Player and Player.Character then
        local hum = Player.Character:FindFirstChild("Humanoid")
        if hum then
            hum.WalkSpeed = 16
            hum.JumpPower = 50
        end
    end
    
    _speedActive = false
    _jumpActive = false
    _camActive = false
    _teleActive = false
    _espActive = false
    _espBox = false
    _espName = false
    _hitbox = false
    _camlock = false
    _teleport = false
    _esp = false
    _speed = false
    _jump = false
    _timeOverride = false
    
    Lighting.FogColor = Color3.fromRGB(130, 120, 150)
    if Lighting:FindFirstChild("Atmosphere") then
        Lighting.Atmosphere.FogColor = Color3.fromRGB(130, 120, 150)
    end
    Lighting.FogEnd = 500
    Lighting.FogStart = 50
    
    if _gh and _old then
        _gh.getAim = _old
    end
    
    if ScreenGui then
        ScreenGui:Destroy()
    end
    for _, c in pairs(PlayerGui:GetChildren()) do
        if c.Name == "_ui" then
            c:Destroy()
        end
    end
end

--==================================================
-- THEME FUNCTIONS
--==================================================

local function _updateKillTheme()
    if _killBtn then
        local accent = _themes[_currTheme].Accent
        _killBtn.BackgroundColor3 = accent
        _killBtn.BackgroundTransparency = 0.15
        local stroke = _killBtn:FindFirstChild("_stroke")
        if stroke then
            stroke.Color = accent:Lerp(Color3.fromRGB(255, 255, 255), 0.3)
        end
    end
end

local function _updateUITheme()
    local theme = _themes[_currTheme]

    for _, elem in pairs(_uiElements) do
        if elem.type == "toggle" then
            elem.label.TextColor3 = theme.Text
            elem.container.BackgroundColor3 =
                elem.isOn and theme.Accent or Color3.fromRGB(200, 200, 210)

        elseif elem.type == "slider" then
            elem.label.TextColor3 = theme.Text
            elem.valLabel.TextColor3 = theme.Accent
            elem.fill.BackgroundColor3 = theme.Accent
            elem.thumb.BorderColor3 = theme.Accent

        elseif elem.type == "dropdown" then
            elem.label.TextColor3 = theme.Text
            elem.main.BackgroundColor3 = theme.AccentLight
            elem.main.TextColor3 = theme.Text

            if elem.scroll then
                elem.scroll.BackgroundColor3 = theme.Panel
                elem.scroll.ScrollBarImageColor3 = theme.Accent
            end

            if elem.items then
                for _, item in pairs(elem.items) do
                    item.BackgroundColor3 = theme.Panel
                    item.TextColor3 = theme.Text
                end
            end

        elseif elem.type == "keybind" then
            elem.label.TextColor3 = theme.Text
            elem.btn.BackgroundColor3 = theme.AccentLight
            elem.btn.TextColor3 = theme.Text

        elseif elem.type == "text" then
            elem.label.TextColor3 = theme.Text
        end
    end
end

local function _replaceThemeColors(root, oldTheme, newTheme)
    local colorMap = {
        [oldTheme.Main] = newTheme.Main,
        [oldTheme.Sidebar] = newTheme.Sidebar,
        [oldTheme.Content] = newTheme.Content,
        [oldTheme.Panel] = newTheme.Panel,
        [oldTheme.Accent] = newTheme.Accent,
        [oldTheme.AccentLight] = newTheme.AccentLight,
        [oldTheme.Text] = newTheme.Text,
        [oldTheme.Stroke] = newTheme.Stroke,
        [oldTheme.DarkText] = newTheme.DarkText
    }

    local function replaceColor(value)
        for oldColor, newColor in pairs(colorMap) do
            if value == oldColor then
                return newColor
            end
        end
        return value
    end

    local function apply(obj)
        if _themeButtons then
            for _, themeButton in pairs(_themeButtons) do
                if obj == themeButton or obj:IsDescendantOf(themeButton) then
                    return
                end
            end
        end

        if obj:IsA("GuiObject") then
            obj.BackgroundColor3 = replaceColor(obj.BackgroundColor3)
            obj.BorderColor3 = replaceColor(obj.BorderColor3)

            if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
                obj.TextColor3 = replaceColor(obj.TextColor3)
            end

            if obj:IsA("TextBox") then
                obj.PlaceholderColor3 = replaceColor(obj.PlaceholderColor3)
            end

            if obj:IsA("ScrollingFrame") then
                obj.ScrollBarImageColor3 = replaceColor(obj.ScrollBarImageColor3)
            end
        elseif obj:IsA("UIStroke") then
            obj.Color = replaceColor(obj.Color)
        end

        for _, child in ipairs(obj:GetChildren()) do
            apply(child)
        end
    end

    apply(root)
end

local function _applyTheme(name)
    local theme = _themes[name]
    if not theme then return end

    local oldTheme = _themes[_currTheme]
    _currTheme = name

    if oldTheme then
        _replaceThemeColors(ScreenGui, oldTheme, theme)
    end

    _main.BackgroundColor3 = theme.Main
    _sidebar.BackgroundColor3 = theme.Sidebar
    _sidebarFill.BackgroundColor3 = theme.Sidebar
    _content.BackgroundColor3 = theme.Content
    _mainStroke.Color = theme.Stroke
    _title.TextColor3 = theme.Accent
    _profile.BackgroundColor3 = theme.AccentLight
    _displayName.TextColor3 = theme.Text
    _username.TextColor3 = theme.Text
    _tabHolder.ScrollBarImageColor3 = theme.Accent

    for tabName, btn in pairs(_buttons) do
        local selected = _pages[tabName] and _pages[tabName].Visible
        btn.BackgroundColor3 = selected and theme.Accent or theme.AccentLight
        btn.TextColor3 = selected and Color3.fromRGB(255,255,255) or theme.Text
    end

    for tabName, page in pairs(_pages) do
        local panel = page:FindFirstChild("_panel")
        if panel then
            panel.BackgroundColor3 = theme.Panel
            if panel:IsA("ScrollingFrame") then
                panel.ScrollBarImageColor3 = theme.Accent
            end
        end

        local title = page:FindFirstChild("_pageTitle")
        if title then
            title.TextColor3 = theme.Accent
        end
    end

    for themeName, btn in pairs(_themeButtons) do
        local stroke = btn:FindFirstChild("_selected")
        if stroke then
            stroke.Enabled = (themeName == _currTheme)
        end
    end

    _updateUITheme()
    _updateKillTheme()
end

local _pageTransitionId = 0

local function _showPage(name)
    _pageTransitionId += 1
    local transitionId = _pageTransitionId

    for n, page in pairs(_pages) do
        if n ~= name then
            page.Visible = false
            page.Position = UDim2.new(0, 0, 0, 0)
        end
    end

    local newPage = _pages[name]
    if newPage then
        newPage.Position = UDim2.new(0, 8, 0, 0)
        newPage.Visible = true

        local tween = TweenService:Create(
            newPage,
            TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Position = UDim2.new(0, 0, 0, 0)}
        )
        tween:Play()

        task.delay(0.16, function()
            if transitionId == _pageTransitionId and newPage.Parent then
                newPage.Position = UDim2.new(0, 0, 0, 0)
            end
        end)
    end

    local theme = _themes[_currTheme]
    for n, btn in pairs(_buttons) do
        local selected = (n == name)
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = selected and theme.Accent or theme.AccentLight
        }):Play()
        btn.TextColor3 = selected and Color3.fromRGB(255,255,255) or theme.Text
    end
end

--==================================================
-- WHITELIST HELPERS
--==================================================

local function _wlApplyRowVisual(plr)
    local row = _whitelistRows[plr.UserId]
    if not row or not row.Parent then return end
    local hl = row:FindFirstChild("_highlight")
    local dot = row:FindFirstChild("_dot")
    local status = row:FindFirstChild("_status")
    local on = _isWhitelisted(plr)
    if hl then hl.Visible = on end
    if dot then
        dot.BackgroundColor3 = on and Color3.fromRGB(80, 220, 140) or Color3.fromRGB(180, 180, 190)
    end
    if status then
        status.Text = on and "WHITELISTED" or "Not whitelisted"
        status.TextColor3 = on and Color3.fromRGB(60, 200, 120) or _themes[_currTheme].Text
    end
end

local function _wlRefreshCount()
    if not _wlCountLabel or not _wlCountLabel.Parent then return end
    local n = 0
    for _ in pairs(_whitelisted) do n += 1 end
    _wlCountLabel.Text = "Whitelisted: " .. tostring(n) .. " player" .. (n == 1 and "" or "s")
end

local function _wlToggle(plr)
    if plr == Player then return end
    if _whitelisted[plr.UserId] then
        _whitelisted[plr.UserId] = nil
    else
        _whitelisted[plr.UserId] = true
    end
    _wlApplyRowVisual(plr)
    _wlRefreshCount()
end

local function _wlBuildRow(plr, order)
    if not _wlListFrame or not _wlListFrame.Parent then return end
    if _whitelistRows[plr.UserId] and _whitelistRows[plr.UserId].Parent then return end
    if plr == Player then return end

    local row = Instance.new("TextButton")
    row.Name = "WL_" .. plr.UserId
    row.Size = UDim2.new(1, -16, 0, 46)
    row.BackgroundColor3 = _themes[_currTheme].AccentLight
    row.BackgroundTransparency = 0.45
    row.BorderSizePixel = 0
    row.Text = ""
    row.AutoButtonColor = false
    row.LayoutOrder = order or 0
    row.Parent = _wlListFrame
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10)

    local hl = Instance.new("Frame")
    hl.Name = "_highlight"
    hl.Size = UDim2.fromScale(1, 1)
    hl.BackgroundColor3 = _themes[_currTheme].Accent
    hl.BackgroundTransparency = 0.55
    hl.BorderSizePixel = 0
    hl.Visible = false
    hl.ZIndex = 0
    hl.Parent = row
    Instance.new("UICorner", hl).CornerRadius = UDim.new(0, 10)

    local avatar = Instance.new("ImageLabel")
    avatar.Name = "_avatar"
    avatar.Size = UDim2.fromOffset(34, 34)
    avatar.Position = UDim2.new(0, 8, 0.5, -17)
    avatar.BackgroundTransparency = 1
    avatar.ZIndex = 2
    avatar.Parent = row
    Instance.new("UICorner", avatar).CornerRadius = UDim.new(1, 0)
    task.spawn(function()
        local ok, img = pcall(function()
            return Players:GetUserThumbnailAsync(plr.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
        end)
        if ok and avatar.Parent then avatar.Image = img end
    end)

    local dot = Instance.new("Frame")
    dot.Name = "_dot"
    dot.Size = UDim2.fromOffset(10, 10)
    dot.Position = UDim2.new(0, 48, 0, 12)
    dot.BackgroundColor3 = Color3.fromRGB(180, 180, 190)
    dot.BorderSizePixel = 0
    dot.ZIndex = 2
    dot.Parent = row
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

    local nameLbl = Instance.new("TextLabel")
    nameLbl.Name = "_name"
    nameLbl.Size = UDim2.new(1, -110, 0, 20)
    nameLbl.Position = UDim2.new(0, 62, 0, 5)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Text = plr.DisplayName .. "  (@" .. plr.Name .. ")"
    nameLbl.TextColor3 = _themes[_currTheme].Text
    nameLbl.Font = Enum.Font.GothamBold
    nameLbl.TextSize = 13
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    nameLbl.TextTruncate = Enum.TextTruncate.AtEnd
    nameLbl.ZIndex = 2
    nameLbl.Parent = row

    local status = Instance.new("TextLabel")
    status.Name = "_status"
    status.Size = UDim2.new(1, -110, 0, 16)
    status.Position = UDim2.new(0, 62, 0, 25)
    status.BackgroundTransparency = 1
    status.Text = "Not whitelisted"
    status.TextColor3 = _themes[_currTheme].Text
    status.Font = Enum.Font.Gotham
    status.TextSize = 11
    status.TextXAlignment = Enum.TextXAlignment.Left
    status.ZIndex = 2
    status.Parent = row

    row.MouseButton1Click:Connect(function()
        _playClick()
        _wlToggle(plr)
    end)
    row.MouseEnter:Connect(function()
        _playHover()
        TweenService:Create(row, TweenInfo.new(0.12), {BackgroundTransparency = 0.25}):Play()
    end)
    row.MouseLeave:Connect(function()
        TweenService:Create(row, TweenInfo.new(0.12), {BackgroundTransparency = 0.45}):Play()
    end)

    _whitelistRows[plr.UserId] = row
    _wlApplyRowVisual(plr)
end

local function _wlRemoveRow(plr)
    local row = _whitelistRows[plr.UserId]
    if row then
        row:Destroy()
        _whitelistRows[plr.UserId] = nil
    end
    _wlRefreshCount()
end

local function _wlRebuildAll()
    if not _wlListFrame or not _wlListFrame.Parent then return end
    for _, row in pairs(_whitelistRows) do
        if row and row.Parent then row:Destroy() end
    end
    _whitelistRows = {}
    local order = 0
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= Player then
            order += 1
            _wlBuildRow(plr, order)
        end
    end
    _wlRefreshCount()
end

Players.PlayerAdded:Connect(function(plr)
    if _wlListFrame and _wlListFrame.Parent then
        task.defer(function() _wlBuildRow(plr, 999) end)
    end
end)

Players.PlayerRemoving:Connect(function(plr)
    _whitelisted[plr.UserId] = nil
    _wlRemoveRow(plr)
end)

--==================================================
-- BUILD TABS
--==================================================

for _, tabName in ipairs(_tabList) do
    local btn = Instance.new("TextButton")
    btn.Name = tabName .. "_btn"
    btn.Size = UDim2.new(1, 0, 0, 42)
    btn.BackgroundColor3 = _themes.Pink.AccentLight
    btn.BorderSizePixel = 0
    btn.Text = tabName
    btn.TextColor3 = _themes.Pink.Text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.Parent = _tabHolder
    
    local bCorner = Instance.new("UICorner")
    bCorner.CornerRadius = UDim.new(0, 9)
    bCorner.Parent = btn
    _buttons[tabName] = btn
    
    local page = Instance.new("Frame")
    page.Name = tabName .. "_page"
    page.Size = UDim2.fromScale(1, 1)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = _pageHolder
    _pages[tabName] = page
    
    local pTitle = Instance.new("TextLabel")
    pTitle.Name = "_pageTitle"
    pTitle.Size = UDim2.new(1, 0, 0, 38)
    pTitle.BackgroundTransparency = 1
    pTitle.Text = tabName
    pTitle.TextColor3 = _themes.Pink.Accent
    pTitle.Font = Enum.Font.FredokaOne
    pTitle.TextSize = 24
    pTitle.TextXAlignment = Enum.TextXAlignment.Left
    pTitle.Parent = page
    
    if tabName == "Time Changer" then
        local panel = Instance.new("ScrollingFrame")
        panel.Name = "_panel"
        panel.Size = UDim2.new(1, 0, 1, -48)
        panel.Position = UDim2.new(0, 0, 0, 45)
        panel.BackgroundColor3 = _themes.Pink.Panel
        panel.BorderSizePixel = 0
        panel.ScrollBarThickness = 0
        panel.ScrollBarImageColor3 = _themes.Pink.Accent
        panel.AutomaticCanvasSize = Enum.AutomaticSize.Y
        panel.CanvasSize = UDim2.new(0, 0, 0, 0)
        panel.ScrollingDirection = Enum.ScrollingDirection.Y
        panel.Parent = page
        
        local pCorner = Instance.new("UICorner")
        pCorner.CornerRadius = UDim.new(0, 12)
        pCorner.Parent = panel
        
        local padding = Instance.new("UIPadding")
        padding.PaddingTop = UDim.new(0, 10)
        padding.PaddingBottom = UDim.new(0, 10)
        padding.PaddingLeft = UDim.new(0, 5)
        padding.PaddingRight = UDim.new(0, 5)
        padding.Parent = panel
        
        local yOff = 0
        
        local timeDisplay = Instance.new("TextLabel")
        timeDisplay.Size = UDim2.new(1, 0, 0, 50)
        timeDisplay.Position = UDim2.new(0, 0, 0, yOff)
        timeDisplay.BackgroundTransparency = 1
        timeDisplay.Text = _formatTime(Lighting.ClockTime)
        timeDisplay.TextColor3 = _themes.Pink.Accent
        timeDisplay.TextSize = 40
        timeDisplay.Font = Enum.Font.FredokaOne
        timeDisplay.Parent = panel
        table.insert(_uiElements, {type = "text", label = timeDisplay})
        yOff = yOff + 55
        
        local sliderRow = Instance.new("Frame")
        sliderRow.Size = UDim2.new(1, -20, 0, 44)
        sliderRow.Position = UDim2.new(0, 10, 0, yOff)
        sliderRow.BackgroundTransparency = 1
        sliderRow.Parent = panel
        yOff = yOff + 48
        
        local sliderLabel = Instance.new("TextLabel")
        sliderLabel.Size = UDim2.new(0.15, 0, 1, 0)
        sliderLabel.Text = "Time"
        sliderLabel.TextColor3 = _themes.Pink.Text
        sliderLabel.TextSize = 13
        sliderLabel.Font = Enum.Font.GothamBold
        sliderLabel.BackgroundTransparency = 1
        sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
        sliderLabel.Parent = sliderRow
        
        local valLabel = Instance.new("TextLabel")
        valLabel.Size = UDim2.new(0.1, 0, 1, 0)
        valLabel.Position = UDim2.new(0.9, 0, 0, 0)
        valLabel.Text = string.format("%.1fh", Lighting.ClockTime)
        valLabel.TextColor3 = _themes.Pink.Accent
        valLabel.TextSize = 13
        valLabel.Font = Enum.Font.GothamBold
        valLabel.BackgroundTransparency = 1
        valLabel.TextXAlignment = Enum.TextXAlignment.Right
        valLabel.Parent = sliderRow
        
        local trackC = Instance.new("Frame")
        trackC.Size = UDim2.new(0.7, 0, 1, 0)
        trackC.Position = UDim2.new(0.17, 0, 0, 0)
        trackC.BackgroundTransparency = 1
        trackC.Parent = sliderRow
        
        local track = Instance.new("Frame")
        track.Size = UDim2.new(1, 0, 0.3, 0)
        track.Position = UDim2.new(0, 0, 0.5, -0.15)
        track.BackgroundColor3 = Color3.fromRGB(200, 200, 210)
        track.BackgroundTransparency = 0.5
        track.BorderSizePixel = 0
        track.Parent = trackC
        Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)
        
        local fill = Instance.new("Frame")
        local p = Lighting.ClockTime / 24
        fill.Size = UDim2.new(p, 0, 1, 0)
        fill.BackgroundColor3 = _themes.Pink.Accent
        fill.BackgroundTransparency = 0.3
        fill.BorderSizePixel = 0
        fill.Parent = track
        Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
        
        local thumb = Instance.new("Frame")
        thumb.Size = UDim2.new(0, 18, 0, 18)
        thumb.Position = UDim2.new(p, -9, 0.5, -9)
        thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        thumb.BorderSizePixel = 2
        thumb.BorderColor3 = _themes.Pink.Accent
        thumb.Parent = trackC
        Instance.new("UICorner", thumb).CornerRadius = UDim.new(1, 0)
        
        table.insert(_uiElements, {
            type = "slider",
            label = sliderLabel,
            valLabel = valLabel,
            fill = fill,
            thumb = thumb
        })
        
        local conn, dragging
        local function updateTime(input)
            local tPos = track.AbsolutePosition
            local tSize = track.AbsoluteSize
            local pos = input.Position.X - tPos.X
            local perc = math.clamp(pos / tSize.X, 0, 1)
            local value = perc * 24
            value = math.round(value / 0.1) * 0.1
            value = math.max(0, math.min(24, value))
            local np = value / 24
            fill.Size = UDim2.new(np, 0, 1, 0)
            thumb.Position = UDim2.new(np, -9, 0.5, -9)
            valLabel.Text = string.format("%.1fh", value)
            timeDisplay.Text = _formatTime(value)
            _setTime(value)
        end
        
        thumb.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                if conn then conn:Disconnect() end
                conn = UIS.InputChanged:Connect(function(move)
                    if dragging and move.UserInputType == Enum.UserInputType.MouseMovement then
                        updateTime(move)
                    end
                end)
            end
        end)
        
        track.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                updateTime(input)
            end
        end)
        
        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
                if conn then conn:Disconnect() conn = nil end
            end
        end)
        
        yOff = yOff + 10
        
        _makeToggle(panel, yOff, "Override Server Time", _timeOverride, function(v)
            _timeOverride = v
            if v then
                Lighting:SetAttribute("DayTimeValue", _timeTarget)
            else
                Lighting:SetAttribute("DayTimeValue", nil)
            end
        end)
        yOff = yOff + 38
        
        local presetRow = Instance.new("Frame")
        presetRow.Size = UDim2.new(1, -20, 0, 34)
        presetRow.Position = UDim2.new(0, 10, 0, yOff)
        presetRow.BackgroundTransparency = 1
        presetRow.Parent = panel
        yOff = yOff + 38
        
        local presetLabel = Instance.new("TextLabel")
        presetLabel.Size = UDim2.new(0.25, 0, 1, 0)
        presetLabel.Text = "Presets"
        presetLabel.TextColor3 = _themes.Pink.Text
        presetLabel.TextSize = 13
        presetLabel.Font = Enum.Font.GothamBold
        presetLabel.BackgroundTransparency = 1
        presetLabel.TextXAlignment = Enum.TextXAlignment.Left
        presetLabel.Parent = presetRow
        table.insert(_uiElements, {type = "text", label = presetLabel})
        
        local presetNames = {"Dawn", "Morning", "Noon", "Sunset", "Night", "Blue"}
        local presetTimes = {5.5, 9, 12, 19, 22, 20.5}
        
        for i = 1, 6 do
            local pBtn = Instance.new("TextButton")
            pBtn.Size = UDim2.new(0.11, 0, 0, 28)
            pBtn.Position = UDim2.new(0.26 + ((i-1) * 0.12), 0, 0, 0)
            pBtn.BackgroundColor3 = _themes.Pink.AccentLight
            pBtn.BackgroundTransparency = 0.3
            pBtn.BorderSizePixel = 0
            pBtn.Text = presetNames[i]
            pBtn.TextColor3 = _themes.Pink.Text
            pBtn.TextSize = 10
            pBtn.Font = Enum.Font.GothamBold
            pBtn.Parent = presetRow
            
            local pCorner = Instance.new("UICorner")
            pCorner.CornerRadius = UDim.new(0, 6)
            pCorner.Parent = pBtn
            
            pBtn.MouseEnter:Connect(function()
                pBtn.BackgroundTransparency = 0
                pBtn.BackgroundColor3 = _themes.Pink.Accent
                pBtn.BackgroundTransparency = 0.2
            end)
            pBtn.MouseLeave:Connect(function()
                pBtn.BackgroundTransparency = 0.3
                pBtn.BackgroundColor3 = _themes.Pink.AccentLight
            end)
            
            pBtn.MouseButton1Click:Connect(function()
                _playClick()
                _setTime(presetTimes[i])
                timeDisplay.Text = _formatTime(presetTimes[i])
                valLabel.Text = string.format("%.1fh", presetTimes[i])
                local np = presetTimes[i] / 24
                fill.Size = UDim2.new(np, 0, 1, 0)
                thumb.Position = UDim2.new(np, -9, 0.5, -9)
            end)
        end
        
        yOff = yOff + 44
        
        local currentTimeLabel = Instance.new("TextLabel")
        currentTimeLabel.Size = UDim2.new(1, -20, 0, 30)
        currentTimeLabel.Position = UDim2.new(0, 10, 0, yOff)
        currentTimeLabel.BackgroundTransparency = 1
        currentTimeLabel.Text = "Current: " .. _formatTime(Lighting.ClockTime)
        currentTimeLabel.TextColor3 = _themes.Pink.Text
        currentTimeLabel.TextSize = 13
        currentTimeLabel.Font = Enum.Font.Gotham
        currentTimeLabel.TextXAlignment = Enum.TextXAlignment.Center
        currentTimeLabel.Parent = panel
        table.insert(_uiElements, {type = "text", label = currentTimeLabel})
        yOff = yOff + 40
        
        Lighting:GetPropertyChangedSignal("ClockTime"):Connect(function()
            timeDisplay.Text = _formatTime(Lighting.ClockTime)
            currentTimeLabel.Text = "Current: " .. _formatTime(Lighting.ClockTime)
        end)
        
        panel.CanvasSize = UDim2.new(0, 0, 0, yOff + 20)
        
    elseif tabName == "Skin Changer" then
        local panel = Instance.new("ScrollingFrame")
        panel.Name = "_panel"
        panel.Size = UDim2.new(1, 0, 1, -48)
        panel.Position = UDim2.new(0, 0, 0, 45)
        panel.BackgroundColor3 = _themes.Pink.Panel
        panel.BorderSizePixel = 0
        panel.ScrollBarThickness = 0
        panel.ScrollBarImageColor3 = _themes.Pink.Accent
        panel.AutomaticCanvasSize = Enum.AutomaticSize.Y
        panel.CanvasSize = UDim2.new(0, 0, 0, 0)
        panel.ScrollingDirection = Enum.ScrollingDirection.Y
        panel.Parent = page
        
        local pCorner = Instance.new("UICorner")
        pCorner.CornerRadius = UDim.new(0, 12)
        pCorner.Parent = panel
        
        local padding = Instance.new("UIPadding")
        padding.PaddingTop = UDim.new(0, 10)
        padding.PaddingBottom = UDim.new(0, 10)
        padding.PaddingLeft = UDim.new(0, 5)
        padding.PaddingRight = UDim.new(0, 5)
        padding.Parent = panel
        
        local yOff = 0
        
        _makeToggle(panel, yOff, "Enable Skins", true, function(v)
            if shared.Saved and shared.Saved.GunModifiers and shared.Saved.GunModifiers.SkinChanger then
                shared.Saved.GunModifiers.SkinChanger.Enabled = v
            end
        end)
        yOff = yOff + 38
        
        local info = Instance.new("TextLabel")
        info.Size = UDim2.new(1, -20, 0, 30)
        info.Position = UDim2.new(0, 10, 0, yOff)
        info.BackgroundTransparency = 1
        info.Text = "Select a skin for each weapon:"
        info.TextColor3 = _themes.Pink.Text
        info.TextSize = 13
        info.Font = Enum.Font.GothamMedium
        info.TextXAlignment = Enum.TextXAlignment.Left
        info.Parent = panel
        table.insert(_uiElements, {type = "text", label = info})
        yOff = yOff + 35
        
        for weaponKey, config in pairs(weaponConfigs) do
            _makeSkinDropdown(panel, yOff, weaponKey, config.name, config.skins)
            yOff = yOff + 42
        end
        
        local statusLabel = Instance.new("TextLabel")
        statusLabel.Size = UDim2.new(1, -20, 0, 30)
        statusLabel.Position = UDim2.new(0, 10, 0, yOff)
        statusLabel.BackgroundTransparency = 1
        statusLabel.Text = skinLoaderLoaded and "✅ Skin loader loaded" or "⚠️ Skin loader failed (pastebin may be down)"
        statusLabel.TextColor3 = skinLoaderLoaded and Color3.fromRGB(80, 255, 180) or Color3.fromRGB(255, 200, 80)
        statusLabel.TextSize = 12
        statusLabel.Font = Enum.Font.Gotham
        statusLabel.TextXAlignment = Enum.TextXAlignment.Center
        statusLabel.Parent = panel
        table.insert(_uiElements, {type = "text", label = statusLabel})
        yOff = yOff + 40
        
        panel.CanvasSize = UDim2.new(0, 0, 0, yOff + 20)
        
    elseif tabName == "Theme" then
        local panel = Instance.new("ScrollingFrame")
        panel.Name = "_panel"
        panel.Size = UDim2.new(1, 0, 1, -48)
        panel.Position = UDim2.new(0, 0, 0, 45)
        panel.BackgroundColor3 = _themes.Pink.Panel
        panel.BorderSizePixel = 0
        panel.ScrollBarThickness = 4
        panel.ScrollBarImageColor3 = _themes.Pink.Accent
        panel.AutomaticCanvasSize = Enum.AutomaticSize.Y
        panel.CanvasSize = UDim2.new(0, 0, 0, 0)
        panel.ScrollingDirection = Enum.ScrollingDirection.Y
        panel.Parent = page
        
        local pCorner = Instance.new("UICorner")
        pCorner.CornerRadius = UDim.new(0, 12)
        pCorner.Parent = panel
        
        local padding = Instance.new("UIPadding")
        padding.PaddingTop = UDim.new(0, 15)
        padding.PaddingBottom = UDim.new(0, 15)
        padding.PaddingLeft = UDim.new(0, 15)
        padding.PaddingRight = UDim.new(0, 15)
        padding.Parent = panel
        
        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 10)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = panel
        
        local title = Instance.new("TextLabel")
        title.LayoutOrder = 1
        title.Size = UDim2.new(1, 0, 0, 35)
        title.BackgroundTransparency = 1
        title.Text = "Choose a color theme"
        title.TextColor3 = _themes.Pink.Text
        title.Font = Enum.Font.GothamBold
        title.TextSize = 15
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Parent = panel
        
        local grid = Instance.new("Frame")
        grid.LayoutOrder = 2
        grid.Size = UDim2.new(1, 0, 0, 170)
        grid.BackgroundTransparency = 1
        grid.Parent = panel
        
        local gridL = Instance.new("UIGridLayout")
        gridL.CellSize = UDim2.new(0.48, 0, 0, 50)
        gridL.CellPadding = UDim2.new(0.04, 0, 0, 10)
        gridL.Parent = grid
        
        local names = {"Pink","Purple","Yellow","Green","Blue","Orange"}
        
        for _, n in ipairs(names) do
            local tBtn = Instance.new("TextButton")
            tBtn.Name = n .. "_theme"
            tBtn.BackgroundColor3 = _themes[n].Accent
            tBtn.BorderSizePixel = 0
            tBtn.Text = n
            tBtn.TextColor3 = Color3.fromRGB(255,255,255)
            tBtn.Font = Enum.Font.Gotham
            tBtn.TextSize = 13
            tBtn.Parent = grid
            
            local tCorner = Instance.new("UICorner")
            tCorner.CornerRadius = UDim.new(0, 10)
            tCorner.Parent = tBtn
            
            local sel = Instance.new("UIStroke")
            sel.Name = "_selected"
            sel.Color = Color3.fromRGB(255,255,255)
            sel.Thickness = 2
            sel.Enabled = false
            sel.Parent = tBtn
            
            _themeButtons[n] = tBtn
            tBtn.MouseEnter:Connect(function()
                _playHover()
            end)
            tBtn.MouseButton1Click:Connect(function()
                _playClick()
                _applyTheme(n)
            end)
        end
        
        local custom = Instance.new("TextBox")
        custom.Name = "_custom"
        custom.Size = UDim2.new(1, 0, 0, 50)
        custom.BackgroundColor3 = _themes.Pink.AccentLight
        custom.BorderSizePixel = 0
        custom.PlaceholderText = "Custom hex (example: #FF69B4)"
        custom.Text = ""
        custom.TextColor3 = _themes.Pink.Text
        custom.PlaceholderColor3 = _themes.Pink.Text
        custom.Font = Enum.Font.GothamBold
        custom.TextSize = 13
        custom.ClearTextOnFocus = false
        custom.LayoutOrder = 3
        custom.Parent = panel
        
        local cCorner = Instance.new("UICorner")
        cCorner.CornerRadius = UDim.new(0, 10)
        cCorner.Parent = custom
        
        custom.FocusLost:Connect(function(enter)
            if not enter then return end
            local hex = custom.Text:gsub("#", "")
            if #hex ~= 6 or not hex:match("^[%x]+$") then return end
            local r = tonumber(hex:sub(1,2), 16)
            local g = tonumber(hex:sub(3,4), 16)
            local b = tonumber(hex:sub(5,6), 16)
            local accent = Color3.fromRGB(r,g,b)
            _themes.Custom = {
                Main = accent:Lerp(Color3.new(1,1,1), 0.85),
                Sidebar = accent:Lerp(Color3.new(1,1,1), 0.65),
                Content = accent:Lerp(Color3.new(1,1,1), 0.92),
                Panel = accent:Lerp(Color3.new(1,1,1), 0.82),
                Accent = accent,
                AccentLight = accent:Lerp(Color3.new(1,1,1), 0.75),
                Text = accent:Lerp(Color3.new(0,0,0), 0.25),
                Stroke = accent:Lerp(Color3.new(1,1,1), 0.25),
                DarkText = accent:Lerp(Color3.new(0,0,0), 0.5)
            }
            _applyTheme("Custom")
        end)
        
    elseif tabName == "Whitelist" then
        local panel = Instance.new("Frame")
        panel.Name = "_panel"
        panel.Size = UDim2.new(1, 0, 1, -48)
        panel.Position = UDim2.new(0, 0, 0, 45)
        panel.BackgroundColor3 = _themes.Pink.Panel
        panel.BorderSizePixel = 0
        panel.Parent = page
        
        local pCorner = Instance.new("UICorner")
        pCorner.CornerRadius = UDim.new(0, 12)
        pCorner.Parent = panel
        
        local header = Instance.new("TextLabel")
        header.Name = "_wlHeader"
        header.Size = UDim2.new(1, -20, 0, 26)
        header.Position = UDim2.new(0, 10, 0, 8)
        header.BackgroundTransparency = 1
        header.Text = "Click a player to whitelist / unwhitelist them"
        header.TextColor3 = _themes.Pink.Text
        header.Font = Enum.Font.GothamBold
        header.TextSize = 13
        header.TextXAlignment = Enum.TextXAlignment.Left
        header.Parent = panel
        table.insert(_uiElements, {type = "text", label = header})
        
        local count = Instance.new("TextLabel")
        count.Name = "_wlCount"
        count.Size = UDim2.new(1, -20, 0, 22)
        count.Position = UDim2.new(0, 10, 0, 32)
        count.BackgroundTransparency = 1
        count.Text = "Whitelisted: 0 players"
        count.TextColor3 = _themes.Pink.Accent
        count.Font = Enum.Font.GothamBold
        count.TextSize = 12
        count.TextXAlignment = Enum.TextXAlignment.Left
        count.Parent = panel
        table.insert(_uiElements, {type = "text", label = count})
        _wlCountLabel = count
        
        local list = Instance.new("ScrollingFrame")
        list.Name = "_wlList"
        list.Size = UDim2.new(1, -16, 1, -66)
        list.Position = UDim2.new(0, 8, 0, 58)
        list.BackgroundTransparency = 1
        list.BorderSizePixel = 0
        list.ScrollBarThickness = 3
        list.ScrollBarImageColor3 = _themes.Pink.Accent
        list.AutomaticCanvasSize = Enum.AutomaticSize.Y
        list.CanvasSize = UDim2.new(0, 0, 0, 0)
        list.ScrollingDirection = Enum.ScrollingDirection.Y
        list.Parent = panel
        _wlListFrame = list
        
        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 6)
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Parent = list
        
        _wlRebuildAll()
        _wlRefreshCount()
        
    else
        local panel = Instance.new("ScrollingFrame")
        panel.Name = "_panel"
        panel.Size = UDim2.new(1, 0, 1, -48)
        panel.Position = UDim2.new(0, 0, 0, 45)
        panel.BackgroundColor3 = _themes.Pink.Panel
        panel.BorderSizePixel = 0
        panel.ScrollBarThickness = 0
        panel.ScrollBarImageColor3 = _themes.Pink.Accent
        panel.AutomaticCanvasSize = Enum.AutomaticSize.Y
        panel.CanvasSize = UDim2.new(0, 0, 0, 0)
        panel.ScrollingDirection = Enum.ScrollingDirection.Y
        panel.Parent = page
        
        local pCorner = Instance.new("UICorner")
        pCorner.CornerRadius = UDim.new(0, 12)
        pCorner.Parent = panel
        
        local padding = Instance.new("UIPadding")
        padding.PaddingTop = UDim.new(0, 10)
        padding.PaddingBottom = UDim.new(0, 10)
        padding.PaddingLeft = UDim.new(0, 5)
        padding.PaddingRight = UDim.new(0, 5)
        padding.Parent = panel
        
        local yOff = 0
        
        if tabName == "Silent Aim" then
            _makeToggle(panel, yOff, "Silent Aim", true, function(v) _silent = v end)
            yOff = yOff + 38
            _makeToggle(panel, yOff, "Exclude Revolver", false, function(v) _exclude = v end)
            yOff = yOff + 38
            _makeToggle(panel, yOff, "Wall Check", false, function(v) _wall = v end)
            yOff = yOff + 38
            _makeToggle(panel, yOff, "Knock Check", false, function(v) _knock = v end)
            yOff = yOff + 40
            _makeSlider(panel, yOff, "FOV Radius", 100, 0, 1000, 1, function(v) _fov = v end)
            yOff = yOff + 38
            _makeSlider(panel, yOff, "Bullet Spread", 100, 0, 100, 1, function(v) _spread = v end)
            yOff = yOff + 40
            _makeDropdown(panel, yOff, "Aim Part", {"Head","Body","Left Leg","Right Leg","Left Arm","Right Arm","Closest Part"}, 1, function(i,v) _aimPart = v end)
            yOff = yOff + 40
            panel.CanvasSize = UDim2.new(0, 0, 0, yOff + 20)
            
        elseif tabName == "Fog" then
            local colors = {"Pink","Purple","Yellow","Green","Blue","Orange"}
            _makeDropdown(panel, yOff, "Fog Color", colors, 1, function(i,n)
                local map = {
                    Pink = Color3.fromRGB(255, 200, 220),
                    Purple = Color3.fromRGB(200, 180, 240),
                    Yellow = Color3.fromRGB(255, 240, 180),
                    Green = Color3.fromRGB(180, 240, 200),
                    Blue = Color3.fromRGB(180, 220, 255),
                    Orange = Color3.fromRGB(255, 210, 180)
                }
                _fogColor = map[n] or Color3.fromRGB(200, 195, 215)
                Lighting.FogColor = _fogColor
                if Lighting:FindFirstChild("Atmosphere") then
                    Lighting.Atmosphere.FogColor = _fogColor
                end
            end)
            yOff = yOff + 40
            
            local hexRow = Instance.new("Frame")
            hexRow.Size = UDim2.new(1, -20, 0, 34)
            hexRow.Position = UDim2.new(0, 10, 0, yOff)
            hexRow.BackgroundTransparency = 1
            hexRow.Parent = panel
            
            local hexLabel = Instance.new("TextLabel")
            hexLabel.Size = UDim2.new(0.25, 0, 1, 0)
            hexLabel.Text = "Hex Color"
            hexLabel.TextColor3 = _themes[_currTheme].Text
            hexLabel.TextSize = 13
            hexLabel.Font = Enum.Font.GothamBold
            hexLabel.BackgroundTransparency = 1
            hexLabel.TextXAlignment = Enum.TextXAlignment.Left
            hexLabel.Parent = hexRow
            
            local hexBox = Instance.new("TextBox")
            hexBox.Size = UDim2.new(0, 160, 0, 30)
            hexBox.Position = UDim2.new(1, -170, 0.5, -15)
            hexBox.BackgroundColor3 = _themes[_currTheme].AccentLight
            hexBox.BackgroundTransparency = 0.4
            hexBox.Text = "#C8C3D7"
            hexBox.TextColor3 = _themes[_currTheme].Text
            hexBox.Font = Enum.Font.Gotham
            hexBox.TextSize = 12
            hexBox.Parent = hexRow
            Instance.new("UICorner", hexBox).CornerRadius = UDim.new(0, 6)
            
            hexBox.FocusLost:Connect(function()
                local hex = hexBox.Text:gsub("#", "")
                if #hex == 6 and hex:match("^[%x]+$") then
                    local r = tonumber(hex:sub(1,2), 16)
                    local g = tonumber(hex:sub(3,4), 16)
                    local b = tonumber(hex:sub(5,6), 16)
                    _fogColor = Color3.fromRGB(r,g,b)
                    Lighting.FogColor = _fogColor
                    if Lighting:FindFirstChild("Atmosphere") then
                        Lighting.Atmosphere.FogColor = _fogColor
                    end
                end
            end)
            
            table.insert(_uiElements, {
                type = "text",
                label = hexLabel
            })
            
            yOff = yOff + 40
            _makeSlider(panel, yOff, "Fog Intensity", 50, 0, 2000, 1, function(v)
                _fogIntensity = v
                Lighting.FogEnd = v
                Lighting.FogStart = math.round(v * 0.1)
            end)
            yOff = yOff + 44
            local reset = Instance.new("TextButton")
            reset.Size = UDim2.new(0.5, 0, 0, 32)
            reset.Position = UDim2.new(0.25, 0, 0, yOff)
            reset.BackgroundColor3 = _themes.Pink.AccentLight
            reset.BackgroundTransparency = 0.4
            reset.Text = "Reset Fog"
            reset.TextColor3 = _themes.Pink.Text
            reset.Font = Enum.Font.GothamBold
            reset.TextSize = 13
            reset.Parent = panel
            Instance.new("UICorner", reset).CornerRadius = UDim.new(0, 6)
            reset.MouseButton1Click:Connect(function()
                _fogColor = Color3.fromRGB(200, 195, 215)
                Lighting.FogColor = _fogColor
                if Lighting:FindFirstChild("Atmosphere") then
                    Lighting.Atmosphere.FogColor = _fogColor
                end
                Lighting.FogEnd = 500
                Lighting.FogStart = 50
                _fogIntensity = 500
                hexBox.Text = "#C8C3D7"
            end)
            yOff = yOff + 42
            panel.CanvasSize = UDim2.new(0, 0, 0, yOff + 20)
            
        elseif tabName == "Hitbox" then
            _makeToggle(panel, yOff, "Hitbox Expander", false, function(v) _hitbox = v end)
            yOff = yOff + 38
            _makeSlider(panel, yOff, "Head Size", 1, 0.01, 30, 0.01, function(v) _headSize = v end)
            yOff = yOff + 38
            _makeSlider(panel, yOff, "Transparency", 0.7, 0, 1, 0.01, function(v) _hitTrans = v end)
            yOff = yOff + 40
            _makeDropdown(panel, yOff, "Visual Color", {"Pink","Purple","Yellow","Green","Blue","Orange"}, 2, function(i,n)
                local map = {
                    Pink = Color3.fromRGB(255, 130, 180),
                    Purple = Color3.fromRGB(145, 100, 220),
                    Yellow = Color3.fromRGB(235, 175, 45),
                    Green = Color3.fromRGB(75, 175, 105),
                    Blue = Color3.fromRGB(70, 145, 220),
                    Orange = Color3.fromRGB(235, 120, 50)
                }
                _hitColor = map[n] or Color3.fromRGB(145, 100, 220)
            end)
            yOff = yOff + 40
            panel.CanvasSize = UDim2.new(0, 0, 0, yOff + 20)
            
        elseif tabName == "Misc" then
            _makeToggle(panel, yOff, "Speed Hack", false, function(v)
                _speed = v
                if not v then
                    _speedActive = false
                    if Player and Player.Character then
                        local h = Player.Character:FindFirstChild("Humanoid")
                        if h then h.WalkSpeed = 16 end
                    end
                end
            end)
            yOff = yOff + 38
            _makeSlider(panel, yOff, "Speed Value", 50, 16, 500, 1, function(v) _speedVal = v end)
            yOff = yOff + 38
            _makeKeybind(panel, yOff, "Speed Keybind", "X", function(v) _speedBind = v end)
            yOff = yOff + 40
            
            _makeToggle(panel, yOff, "Jump Boost", false, function(v)
                _jump = v
                if not v then
                    _jumpActive = false
                    if Player and Player.Character then
                        local h = Player.Character:FindFirstChild("Humanoid")
                        if h then h.JumpPower = 50 end
                    end
                end
            end)
            yOff = yOff + 38
            _makeSlider(panel, yOff, "Jump Value", 100, 30, 500, 1, function(v) _jumpVal = v end)
            yOff = yOff + 38
            _makeKeybind(panel, yOff, "Jump Keybind", "Z", function(v) _jumpBind = v end)
            yOff = yOff + 40
            
            _makeToggle(panel, yOff, "ESP", false, function(v)
                _esp = v
                if not v then
                    _espActive = false
                    _espBox = false
                    _espName = false
                else
                    _espActive = true
                end
            end)
            yOff = yOff + 38
            _makeToggle(panel, yOff, "ESP Boxes", false, function(v) _espBox = v end)
            yOff = yOff + 38
            _makeToggle(panel, yOff, "ESP Names", false, function(v) _espName = v end)
            yOff = yOff + 38
            _makeKeybind(panel, yOff, "ESP Toggle", "P", function(v) _espBind = v end)
            yOff = yOff + 40
            _makeDropdown(panel, yOff, "ESP Color", {"Pink","Purple","Yellow","Green","Blue","Orange"}, 2, function(i,n)
                local map = {
                    Pink = Color3.fromRGB(255, 130, 180),
                    Purple = Color3.fromRGB(145, 100, 220),
                    Yellow = Color3.fromRGB(235, 175, 45),
                    Green = Color3.fromRGB(75, 175, 105),
                    Blue = Color3.fromRGB(70, 145, 220),
                    Orange = Color3.fromRGB(235, 120, 50)
                }
                _espColor = map[n] or Color3.fromRGB(145, 100, 220)
            end)
            yOff = yOff + 40
            panel.CanvasSize = UDim2.new(0, 0, 0, yOff + 20)
            
        elseif tabName == "Camlock" then
            _makeToggle(panel, yOff, "Camlock", false, function(v)
                _camlock = v
                if not v then _camActive = false end
            end)
            yOff = yOff + 38
            _makeDropdown(panel, yOff, "Target Part", {"Head","Body","Closest Part"}, 1, function(i,v) _camPart = v end)
            yOff = yOff + 40
            _makeSlider(panel, yOff, "Smoothness", 0.3, 0, 1, 0.001, function(v) _camSmooth = v end)
            yOff = yOff + 38
            _makeDropdown(panel, yOff, "Activation Mode", {"Always","Hold","Toggle"}, 1, function(i,v) _camMode = v end)
            yOff = yOff + 40
            _makeKeybind(panel, yOff, "Activation Key", "C", function(v) _camBind = v end)
            yOff = yOff + 40
            panel.CanvasSize = UDim2.new(0, 0, 0, yOff + 20)
            
        elseif tabName == "Teleport" then
            _makeToggle(panel, yOff, "Mouse Teleport", false, function(v)
                _teleport = v
                if not v then _teleActive = false end
            end)
            yOff = yOff + 38
            _makeKeybind(panel, yOff, "Teleport Toggle", "T", function(v) _teleBind = v end)
            yOff = yOff + 44
            
            local info = Instance.new("TextLabel")
            info.Size = UDim2.new(0.9, 0, 0, 50)
            info.Position = UDim2.new(0.05, 0, 0, yOff)
            info.BackgroundTransparency = 1
            info.Text = "Click anywhere to teleport\nto that position (when enabled)."
            info.TextColor3 = _themes.Pink.Text
            info.Font = Enum.Font.Gotham
            info.TextSize = 12
            info.TextWrapped = true
            info.TextXAlignment = Enum.TextXAlignment.Center
            info.Parent = panel
            table.insert(_uiElements, {type = "text", label = info})
            
            yOff = yOff + 60
            panel.CanvasSize = UDim2.new(0, 0, 0, yOff + 20)
            
        elseif tabName == "Avatar" then
            _makeToggle(panel, yOff, "Headless", false, function(v)
                _headless = v
                if Player and Player.Character then
                    local head = Player.Character:FindFirstChild("Head")
                    local face = Player.Character:FindFirstChild("Face")
                    if head then head.Transparency = v and 1 or 0 end
                    if face then face.Transparency = v and 1 or 0 end
                end
            end)
            yOff = yOff + 40
            _makeToggle(panel, yOff, "Korblox (Left Leg)", false, function(v) _korblox = v end)
            yOff = yOff + 40
            panel.CanvasSize = UDim2.new(0, 0, 0, yOff + 20)
            
        elseif tabName == "Settings" then
            _makeKeybind(panel, yOff, "Menu Toggle", _menuKey, function(v) 
                _menuKey = v
            end)
            yOff = yOff + 44
            
            local kill = Instance.new("TextButton")
            kill.Name = "_kill"
            kill.Size = UDim2.new(0.6, 0, 0, 48)
            kill.Position = UDim2.new(0.2, 0, 0, yOff)
            kill.BackgroundColor3 = _themes.Pink.Accent
            kill.BackgroundTransparency = 0.15
            kill.Text = "KILL SWITCH"
            kill.TextColor3 = Color3.fromRGB(255, 255, 255)
            kill.Font = Enum.Font.GothamBold
            kill.TextSize = 18
            kill.Parent = panel
            
            local kCorner = Instance.new("UICorner")
            kCorner.CornerRadius = UDim.new(0, 12)
            kCorner.Parent = kill
            
            local kStroke = Instance.new("UIStroke")
            kStroke.Name = "_stroke"
            kStroke.Color = _themes.Pink.Accent:Lerp(Color3.fromRGB(255, 255, 255), 0.3)
            kStroke.Thickness = 2
            kStroke.Transparency = 0.5
            kStroke.Parent = kill
            
            _killBtn = kill
            
            kill.MouseButton1Click:Connect(function()
                _playClick()
                _kill()
            end)
            
            kill.MouseEnter:Connect(function()
                TweenService:Create(kill, TweenInfo.new(0.15), {BackgroundTransparency = 0.05}):Play()
                TweenService:Create(kStroke, TweenInfo.new(0.15), {Transparency = 0.1}):Play()
            end)
            kill.MouseLeave:Connect(function()
                TweenService:Create(kill, TweenInfo.new(0.15), {BackgroundTransparency = 0.15}):Play()
                TweenService:Create(kStroke, TweenInfo.new(0.15), {Transparency = 0.5}):Play()
            end)
            
            yOff = yOff + 58
            
            local info = Instance.new("TextLabel")
            info.Size = UDim2.new(0.9, 0, 0, 30)
            info.Position = UDim2.new(0.05, 0, 0, yOff)
            info.BackgroundTransparency = 1
            info.Text = "Completely uninjects and restores defaults."
            info.TextColor3 = _themes.Pink.Text
            info.Font = Enum.Font.Gotham
            info.TextSize = 12
            info.TextWrapped = true
            info.TextXAlignment = Enum.TextXAlignment.Center
            info.Parent = panel
            table.insert(_uiElements, {type = "text", label = info})
            
            yOff = yOff + 40
            panel.CanvasSize = UDim2.new(0, 0, 0, yOff + 20)
        end
    end
    
    btn.MouseEnter:Connect(function()
        _playHover()
    end)

    btn.MouseButton1Click:Connect(function()
        _playClick()
        _showPage(tabName)
    end)
end

--==================================================
-- RUN LOOPS
--==================================================

RunService.Heartbeat:Connect(function()
    if _speed and _speedActive then
        if Player and Player.Character then
            local h = Player.Character:FindFirstChild("Humanoid")
            if h and h.WalkSpeed ~= _speedVal then
                h.WalkSpeed = _speedVal
            end
        end
    end
    
    if _jump and _jumpActive then
        if Player and Player.Character then
            local h = Player.Character:FindFirstChild("Humanoid")
            if h and h.JumpPower ~= _jumpVal then
                h.JumpPower = _jumpVal
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if _camlock and _camActive then
        if not Player.Character then return end
        local target = _getCamTarget()
        if not target then return end
        local cf = CFrame.new(camera.CFrame.Position, target.Position)
        local smooth = math.clamp(_camSmooth, 0.001, 1)
        camera.CFrame = camera.CFrame:Lerp(cf, smooth)
    end
end)

RunService.RenderStepped:Connect(function()
    if _hitbox then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= Player and v.Character then
                pcall(function()
                    local root = v.Character:FindFirstChild("HumanoidRootPart")
                    if root then
                        root.Size = Vector3.new(_headSize, _headSize, _headSize)
                        root.Transparency = _hitTrans
                        root.BrickColor = BrickColor.new(_hitColor)
                        root.Material = "Neon"
                        root.CanCollide = false
                    end
                end)
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if Player and Player.Character then
        local char = Player.Character
        local lul = char:FindFirstChild("LeftUpperLeg")
        local lll = char:FindFirstChild("LeftLowerLeg")
        local lf = char:FindFirstChild("LeftFoot")
        
        if _korblox then
            if lul then lul.Transparency = 1 end
            if lll then lll.Transparency = 1 end
            if lf then lf.Transparency = 1 end
        else
            if lul then lul.Transparency = 0 end
            if lll then lll.Transparency = 0 end
            if lf then lf.Transparency = 0 end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if _esp and _espActive then
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= Player and not _isWhitelisted(v) and v.Character then
                pcall(function()
                    local root = v.Character:FindFirstChild("HumanoidRootPart")
                    if root then
                        if _espBox then
                            local box = Instance.new("BoxHandleAdornment")
                            box.Size = Vector3.new(4, 6, 2)
                            box.Color3 = _espColor
                            box.Transparency = 0.3
                            box.AlwaysOnTop = true
                            box.ZIndex = 0
                            box.Parent = root
                            game:GetService("Debris"):AddItem(box, 0.1)
                        end
                        if _espName then
                            local bill = Instance.new("BillboardGui")
                            bill.Size = UDim2.new(0, 120, 0, 24)
                            bill.Adornee = root
                            bill.AlwaysOnTop = true
                            bill.StudsOffset = Vector3.new(0, 3, 0)
                            local label = Instance.new("TextLabel")
                            label.Size = UDim2.new(1, 0, 1, 0)
                            label.Text = v.Name
                            label.TextColor3 = _espColor
                            label.BackgroundTransparency = 1
                            label.TextSize = 12
                            label.Font = Enum.Font.Gotham
                            label.Parent = bill
                            bill.Parent = root
                            game:GetService("Debris"):AddItem(bill, 0.1)
                        end
                    end
                end)
            end
        end
    else
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= Player and v.Character then
                for _, c in pairs(v.Character:GetDescendants()) do
                    if c:IsA("BoxHandleAdornment") or c:IsA("BillboardGui") and c.Name ~= "DefenseBBGUI" then
								c:Destroy()
                    end
                end
            end
        end
    end
end)

mouse.Button1Down:Connect(function()
    if _teleport and _teleActive and Player and Player.Character then
        local pos = mouse.Hit.Position
        local hrp = Player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(pos)
        end
    end
end)

UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.UserInputType == Enum.UserInputType.Keyboard then
        local key = input.KeyCode.Name
        
        if key == _menuKey then
            _main.Visible = not _main.Visible
            _uiVisible = _main.Visible
            return
        end
        
        if key == _speedBind and _speed then
            _speedActive = not _speedActive
        end
        
        if key == _jumpBind and _jump then
            _jumpActive = not _jumpActive
        end
        
        if key == _espBind then
            if _esp then
                _espActive = not _espActive
                if not _espActive then
                    _espBox = false
                    _espName = false
                end
            end
        end
        
        if key == _teleBind and _teleport then
            _teleActive = not _teleActive
        end
        
        if key == _camBind and _camlock then
            _camActive = not _camActive
        end
    end
end)

Player.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if _headless then
        local head = char:FindFirstChild("Head")
        local face = char:FindFirstChild("Face")
        if head then head.Transparency = 1 end
        if face then face.Transparency = 1 end
    end
end)

--==================================================
-- DRAGGING
--==================================================

_applyTheme("Pink")
_showPage("Settings")

local _dragging = false
local _dragStart, _startPos

_dragBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        _dragging = true
        _dragStart = input.Position
        _startPos = _main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and _dragging then
        local delta = input.Position - _dragStart
        _main.Position = UDim2.new(
            _startPos.X.Scale, _startPos.X.Offset + delta.X,
            _startPos.Y.Scale, _startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        _dragging = false
    end
end)

StarterGui:SetCore("SendNotification", {
    Title = "mels main",
    Text = "Whitelist tab added.",
    Duration = 3
})
