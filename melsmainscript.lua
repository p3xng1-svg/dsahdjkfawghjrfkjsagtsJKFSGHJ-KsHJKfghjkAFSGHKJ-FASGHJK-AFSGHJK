--!nolint
local APPROVED_USERS = {
    11190411720, 3667276935, 3634382316, 1595962073, 4902665834, 1252077,
    3082283831, 1257759394, 4244714520
}

local services = {
    Players = game:GetService("Players"),
    TweenService = game:GetService("TweenService"),
    UIS = game:GetService("UserInputService"),
    RunService = game:GetService("RunService"),
    Lighting = game:GetService("Lighting"),
    CoreGui = game:GetService("CoreGui"),
    StarterGui = game:GetService("StarterGui"),
    ReplicatedStorage = game:GetService("ReplicatedStorage"),
    SoundService = game:GetService("SoundService"),
    ContentProvider = game:GetService("ContentProvider"),
    Debris = game:GetService("Debris"),
    HttpService = game:GetService("HttpService"),
    MarketplaceService = game:GetService("MarketplaceService"),
    Stats = game:GetService("Stats"),
}

local LocalPlayer = services.Players.LocalPlayer

local function IsApproved(userId)
    for _, id in ipairs(APPROVED_USERS) do
        if id == userId then return true end
    end
    return false
end

if not IsApproved(LocalPlayer.UserId) then
    local inviteLink = "https://discord.gg/hB7Uz6xyX"
    if setclipboard then
        pcall(setclipboard, inviteLink)
    elseif toclipboard then
        pcall(toclipboard, inviteLink)
    elseif set_clipboard then
        pcall(set_clipboard, inviteLink)
    end
    LocalPlayer:Kick("tried stealing my script https://discord.gg/hB7Uz6xyX XO.")
    return
end

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local mouse = LocalPlayer:GetMouse()
local camera = workspace.CurrentCamera

local DAHOOD_DEFAULT_FOG = {
    FogColor = Color3.fromRGB(194, 194, 194),
    FogStart = 0,
    FogEnd = 1000,
    Atmosphere = {
        Color = Color3.fromRGB(199, 199, 199),
        Density = 0.3,
        Offset = 0,
        Glare = 0,
        Haze = 0,
        Decay = Color3.fromRGB(128, 128, 128),
    }
}

local state = {
    Current = "Baby Blue",
    Values = {},
    Elements = {},
    Pages = {},
    Buttons = {},
    ThemeButtons = {},
    SkinDropdowns = {},
    KillBtn = nil,
    Whitelist = { Users = {}, Rows = {}, ListFrame = nil, CountLabel = nil },
}

local themes = {
    ["Baby Blue"] = { Main = Color3.fromRGB(215, 235, 255), Sidebar = Color3.fromRGB(170, 210, 250), Content = Color3.fromRGB(238, 246, 255), Panel = Color3.fromRGB(200, 225, 250), Accent = Color3.fromRGB(120, 180, 240), AccentLight = Color3.fromRGB(200, 225, 250), Text = Color3.fromRGB(60, 120, 185), Stroke = Color3.fromRGB(160, 200, 240), Outline = Color3.fromRGB(75, 120, 175) },
    ["Baby Pink"] = { Main = Color3.fromRGB(255, 220, 235), Sidebar = Color3.fromRGB(255, 190, 215), Content = Color3.fromRGB(255, 240, 248), Panel = Color3.fromRGB(255, 210, 230), Accent = Color3.fromRGB(255, 150, 195), AccentLight = Color3.fromRGB(255, 215, 235), Text = Color3.fromRGB(220, 90, 150), Stroke = Color3.fromRGB(255, 180, 215), Outline = Color3.fromRGB(185, 85, 135) },
    Pink = { Main = Color3.fromRGB(255, 230, 240), Sidebar = Color3.fromRGB(255, 190, 215), Content = Color3.fromRGB(255, 245, 250), Panel = Color3.fromRGB(255, 235, 245), Accent = Color3.fromRGB(255, 130, 180), AccentLight = Color3.fromRGB(255, 220, 235), Text = Color3.fromRGB(255, 110, 165), Stroke = Color3.fromRGB(255, 150, 190), Outline = Color3.fromRGB(180, 70, 120) },
    Purple = { Main = Color3.fromRGB(235, 220, 255), Sidebar = Color3.fromRGB(190, 160, 235), Content = Color3.fromRGB(248, 243, 255), Panel = Color3.fromRGB(230, 215, 250), Accent = Color3.fromRGB(145, 100, 220), AccentLight = Color3.fromRGB(220, 200, 250), Text = Color3.fromRGB(120, 75, 190), Stroke = Color3.fromRGB(170, 125, 225), Outline = Color3.fromRGB(85, 55, 145) },
    Yellow = { Main = Color3.fromRGB(255, 245, 190), Sidebar = Color3.fromRGB(255, 220, 120), Content = Color3.fromRGB(255, 252, 230), Panel = Color3.fromRGB(255, 240, 185), Accent = Color3.fromRGB(235, 175, 45), AccentLight = Color3.fromRGB(255, 235, 160), Text = Color3.fromRGB(190, 130, 20), Stroke = Color3.fromRGB(245, 195, 70), Outline = Color3.fromRGB(160, 115, 20) },
    Green = { Main = Color3.fromRGB(220, 250, 225), Sidebar = Color3.fromRGB(150, 220, 170), Content = Color3.fromRGB(240, 255, 242), Panel = Color3.fromRGB(210, 245, 215), Accent = Color3.fromRGB(75, 175, 105), AccentLight = Color3.fromRGB(185, 235, 195), Text = Color3.fromRGB(50, 135, 75), Stroke = Color3.fromRGB(105, 195, 130), Outline = Color3.fromRGB(40, 110, 65) },
    Blue = { Main = Color3.fromRGB(220, 240, 255), Sidebar = Color3.fromRGB(150, 200, 245), Content = Color3.fromRGB(240, 250, 255), Panel = Color3.fromRGB(210, 235, 255), Accent = Color3.fromRGB(70, 145, 220), AccentLight = Color3.fromRGB(185, 220, 250), Text = Color3.fromRGB(45, 110, 185), Stroke = Color3.fromRGB(100, 165, 230), Outline = Color3.fromRGB(35, 90, 150) },
    Orange = { Main = Color3.fromRGB(255, 230, 205), Sidebar = Color3.fromRGB(255, 175, 120), Content = Color3.fromRGB(255, 245, 235), Panel = Color3.fromRGB(255, 220, 190), Accent = Color3.fromRGB(235, 120, 50), AccentLight = Color3.fromRGB(255, 205, 165), Text = Color3.fromRGB(190, 85, 25), Stroke = Color3.fromRGB(245, 145, 75), Outline = Color3.fromRGB(160, 75, 20) },
    ["Cotton Candy"] = { Main = Color3.fromRGB(255, 225, 245), Sidebar = Color3.fromRGB(220, 200, 255), Content = Color3.fromRGB(250, 240, 255), Panel = Color3.fromRGB(240, 215, 250), Accent = Color3.fromRGB(255, 155, 220), AccentLight = Color3.fromRGB(245, 220, 255), Text = Color3.fromRGB(190, 90, 200), Stroke = Color3.fromRGB(220, 165, 245), Outline = Color3.fromRGB(155, 85, 175) },
    ["Sunset"] = { Main = Color3.fromRGB(255, 215, 200), Sidebar = Color3.fromRGB(255, 160, 130), Content = Color3.fromRGB(255, 240, 230), Panel = Color3.fromRGB(255, 200, 175), Accent = Color3.fromRGB(240, 105, 90), AccentLight = Color3.fromRGB(255, 210, 190), Text = Color3.fromRGB(190, 65, 55), Stroke = Color3.fromRGB(245, 155, 130), Outline = Color3.fromRGB(160, 55, 45) },
    ["Mint Chip"] = { Main = Color3.fromRGB(215, 245, 235), Sidebar = Color3.fromRGB(150, 220, 200), Content = Color3.fromRGB(235, 252, 245), Panel = Color3.fromRGB(200, 240, 225), Accent = Color3.fromRGB(70, 180, 150), AccentLight = Color3.fromRGB(190, 235, 220), Text = Color3.fromRGB(45, 130, 105), Stroke = Color3.fromRGB(115, 205, 180), Outline = Color3.fromRGB(35, 110, 90) },
    ["Lavender Haze"] = { Main = Color3.fromRGB(235, 225, 255), Sidebar = Color3.fromRGB(195, 175, 245), Content = Color3.fromRGB(245, 240, 255), Panel = Color3.fromRGB(225, 210, 250), Accent = Color3.fromRGB(160, 120, 230), AccentLight = Color3.fromRGB(225, 210, 250), Text = Color3.fromRGB(115, 75, 185), Stroke = Color3.fromRGB(180, 145, 235), Outline = Color3.fromRGB(90, 60, 150) },
    ["Strawberry Lemonade"] = { Main = Color3.fromRGB(255, 235, 235), Sidebar = Color3.fromRGB(255, 210, 145), Content = Color3.fromRGB(255, 250, 235), Panel = Color3.fromRGB(255, 225, 200), Accent = Color3.fromRGB(255, 130, 150), AccentLight = Color3.fromRGB(255, 225, 200), Text = Color3.fromRGB(200, 80, 100), Stroke = Color3.fromRGB(255, 175, 175), Outline = Color3.fromRGB(180, 70, 90) },
    ["Ocean Breeze"] = { Main = Color3.fromRGB(205, 240, 250), Sidebar = Color3.fromRGB(130, 210, 235), Content = Color3.fromRGB(230, 248, 252), Panel = Color3.fromRGB(190, 230, 245), Accent = Color3.fromRGB(50, 165, 210), AccentLight = Color3.fromRGB(180, 225, 245), Text = Color3.fromRGB(35, 115, 155), Stroke = Color3.fromRGB(105, 195, 225), Outline = Color3.fromRGB(25, 90, 130) },
    ["Peach Fuzz"] = { Main = Color3.fromRGB(255, 230, 215), Sidebar = Color3.fromRGB(255, 185, 155), Content = Color3.fromRGB(255, 244, 235), Panel = Color3.fromRGB(255, 215, 195), Accent = Color3.fromRGB(245, 145, 115), AccentLight = Color3.fromRGB(255, 220, 205), Text = Color3.fromRGB(200, 95, 70), Stroke = Color3.fromRGB(250, 180, 155), Outline = Color3.fromRGB(170, 80, 55) },
}

local function _darken(color, amount)
    return Color3.new(
        math.clamp(color.R * (1 - amount), 0, 1),
        math.clamp(color.G * (1 - amount), 0, 1),
        math.clamp(color.B * (1 - amount), 0, 1)
    )
end

local function _inputColor()
    local t = themes[state.Current]
    return _darken(t.Panel, 0.12)
end

local function _makeStroke(parent)
    return nil
end

local _hoverSound = Instance.new("Sound")
_hoverSound.SoundId = "rbxassetid://9120299506"
_hoverSound.Volume = 0.18
_hoverSound.PlaybackSpeed = 2.0
_hoverSound.Parent = services.SoundService

local _clickSound = Instance.new("Sound")
_clickSound.SoundId = "rbxassetid://113397864512278"
_clickSound.Volume = 0.28
_clickSound.Parent = services.SoundService

task.spawn(function()
    pcall(function() services.ContentProvider:PreloadAsync({_hoverSound, _clickSound}) end)
end)

local function _play(sound, dur)
    if not sound then return end
    sound:Stop()
    sound.TimePosition = 0
    services.SoundService:PlayLocalSound(sound)
    if dur then task.delay(dur, function() if sound.IsPlaying then sound:Stop() end end) end
end
local function _playHover() _play(_hoverSound, 0.12) end
local function _playClick() _play(_clickSound, 0.08) end

local oldGui = services.CoreGui:FindFirstChild("_ui")
if oldGui then oldGui:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "_ui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = services.CoreGui

local settings = {
    Time = { Override = false, Target = services.Lighting.ClockTime },
    Silent = { Enabled = true, FOV = 1000, Spread = 100, Exclude = false, Wall = false, Knock = false, AimPart = "Head" },
    Camlock = {
        Enabled = false, ToggleKey = "C", Mode = "Toggle", AutoToggle = false,
        HitPart = "HumanoidRootPart", EasingStyle = "Quad", EasingDirection = "Out",
        FOVRadius = 0, ClosestPointMode = "Default", ClosestPointScale = 0,
        Smooth = 0, PullStrengthEnabled = false, PullStrengthBase = 0, PullStrengthMove = 0,
        PredictionEnabled = false, PredictionX = 0, PredictionY = 0, PredictionZ = 0,
        MaxDistance = 0,
        Conditions = { ForceField = false, Visible = false, Carried = false, Knocked = false, SelfKnocked = false },
    },
    Teleport = { Enabled = false, Bind = "T", Active = false },
    ESP = { Enabled = false, Bind = "P", Active = false, Box = false, Name = false, Color = Color3.fromRGB(145, 100, 220) },
    Speed = { Enabled = false, Value = 50, Active = false, Bind = "X" },
    Jump = { Enabled = false, Value = 100, Active = false, Bind = "Z" },
    Spider = { Enabled = false, Value = 55, Active = false, Bind = "Space" },
    Hitbox = { HeadSize = 1, Transparency = 0.7, Color = Color3.fromRGB(145, 100, 220), Enabled = false },
    Avatar = { Headless = false, Korblox = false },
    Fog = { Color = DAHOOD_DEFAULT_FOG.FogColor, Intensity = DAHOOD_DEFAULT_FOG.FogEnd, Contrast = 0 },
    FPS = { Unlock = false, Cap = 60, Show = true, Display = nil },
}

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
    local v1 = unpack or table.unpack
    if not LPH_OBFUSCATED or LPH_OBFUSCATED == nil then
        function LPH_JIT_MAX(...) return ... end
        function LPH_NO_VIRTUALIZE(...) return ... end
    end
    local Players = services.Players
    local Workspace = workspace
    local RunService = services.RunService
    local ReplicatedStorage = services.ReplicatedStorage
    local LocalPlayer = Players.LocalPlayer
    local rad = math.rad
    local new = CFrame.new
    local new2 = Vector3.new
    local _pcall = pcall
    local _xpcall = xpcall
    local wait = task.wait
    local function v16(p1)
        warn("[SkinChanger Error]:", (tostring(p1)))
        return p1
    end
    local SkinAssets = ReplicatedStorage:FindFirstChild("SkinAssets")
    local t1, t2, t3 = {}, {}, {}
    local u21
    function t1.Register(p2)
        local v36 = type(p2) ~= "table"
        if not v36 then v36 = type(p2.Name) ~= "string" end
        if v36 then return false end
        table.insert(t2, p2)
        if type(p2.GameIds) == "table" then
            for _, v in ipairs(p2.GameIds) do
                if type(v) == "number" then t3[v] = p2 end
            end
        end
        return true
    end
    function t1.HasFeature(p3, p4)
        if not p4 then p4 = t1.ResolveGameDefinition() end
        local v41 = not p4
        if not v41 then v41 = type(p4.Features) ~= "table" end
        if v41 then return false end
        return p4.Features[p3] == true
    end
    t1.ResolveGameDefinition = function() return u21 end
    local Register = t1.Register
    Register({
        Name = "Da Hood",
        GameIds = { 1008451066 },
        Features = { SkinChanger = true },
        Metadata = { UsesBodyEffects = true, KnockedValueName = "K.O", GrabConstraintName = "GRABBING_CONSTRAINT" },
        Remotes = { MainEvent = { Root = "ReplicatedStorage", Path = { "MainEvent" }, ClassName = "RemoteEvent", Timeout = 12 } },
        ShootGun = { Emulate = true, CleanLocalScripts = true, Remote = "MainEvent", Args = { "Handle", "MuzzlePos", "HitPosition", "HitInstance", "HitNormal" }, ServerTime = "Shotgun" }
    })
    u21 = t3[game.GameId]
    if not u21 then
        for _, v in ipairs(t2) do
            local Match = v.Match
            if Match then Match = type(v.Match) == "function" end
            if Match then
                local v30, v31 = _pcall(v.Match)
                if v30 then v30 = v31 == true end
                if v30 then break end
            end
        end
    end
    if t1.HasFeature("SkinChanger") then
        (function()
            local t13 = {
                value1 = function() return shared.Saved.GunModifiers.SkinChanger end,
                value2 = {}, value3 = {}, value4 = {},
                value5 = SkinAssets,
                value6 = ReplicatedStorage:FindFirstChild("SkinModules"),
                value7 = nil
            }
            local function v43(p5)
                local v77 = p5:lower():gsub(" ", "")
                local v78 = v77 == "goldenagetanto"
                if not v78 then v78 = v77 == "gpo-knife" end
                if not v78 then v78 = v77 == "gpo-knifeprestige" end
                if not v78 then v78 = v77 == "heaven" end
                if not v78 then v78 = v77 == "lovekukri" end
                if not v78 then v78 = v77 == "purpledagger" end
                if not v78 then v78 = v77 == "bluedagger" end
                if not v78 then v78 = v77 == "greendagger" or v77 == "reddagger" end
                return v78
            end
            local function v44(p6, p7)
                local t14 = {}
                local _next = next
                local v84, v85 = p6:GetDescendants()
                while true do
                    local v86
                    v85, v86 = _next(v84, v85)
                    if not v85 then break end
                    if v86:IsA("BasePart") then
                        local v87 = v86.Name == "Handle.R"
                        if not v87 then
                            v87 = p6 == v86.Parent
                            if v87 then v87 = v86.Name == "Handle" end
                        end
                        if not v87 then
                            local _skinclone = v86:GetAttribute("_skinclone")
                            if not _skinclone then
                                _skinclone = p7
                                if p7 then _skinclone = v86 == p7 or v86:IsDescendantOf(p7) end
                            end
                            if not _skinclone then
                                t14[v86] = { Transparency = v86.Transparency, LocalTransparencyModifier = v86.LocalTransparencyModifier }
                                v86.Transparency = 1
                                v86.LocalTransparencyModifier = 1
                            end
                        end
                    end
                end
                return t14
            end
            local function v45(p8)
                if not p8 then return end
                local _next = next
                local v93
                while true do
                    local v94
                    v93, v94 = _next(p8, v93)
                    if not v93 then break end
                    local v95 = v93
                    if v93 then v95 = v93.Parent if v95 then v95 = type(v94) == "table" end end
                    if v95 then
                        v93.Transparency = v94.Transparency
                        v93.LocalTransparencyModifier = v94.LocalTransparencyModifier
                    end
                end
            end
            local function v46(p9, p10)
                local v98 = t13.value3[p9]
                local v99 = p10
                if p10 then v99 = v98 and v98.hiddenParts end
                local v100 = v99 or nil
                if v98 then
                    if v98.track then v98.track:Stop() v98.track:Destroy() v98.track = nil end
                    if v98.welds then
                        local _next = next
                        local welds = v98.welds
                        local v103
                        while true do
                            local v104
                            v103, v104 = _next(welds, v103)
                            if not v103 then break end
                            if v104 then v104:Destroy() end
                        end
                    end
                    if v98.sounds then
                        local _next = next
                        local sounds = v98.sounds
                        local v107
                        while true do
                            local v108
                            v107, v108 = _next(sounds, v107)
                            if not v107 then break end
                            if v108 and v108.Parent then v108:Destroy() end
                        end
                    end
                    if not p10 then v45(v98.hiddenParts) v100 = nil end
                end
                local Default = p9:FindFirstChild("Default")
                if Default then
                    local _next = next
                    local v112, v113 = Default:GetChildren()
                    while true do
                        local v114
                        v113, v114 = _next(v112, v113)
                        if not v113 then break end
                        local v115 = v114.Name == "Handle.R"
                        if not v115 then v115 = v114:GetAttribute("_skinclone") end
                        if v115 then v114:Destroy() end
                    end
                end
                t13.value3[p9] = nil
                return v100
            end
            function t13.value8(p11, p12, p13)
                if not v43(p13) then return end
                if p11 ~= p12.Parent then return end
                local Humanoid = p11:FindFirstChild("Humanoid")
                local RightHand = p11:FindFirstChild("RightHand")
                if not Humanoid or not RightHand then return end
                local v121 = t13.value3[p12]
                local v122 = v121
                if v122 then
                    v122 = v121.welds
                    if v122 then v122 = #v121.welds > 0 end
                end
                if v122 then
                    local Default = p12:FindFirstChild("Default")
                    if Default then Default = p12:FindFirstChild("Default"):FindFirstChild("Handle.R") end
                    if Default and Default.Parent then
                        local Motor6D = Default:FindFirstChildOfClass("Motor6D")
                        if Motor6D then Motor6D.Part0 = RightHand end
                        if not v121.hiddenParts then
                            local v125
                            local _next = next
                            local v127, v128 = p12:FindFirstChild("Default"):GetChildren()
                            local v129
                            repeat
                                v128, v129 = _next(v127, v128)
                            until not v128 or v129:GetAttribute("_skinclone")
                            if v128 then v125 = v129 end
                            v121.hiddenParts = v44(p12, v125)
                        end
                        local Animator = Humanoid:FindFirstChildOfClass("Animator")
                        if Animator then
                            local v132 = p13:lower():gsub(" ", "")
                            local s1, s2
                            if v132 == "goldenagetanto" then s1 = "rbxassetid://13473404819" s2 = "rbxassetid://5917819099" end
                            if v132 == "gpo-knife" or v132 == "gpo-knifeprestige" then s1 = "rbxassetid://14014278925" s2 = "rbxassetid://4604390759" end
                            if v132 == "heaven" then s1 = "rbxassetid://14500266726" s2 = "rbxassetid://14489860007" end
                            if v132 == "purpledagger" then s1 = "rbxassetid://17824999722" s2 = "rbxassetid://17822743153" end
                            if v132 == "bluedagger" then s1 = "rbxassetid://17824995184" s2 = "rbxassetid://17822737046" end
                            if v132 == "greendagger" then s1 = "rbxassetid://17825004320" s2 = "rbxassetid://17822741762" end
                            if v132 == "reddagger" then s1 = "rbxassetid://17825008844" s2 = "rbxassetid://17822952417" end
                            if s1 then
                                if v121.track then v121.track:Stop() v121.track:Destroy() v121.track = nil end
                                local Animation = Instance.new("Animation")
                                Animation.AnimationId = s1
                                local track = Animator:LoadAnimation(Animation)
                                track.Looped = false
                                track:Play()
                                v121.track = track
                                Animation:Destroy()
                                track.Ended:Once(function()
                                    if v121.track == track then v121.track = nil end
                                    track:Destroy()
                                end)
                            end
                            if s2 then
                                local Sound = Instance.new("Sound")
                                Sound.SoundId = s2
                                Sound.Parent = Workspace
                                Sound:Play()
                                table.insert(v121.sounds, Sound)
                                Sound.Ended:Connect(function() Sound:Destroy() end)
                            end
                        end
                        return
                    end
                end
                local v138 = v46(p12, true)
                t13.value3[p12] = { track = nil, welds = {}, sounds = {}, hiddenParts = v138 }
                local v139 = t13.value3[p12]
                local Default = p12:FindFirstChild("Default")
                if not Default then return end
                if not v139.hiddenParts then v139.hiddenParts = v44(p12, nil) end
                local value6 = t13.value6
                if value6 then value6 = t13.value6:FindFirstChild("Knives") end
                if not value6 then return end
                local p13_2 = value6:FindFirstChild(p13)
                if not p13_2 then return end
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
                Motor6D.Parent = Part
                local v147, s3, s4
                local v149 = p13:lower():gsub(" ", "")
                if v149 == "goldenagetanto" then v147 = new(0, -0.2, -1.2) * CFrame.Angles(rad(90), rad(263.7), rad(180)) s3 = "rbxassetid://13473404819" s4 = "rbxassetid://5917819099" end
                if v149 == "gpo-knife" or v149 == "gpo-knifeprestige" then v147 = new(0, -0.32, -1.07) * CFrame.Angles(rad(90), rad(-97.4), rad(90)) s3 = "rbxassetid://14014278925" s4 = "rbxassetid://4604390759" end
                if v149 == "heaven" then v147 = new(-0.02, -0.82, 0.2) * CFrame.Angles(rad(64.42), rad(3.79), rad(0)) s3 = "rbxassetid://14500266726" s4 = "rbxassetid://14489860007" end
                if v149 == "lovekukri" then v147 = new(-0.14, 0.14, -1.62) * CFrame.Angles(rad(-90), rad(180), rad(-4.97)) end
                if v149 == "purpledagger" then v147 = new(-0.13, -0.24, -1.8) * CFrame.Angles(rad(89.05), rad(96.63), rad(180)) s3 = "rbxassetid://17824999722" s4 = "rbxassetid://17822743153" end
                if v149 == "bluedagger" then v147 = new(-0.13, -0.24, -1.8) * CFrame.Angles(rad(89.05), rad(96.63), rad(180)) s3 = "rbxassetid://17824995184" s4 = "rbxassetid://17822737046" end
                if v149 == "greendagger" then v147 = new(-0.13, -0.24, -1.07) * CFrame.Angles(rad(89.05), rad(96.63), rad(180)) s3 = "rbxassetid://17825004320" s4 = "rbxassetid://17822741762" end
                if v149 == "reddagger" then v147 = new(-0.13, -0.24, -1.07) * CFrame.Angles(rad(89.05), rad(96.63), rad(180)) s3 = "rbxassetid://17825008844" s4 = "rbxassetid://17822952417" end
                if not v147 then return end
                if clone:IsA("Model") then
                    if not clone.PrimaryPart then
                        local _next = next
                        local v152, v153 = clone:GetChildren()
                        local v154
                        repeat
                            v153, v154 = _next(v152, v153)
                        until not v153 or v154:IsA("BasePart")
                        if v153 then clone.PrimaryPart = v154 end
                    end
                    if clone.PrimaryPart then
                        local _next = next
                        local v157, v158 = clone:GetDescendants()
                        while true do
                            local v159
                            v158, v159 = _next(v157, v158)
                            if not v158 then break end
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
                if not Animator then Animator = Instance.new("Animator") Animator.Parent = Humanoid end
                if s3 then
                    local Animation = Instance.new("Animation")
                    Animation.AnimationId = s3
                    local track = Animator:LoadAnimation(Animation)
                    track.Looped = false
                    track:Play()
                    v139.track = track
                    Animation:Destroy()
                    track.Ended:Once(function()
                        if v139.track == track then v139.track = nil end
                        track:Destroy()
                    end)
                end
                if s4 then
                    local Sound = Instance.new("Sound")
                    Sound.SoundId = s4
                    Sound.Parent = Workspace
                    Sound:Play()
                    table.insert(v139.sounds, Sound)
                    Sound.Ended:Connect(function() Sound:Destroy() end)
                end
            end
            t13.value9 = nil
            local function v47()
                if t13.value7 then return t13.value7 end
                local value6 = t13.value6
                if value6 then value6 = t13.value6:IsA("ModuleScript") end
                if value6 then
                    t13.value9 = t13.value6:Clone()
                    local t15, v168 = _xpcall(require, v16, t13.value9)
                    if t15 then t13.value7 = v168 end
                end
                return t13.value7
            end
            local function v48(p14, p15)
                local v171 = v47()
                if not v171 then return nil end
                local v172 = v171[p14] or v171["[" .. p14:gsub("%[", ""):gsub("%]", "") .. "]"]
                if not v172 then return nil end
                return v172[p15] or v172[p15:gsub("-", " ")] or v172[p15:gsub("-", "")]
            end
            function t13.value10(p16, _, p18)
                if not t13.value6 then return nil end
                if p18 then
                    local v176 = p16:lower():gsub(" ", "")
                    local Knives = t13.value6:FindFirstChild("Knives")
                    if Knives then
                        local _next = next
                        local v180, v181 = Knives:GetChildren()
                        local v183
                        repeat
                            local g182 = false
                            repeat
                                while true do
                                    v181, v183 = _next(v180, v181)
                                    if not v181 then return nil end
                                    if v183:IsA("MeshPart") then break end
                                    if v183:IsA("Folder") or v183:IsA("Model") then
                                        local v184 = p16 == v183.Name
                                        if not v184 then v184 = v176 == v183.Name:lower():gsub(" ", "") end
                                        if v184 then
                                            local _next2 = next
                                            local v186, v187 = v183:GetChildren()
                                            local v188
                                            repeat
                                                v187, v188 = _next2(v186, v187)
                                            until not v187 or v188:IsA("MeshPart")
                                            if v187 then return v188 end
                                        end
                                    end
                                end
                                local v189 = p16 == v183.Name
                                if not v189 then v189 = v176 == v183.Name:lower():gsub(" ", "") end
                            until v189
                        until not g182
                        return v183
                    end
                    return nil
                end
                local Meshes = t13.value6:FindFirstChild("Meshes")
                if not Meshes then return nil end
                local t16 = { p16, p16:gsub(" ", ""), p16:gsub(" ", "_") }
                local _next = next
                local v193, v200
                repeat
                    local v196
                    repeat
                        local v195
                        v193, v195 = _next(t16, v193)
                        if not v193 then return nil end
                        v196 = Meshes:FindFirstChild(v195)
                    until v196
                    local _next3 = next
                    local v198, v199 = v196:GetChildren()
                    repeat
                        v199, v200 = _next3(v198, v199)
                    until not v199 or v200:IsA("MeshPart")
                until not v199
                return v200
            end
            local cFrame = CFrame.new(-0.00207519531, 0.0318723917, 0.0401077271, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            t13.value11 = { ["[Silencer]:Electric"] = cFrame, ["[Glock]:Electric"] = cFrame }
            function t13.value12(p19, p20, p21)
                local v204 = p21
                if p21 then v204 = p21.CFrame if v204 then v204 = typeof(p21.CFrame) == "CFrame" end end
                if v204 then return p21.CFrame end
                local v205 = t13.value11[p19.Name .. ":" .. p20]
                if not v205 then v205 = CFrame.new() end
                return v205
            end
            local function v51(p22, p23, p24)
                local t17 = {}
                local t18 = { Muzzle = true, Aim = true }
                local _next = next
                local v212, v213 = p22:GetDescendants()
                while true do
                    local v214
                    v213, v214 = _next(v212, v213)
                    if not v213 then break end
                    if v214:IsA("BasePart") then
                        local v215 = p24
                        if p24 then v215 = v214 == p24 or v214:IsDescendantOf(p24) end
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
                if not p28 or p28.TextureID == nil then return nil end
                local TextureID = p28.TextureID
                local v224 = typeof(TextureID) == "Instance"
                if v224 then v224 = TextureID:IsA("MeshPart") end
                if v224 then return TextureID end
                if not t13.value6 then return nil end
                local Meshes = t13.value6:FindFirstChild("Meshes")
                if not Meshes then return nil end
                local p29_2 = Meshes:FindFirstChild(p29)
                if not p29_2 then
                    p29_2 = Meshes:FindFirstChild(p29:gsub(" ", ""))
                    if not p29_2 then
                        local t19 = { p29:gsub(" ", "_") }
                        p29_2 = Meshes:FindFirstChild(v1(t19))
                        if not p29_2 then
                            local t20 = { p29:gsub("-", " ") }
                            p29_2 = Meshes:FindFirstChild(v1(t20))
                            if not p29_2 then p29_2 = Meshes:FindFirstChild(p29:gsub("-", "")) end
                        end
                    end
                end
                if not p29_2 then return nil end
                local v229 = type(TextureID) == "string" and TextureID or TextureID.Name
                if v229 and v229 ~= "" then
                    local v230 = p29_2:FindFirstChild(v229)
                    local v231 = v230
                    if v230 then v231 = v230:IsA("MeshPart") end
                    if v231 then return v230 end
                end
                return nil
            end
            function t13.value15(p30, p31)
                if not t13.value5 then return nil end
                local GunShootSounds = t13.value5:FindFirstChild("GunShootSounds")
                if not GunShootSounds then return nil end
                local p30_2 = GunShootSounds:FindFirstChild(p30)
                if not p30_2 then return nil end
                local p31_2 = p30_2:FindFirstChild(p31)
                if not p31_2 then
                    local t21 = { p31:gsub("-", " ") }
                    p31_2 = p30_2:FindFirstChild(v1(t21))
                    if not p31_2 then p31_2 = p30_2:FindFirstChild(p31:gsub("-", "")) end
                end
                local v238 = p31_2
                if p31_2 then v238 = p31_2:IsA("StringValue") end
                if v238 then return p31_2.Value end
                return nil
            end
            local function v52(p32, p33, p34)
                local v242 = not t13.value5
                if not v242 then v242 = not p32 or not p33 end
                if v242 then return end
                local v243 = t13.value2[p32]
                if not v243 then return end
                local GunHandleParticle = t13.value5:FindFirstChild("GunHandleParticle")
                if not GunHandleParticle then return end
                local p34_2 = GunHandleParticle:FindFirstChild(p34)
                if not p34_2 then
                    p34_2 = GunHandleParticle:FindFirstChild(p34:gsub("-", " "))
                    if not p34_2 then p34_2 = GunHandleParticle:FindFirstChild(p34:gsub("-", "")) end
                end
                if not p34_2 then return end
                local ParticleEmitter = p34_2:FindFirstChildOfClass("ParticleEmitter")
                if not ParticleEmitter then return end
                local clone = ParticleEmitter:Clone()
                clone.Parent = p33
                clone.Name = "\000"
                table.insert(v243.ClonedChildren, clone)
            end
            function t13.value16(p35)
                if not p35 or not t13.value2[p35] then return end
                v46(p35)
                local v249 = t13.value2[p35]
                if v249.Connections then
                    local _next = next
                    local Connections = v249.Connections
                    local v252
                    while true do
                        local v253
                        v252, v253 = _next(Connections, v252)
                        if not v252 then break end
                        if v253 and v253.Connected then v253:Disconnect() end
                    end
                end
                local v254
                local _next = next
                local v256 = v249.ClonedChildren or {}
                while true do
                    local v257
                    v254, v257 = _next(v256, v254)
                    if not v254 then break end
                    if v257 and v257.Parent then v257:Destroy() end
                end
                if v249.HiddenParts then
                    local _next4 = next
                    local HiddenParts = v249.HiddenParts
                    local v260
                    while true do
                        local v261
                        v260, v261 = _next4(HiddenParts, v260)
                        if not v260 then break end
                        if v260 and v260.Parent then v260.Transparency = v261 end
                    end
                end
                local Default = v249.Default
                if Default then Default = v249.Default.Parent end
                if Default then
                    local _next5 = next
                    local v264, v265 = v249.Default:GetChildren()
                    while true do
                        local v266
                        v265, v266 = _next5(v264, v265)
                        if not v265 then break end
                        if v266.Name == "\000" then v266:Destroy() end
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
                    if not v269 then break end
                    if v270.Name == "\000" then v270:Destroy() end
                end
                if v249.OriginalGripCFrame then _pcall(function() p35.GripCFrame = v249.OriginalGripCFrame end) end
                local ShootSound = v249.ShootSound
                if ShootSound then ShootSound = v249.OriginalShootSoundId end
                if ShootSound then v249.ShootSound.SoundId = v249.OriginalShootSoundId end
                local Handle = p35:FindFirstChild("Handle")
                if Handle then
                    Handle:SetAttribute("SkinName", v249.OriginalSkinName or "")
                    local _next7 = next
                    local v275, v276 = Handle:GetChildren()
                    while true do
                        local v277
                        v276, v277 = _next7(v275, v276)
                        if not v276 then break end
                        if v277.Name == "\000" then v277:Destroy() end
                    end
                end
                t13.value2[p35] = nil
            end
            function t13.value17(p36, p37)
                if not p36 then return end
                local v280 = t13.value2[p36]
                local g288, g303, g324
                if v280 then v280 = p37 == t13.value2[p36].SkinName end
                if v280 then return end
                local Handle = p36:FindFirstChild("Handle")
                if not Handle then return end
                local Default = p36:FindFirstChild("Default")
                local v283 = not Default
                if not v283 then v283 = not Default:IsA("MeshPart") end
                if v283 then
                    Default = Handle:FindFirstChildOfClass("MeshPart")
                    if not Default then
                        local _next = next
                        local v285, v286 = p36:GetDescendants()
                        local v287
                        repeat
                            v286, v287 = _next(v285, v286)
                        until not v286 or v287:IsA("MeshPart")
                        if v286 then Default = v287 end
                    end
                end
                if not Default then
                    local v289 = p36.Name:lower():find("knife") ~= nil
                    if not v289 then v289 = p36.Name == "[Knife]" end
                    if v289 then
                        if t13.value2[p36] then t13.value16(p36) end
                        local v290 = v48(p36.Name, p37)
                        local v291, v292 = _pcall(function() return p36.GripCFrame end)
                        local value2 = t13.value2
                        local v294 = Handle:GetAttribute("SkinName") or ""
                        local v295 = v291 and v292
                        if not v295 then v295 = CFrame.new() end
                        value2[p36] = { SkinName = p37, OriginalSkinName = v294, OriginalGripCFrame = v295, ClonedChildren = {}, Connections = {} }
                        Handle:SetAttribute("SkinName", p37)
                        local connection = Handle:GetAttributeChangedSignal("SkinName"):Connect(function()
                            if Handle:GetAttribute("SkinName") ~= p37 then Handle:SetAttribute("SkinName", p37) end
                        end)
                        table.insert(t13.value2[p36].Connections, connection)
                        local v297 = v290
                        if v297 then v297 = v290.CFrame if v297 then v297 = typeof(v290.CFrame) == "CFrame" end end
                        if v297 then _pcall(function() p36.GripCFrame = v290.CFrame end) end
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
                until not v301 or v302:IsA("Sound") and (v302.Name == "Shoot" or v302.Name == "ShootSound")
                if v301 then v298 = v302 end
                if t13.value2[p36] then t13.value16(p36) end
                local value2 = t13.value2
                local TextureID = Default.TextureID
                local DefaultTransparency = Default.Transparency
                local v308 = Handle:GetAttribute("SkinName") or ""
                local v309 = Default
                local v310 = v298 and v298.SoundId or nil
                value2[p36] = { SkinName = p37, OriginalTextureID = TextureID, OriginalTransparency = DefaultTransparency, OriginalSkinName = v308, Default = v309, ShootSound = v298, OriginalShootSoundId = v310, ClonedChildren = {}, Connections = {}, HiddenParts = {} }
                Handle:SetAttribute("SkinName", p37)
                local connection = Handle:GetAttributeChangedSignal("SkinName"):Connect(function()
                    if Handle:GetAttribute("SkinName") ~= p37 then Handle:SetAttribute("SkinName", p37) end
                end)
                table.insert(t13.value2[p36].Connections, connection)
                local v312 = p36.Name:lower():find("knife") ~= nil
                if not v312 then v312 = p36.Name == "[Knife]" end
                local v313 = p36.Name:lower():sub(2, -2)
                local v314 = v48(p36.Name, p37)
                local v315
                local v316 = not v312 and t13.value14(v314, p37) or nil
                if v312 then
                    if not v43(p37) then v315 = t13.value10(p37, nil, true) end
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
                                    if not p37_2 then p37_2 = Meshes:FindFirstChild(p37:gsub("-", "")) end
                                end
                            end
                        end
                        if p37_2 then v315 = if not p37_2:IsA("MeshPart") then p37_2:GetChildren() else p37_2 end
                    end
                end
                if not v316 and v315 then
                    local v320 = typeof(v315) == "Instance"
                    if v320 then v320 = v315:IsA("MeshPart") end
                    if v320 then
                        v316 = v315
                    elseif type(v315) == "table" then
                        local _next8 = next
                        local v322
                        local v323
                        repeat
                            repeat
                                v322, v323 = _next8(v315, v322)
                                if not v322 then g324 = true end
                                if g324 then break end
                                local v325 = typeof(v323) == "Instance"
                                if v325 then v325 = v323:IsA("MeshPart") end
                            until v325
                            if g324 then break end
                            if v323.Name == p36.Name then v316 = v323 g324 = true end
                            if g324 then break end
                            local v326 = v323.Name:lower()
                            if v326:find("rpg") and v313 == "rpg" then v316 = v323 g324 = true end
                            if g324 then break end
                            if v326:find("aug") and v313 == "aug" then v316 = v323 g324 = true end
                            if g324 then break end
                            if v326:find("tac") and v313 == "tacticalshotgun" then v316 = v323 g324 = true end
                            if g324 then break end
                            if v326:find("rev") and v313 == "revolver" then v316 = v323 g324 = true end
                            if g324 then break end
                            local v327 = v326:find("db")
                            if not v327 then v327 = v326:find("double") end
                            if v327 then v327 = v313 == "double-barrel sg" or v313 == "double-barrelsg" end
                            if v327 then v316 = v323 g324 = true end
                            if g324 then break end
                            if v326:find("knife") and v312 then v316 = v323 g324 = true end
                            if g324 then break end
                            if v326:find("rifle") and v313 == "rifle" then v316 = v323 g324 = true end
                            if g324 then break end
                            if v326:find("flame") and v313 == "flamethrower" then v316 = v323 g324 = true end
                            if g324 then break end
                            if v326:find("drum") and v313 == "drumgun" then v316 = v323 g324 = true end
                            if g324 then break end
                            if v326:find("ak") and v313 == "ak47" then v316 = v323 g324 = true end
                            if g324 then break end
                            if v326:find("smg") and v313 == "smg" then v316 = v323 g324 = true end
                            if g324 then break end
                            if v326:find("lmg") and v313 == "lmg" then v316 = v323 g324 = true end
                            if g324 then break end
                            if v326:find("p90") and v313 == "p90" then v316 = v323 g324 = true end
                            if g324 then break end
                            if v326 == "ar" and v313 == "ar" then v316 = v323 g324 = true end
                            if g324 then break end
                            local v328 = v313 == "silencerar"
                            if v328 then v328 = v326:find("silencerar") or v326:find("silencedar") end
                            if v328 then v316 = v323 g324 = true end
                            if g324 then break end
                            local v329 = v313 == "silencer"
                            if v329 then
                                v329 = v326:find("silencer")
                                if v329 then
                                    v329 = not v326:find("silencerar")
                                    if v329 then v329 = not v326:find("silencedar") end
                                end
                            end
                            if v329 then v316 = v323 g324 = true end
                            if g324 then break end
                            local v330 = v313 == "silencer"
                            if v330 then v330 = v326:find("supp") or v326 == "sil" end
                            if v330 then v316 = v323 g324 = true end
                            if g324 then break end
                            local v331 = v313 == "silencer"
                            if v331 then v331 = v326:find("glock") end
                            if v331 then v316 = v323 g324 = true end
                            if g324 then break end
                            if v326:find("glock") and v313 == "glock" then v316 = v323 g324 = true end
                            if g324 then break end
                        until v326:find("deagle") and v313 == "deagle"
                        if not g324 then v316 = v323 end
                        g324 = false
                        if not v316 then
                            v316 = t13.value10(p37, p36.Name, false)
                            if not v316 then v316 = t13.value10(p37, v313, false) end
                            if not v316 then v316 = t13.value10(p37, "[" .. v313 .. "]", false) end
                        end
                        if not v316 then
                            local v332 = v313:gsub("[^%w]", "")
                            local t23 = {}
                            local _next9 = next
                            local v335
                            while true do
                                local v336
                                v335, v336 = _next9(v315, v335)
                                if not v335 then break end
                                local v337 = typeof(v336) == "Instance"
                                if v337 then v337 = v336:IsA("MeshPart") end
                                if v337 then
                                    local v338 = v336.Name:lower():gsub("[^%w]", "")
                                    if v338 == v332 or v338:find(v332, 1, true) then table.insert(t23, v336) end
                                end
                            end
                            if #t23 > 0 then v316 = t23[1] end
                        end
                    end
                end
                if not v316 and not v312 then
                    v316 = t13.value10(p37, p36.Name, false)
                    if not v316 then v316 = t13.value10(p37, v313, false) end
                    if not v316 then v316 = t13.value10(p37, "[" .. v313 .. "]", false) end
                end
                if v316 then
                    local v339 = t13.value12(p36, p37, v314)
                    local v340 = t13.value13(Default, v316, v339)
                    t13.value2[p36].HiddenParts = v51(p36, Default, v340)
                    table.insert(t13.value2[p36].ClonedChildren, v340)
                else
                    local v341 = v314
                    if v341 then v341 = v314.TextureID end
                    if v341 then
                        local TextureID2 = v314.TextureID
                        local v343 = typeof(TextureID2) == "Instance"
                        if v343 then v343 = TextureID2:IsA("MeshPart") end
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
                        if not v312 then t13.value16(p36) return end
                        if v43(p37) then return end
                        t13.value2[p36].OriginalLTM = Default.LocalTransparencyModifier
                        Default.LocalTransparencyModifier = 1
                        local v348 = v314
                        if v348 then v348 = v314.CFrame if v348 then v348 = typeof(v314.CFrame) == "CFrame" end end
                        if v348 then
                            local v349, v350 = _pcall(function() return p36.GripCFrame end)
                            local v351 = t13.value2[p36]
                            local v352 = v349 and v350
                            if not v352 then v352 = CFrame.new() end
                            v351.OriginalGripCFrame = v352
                            _pcall(function() p36.GripCFrame = v314.CFrame end)
                        end
                    end
                end
                v52(p36, Handle, p37)
                local v405 = t13.value15(p36.Name, p37)
                if v405 and t13.value2[p36].ShootSound then
                    t13.value2[p36].ShootSound.SoundId = v405
                end
            end
            local function v53(p38)
                local v408 = t13.value1()
                if not v408.Enabled then return nil end
                local Skins = v408.Skins
                local v410 = Skins[p38.Name] or Skins["[" .. p38.Name:gsub("%[", ""):gsub("%]", "") .. "]"]
                local v411 = not v410
                if not v411 then
                    v411 = v410 == ""
                    if not v411 then v411 = v410 == "None" or v410 == "Default" end
                end
                if v411 then return nil end
                return v410
            end
            function t13.value18(p39)
                local v413 = v53(p39)
                local v414 = t13.value2[p39]
                if v413 == (v414 and v414.SkinName or nil) then return end
                if v414 then t13.value16(p39) end
                if not v413 then t13.value4[p39] = nil return end
                t13.value4[p39] = v413
                local v415 = p39.Name:lower():find("knife") ~= nil
                if not v415 then v415 = p39.Name == "[Knife]" end
                if v415 and v43(v413) then
                    if t13.value2[p39] then t13.value16(p39) end
                    local Handle = p39:FindFirstChild("Handle")
                    if not Handle then return end
                    local value2 = t13.value2
                    local v418 = Handle:GetAttribute("SkinName") or ""
                    value2[p39] = { SkinName = v413, OriginalSkinName = v418, ClonedChildren = {}, Connections = {} }
                    Handle:SetAttribute("SkinName", v413)
                    local connection = Handle:GetAttributeChangedSignal("SkinName"):Connect(function()
                        if Handle:GetAttribute("SkinName") ~= v413 then Handle:SetAttribute("SkinName", v413) end
                    end)
                    table.insert(t13.value2[p39].Connections, connection)
                    v52(p39, Handle, v413)
                    local v420 = not t13.value3[p39]
                    if not v420 then v420 = not t13.value3[p39].hiddenParts end
                    if v420 then
                        t13.value3[p39] = t13.value3[p39] or {}
                        t13.value3[p39].hiddenParts = v44(p39, nil)
                    end
                    local connection3 = p39.Equipped:Connect(function()
                        if not t13.value2[p39] then return end
                        if p39.Parent ~= LocalPlayer.Character then return end
                        t13.value8(p39.Parent, p39, v413)
                    end)
                    table.insert(t13.value2[p39].Connections, connection3)
                    if p39.Parent == LocalPlayer.Character then t13.value8(LocalPlayer.Character, p39, v413) end
                else
                    t13.value17(p39, v413)
                    if not t13.value2[p39] then return end
                    local connection = p39.Equipped:Connect(function()
                        if not t13.value2[p39] then return end
                        if p39.Parent ~= LocalPlayer.Character then return end
                        t13.value17(p39, v413)
                    end)
                    if not t13.value2[p39].Connections then t13.value2[p39].Connections = {} end
                    table.insert(t13.value2[p39].Connections, connection)
                    if p39.Parent == LocalPlayer.Character then t13.value17(p39, v413) end
                end
            end
            local function v54(p40)
                if not p40 then return end
                local _next = next
                local v430, v431 = p40:GetChildren()
                while true do
                    local v432
                    v431, v432 = _next(v430, v431)
                    if not v431 then break end
                    if v432:IsA("Tool") then t13.value18(v432) end
                end
                p40.ChildAdded:Connect(function(child)
                    if child:IsA("Tool") then wait(0.1) t13.value18(child) end
                end)
            end
            local function v55(p41)
                if not p41 then return end
                local _next = next
                local v435, v436 = p41:GetChildren()
                while true do
                    local v437
                    v436, v437 = _next(v435, v436)
                    if not v436 then break end
                    if v437:IsA("Tool") then t13.value18(v437) end
                end
                p41.ChildAdded:Connect(function(child)
                    if child:IsA("Tool") then wait(0.1) t13.value18(child) end
                end)
            end
            v47()
            local Character = LocalPlayer.Character
            if not Character then Character = LocalPlayer.CharacterAdded:Wait() end
            local Backpack = LocalPlayer:WaitForChild("Backpack", 5)
            v54(Character)
            if Backpack then v55(Backpack) end
            LocalPlayer.CharacterAdded:Connect(function(character)
                wait(0.5)
                v54(character)
                local Backpack2 = LocalPlayer:WaitForChild("Backpack", 5)
                if Backpack2 then v55(Backpack2) end
            end)
            function t13.value19()
                local Character3 = LocalPlayer.Character
                if Character3 then
                    local _next = next
                    local v442, v443 = Character3:GetChildren()
                    while true do
                        local v444
                        v443, v444 = _next(v442, v443)
                        if not v443 then break end
                        if v444:IsA("Tool") then t13.value18(v444) end
                    end
                end
                local Backpack3 = LocalPlayer:FindFirstChildOfClass("Backpack")
                if Backpack3 then
                    local _next = next
                    local v448, v449 = Backpack3:GetChildren()
                    while true do
                        local v450
                        v449, v450 = _next(v448, v449)
                        if not v449 then break end
                        if v450:IsA("Tool") then t13.value18(v450) end
                    end
                end
                local v451
                local _next = next
                local value4 = t13.value4
                while true do
                    v451 = _next(value4, v451)
                    if not v451 then break end
                    if not v451.Parent then t13.value4[v451] = nil end
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
                        if not v458 then break end
                        str ..= v458 .. tostring(v459)
                    end
                end                if str ~= t13.value20 then t13.value19() end
            end)
        end)()
    end
    skinLoaderLoaded = true
end)

local weaponConfigs = {
    ['[Double-Barrel SG]'] = { name = "Double-Barrel SG", skins = { "Default", "Valentine", "Galaxy", "Luck", "Inferno", "Red Hot", "Christmas Wrap", "Golden Age", "Electric", "Golden", "Shadow" } },
    ['[Revolver]'] = { name = "Revolver", skins = { "Default", "Valentine", "Galaxy", "Luck", "Inferno", "Red Hot", "Christmas Wrap", "Golden Age", "Electric", "Golden", "Shadow" } },
    ['[TacticalShotgun]'] = { name = "TacticalShotgun", skins = { "Default", "Valentine", "Galaxy", "Luck", "Inferno", "Red Hot", "Christmas Wrap", "Electric", "Golden", "Shadow" } },
    ['[Shotgun]'] = { name = "Shotgun", skins = { "Default", "Valentine", "Galaxy", "Luck", "Inferno", "Red Hot", "Christmas Wrap", "Electric", "Golden", "Shadow" } },
    ['[SilencerAR]'] = { name = "SilencerAR", skins = { "Default", "Valentine", "Galaxy", "Luck", "Inferno", "Red Hot", "Christmas Wrap", "Electric", "Golden", "Shadow" } },
    ['[Silencer]'] = { name = "Silencer", skins = { "Default", "Valentine", "Galaxy", "Luck", "Inferno", "Red Hot", "Christmas Wrap", "Electric", "Golden", "Shadow" } },
    ['[Glock]'] = { name = "Glock", skins = { "Default", "Valentine", "Galaxy", "Luck", "Inferno", "Red Hot", "Christmas Wrap", "Electric", "Golden", "Shadow" } },
    ['[AR]'] = { name = "AR", skins = { "Default", "Valentine", "Galaxy", "Luck", "Inferno", "Red Hot", "Christmas Wrap", "Electric", "Golden", "Shadow" } },
    ['[AK47]'] = { name = "AK47", skins = { "Default", "Valentine", "Galaxy", "Luck", "Inferno", "Red Hot", "Christmas Wrap", "Electric", "Golden", "Shadow" } },
    ['[SMG]'] = { name = "SMG", skins = { "Default", "Valentine", "Galaxy", "Luck", "Inferno", "Red Hot", "Christmas Wrap", "Electric", "Golden", "Shadow" } },
    ['[P90]'] = { name = "P90", skins = { "Default", "Valentine", "Galaxy", "Luck", "Inferno", "Red Hot", "Christmas Wrap", "Electric", "Golden", "Shadow" } },
    ['[LMG]'] = { name = "LMG", skins = { "Default", "Valentine", "Galaxy", "Luck", "Inferno", "Red Hot", "Christmas Wrap", "Electric", "Golden", "Shadow" } },
    ['[DrumGun]'] = { name = "DrumGun", skins = { "Default", "Valentine", "Galaxy", "Luck", "Inferno", "Red Hot", "Christmas Wrap", "Electric", "Golden", "Shadow" } },
    ['[AUG]'] = { name = "AUG", skins = { "Default", "Valentine", "Galaxy", "Luck", "Inferno", "Red Hot", "Christmas Wrap", "Electric", "Golden", "Shadow" } },
    ['[Rifle]'] = { name = "Rifle", skins = { "Default", "Valentine", "Galaxy", "Luck", "Inferno", "Red Hot", "Christmas Wrap", "Electric", "Golden", "Shadow" } },
    ['[Drum-Shotgun]'] = { name = "Drum-Shotgun", skins = { "Default", "Valentine", "Galaxy", "Luck", "Inferno", "Red Hot", "Christmas Wrap", "Electric", "Golden", "Shadow" } },
    ['[Deagle]'] = { name = "Deagle", skins = { "Default", "Valentine", "Galaxy", "Luck", "Inferno", "Red Hot", "Christmas Wrap", "Electric", "Golden", "Shadow" } },
    ['[Flintlock]'] = { name = "Flintlock", skins = { "Default", "Valentine", "Galaxy", "Luck", "Inferno", "Red Hot", "Christmas Wrap", "Electric", "Golden", "Shadow" } },
    ['[Knife]'] = { name = "Knife", skins = { "Default", "Golden", "Golden Age Tanto", "GPO-Knife", "GPO-Knife Prestige", "Heaven", "Love Kukri", "Purple Dagger", "Blue Dagger", "Green Dagger", "Red Dagger", "Portal", "Emerald Butterfly", "Boy", "Girl", "Dragon", "Void", "Wild West", "Iced Out", "Reptile", "Emerald", "Ribbon" } },
}

local _camAllHitPartOptions = {
    "Head", "UpperTorso", "LowerTorso", "HumanoidRootPart",
    "LeftUpperArm", "RightUpperArm", "LeftLowerArm", "RightLowerArm",
    "LeftUpperLeg", "RightUpperLeg", "LeftLowerLeg", "RightLowerLeg",
    "LeftFoot", "RightFoot", "LeftHand", "RightHand",
    "Closest Point", "Closest Part"
}

local function _camGetKeyCode(keyName)
    if typeof(keyName) == "EnumItem" then return keyName end
    local keyMap = {
        A = Enum.KeyCode.A, B = Enum.KeyCode.B, C = Enum.KeyCode.C, D = Enum.KeyCode.D,
        E = Enum.KeyCode.E, F = Enum.KeyCode.F, G = Enum.KeyCode.G, H = Enum.KeyCode.H,
        I = Enum.KeyCode.I, J = Enum.KeyCode.J, K = Enum.KeyCode.K, L = Enum.KeyCode.L,
        M = Enum.KeyCode.M, N = Enum.KeyCode.N, O = Enum.KeyCode.O, P = Enum.KeyCode.P,
        Q = Enum.KeyCode.Q, R = Enum.KeyCode.R, S = Enum.KeyCode.S, T = Enum.KeyCode.T,
        U = Enum.KeyCode.U, V = Enum.KeyCode.V, W = Enum.KeyCode.W, X = Enum.KeyCode.X,
        Y = Enum.KeyCode.Y, Z = Enum.KeyCode.Z,
    }
    return keyMap[keyName] or Enum.KeyCode[keyName] or Enum.KeyCode.C
end

local function _camIsKnocked(character)
    if not character then return false end
    local bodyEffects = character:FindFirstChild("BodyEffects")
    if bodyEffects then
        local ko = bodyEffects:FindFirstChild("K.O")
        return ko and ko.Value == true
    end
    return false
end

local function _camIsGrabbed(plr)
    return plr and plr.Character and plr.Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil
end

local _camRayParams = RaycastParams.new()
_camRayParams.FilterType = Enum.RaycastFilterType.Blacklist
_camRayParams.IgnoreWater = true

local function _camIsPartVisible(origin, targetPart, ignoreList)
    if not origin or not targetPart then return false end
    local direction = (targetPart.Position - origin).Unit
    local distance = (targetPart.Position - origin).Magnitude
    local filter = {LocalPlayer.Character}
    if ignoreList then
        for _, v in ipairs(ignoreList) do table.insert(filter, v) end
    end
    _camRayParams.FilterDescendantsInstances = filter
    local result = workspace:Raycast(origin, direction * distance, _camRayParams)
    if not result then return true end
    return result.Instance == targetPart or result.Instance:IsDescendantOf(targetPart.Parent)
end

local function _camGetClosestPartToMouse(char)
    local m = services.UIS:GetMouseLocation()
    local nearestPart, nearestDist = nil, math.huge
    local parts = { "Head", "UpperTorso", "LowerTorso", "LeftUpperArm", "LeftLowerArm", "LeftHand", "RightUpperArm", "RightLowerArm", "RightHand", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot", "RightUpperLeg", "RightLowerLeg", "RightFoot", "HumanoidRootPart" }
    for _, name in ipairs(parts) do
        local part = char:FindFirstChild(name)
        if part then
            local screenPos, onScreen = camera:WorldToViewportPoint(part.Position)
            if onScreen then
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(m.X, m.Y)).Magnitude
                if dist < nearestDist then nearestDist = dist nearestPart = part end
            end
        end
    end
    return nearestPart
end

local function _camGetClosestPointOnPart(Part, Scale)
    local PartCFrame = Part.CFrame
    local PartSize = Part.Size
    local PartSizeTransformed = PartSize * (Scale / 2)
    local MousePosition = services.UIS:GetMouseLocation()
    local CurrentCamera = workspace.CurrentCamera
    local MouseRay = CurrentCamera:ViewportPointToRay(MousePosition.X, MousePosition.Y)
    local Transformed = PartCFrame:PointToObjectSpace(MouseRay.Origin + (MouseRay.Direction * MouseRay.Direction:Dot(PartCFrame.Position - MouseRay.Origin)))
    if mouse.Target == Part then return Vector3.new(mouse.Hit.X, mouse.Hit.Y, mouse.Hit.Z) end
    return PartCFrame * Vector3.new(
        math.clamp(Transformed.X, -PartSizeTransformed.X, PartSizeTransformed.X),
        math.clamp(Transformed.Y, -PartSizeTransformed.Y, PartSizeTransformed.Y),
        math.clamp(Transformed.Z, -PartSizeTransformed.Z, PartSizeTransformed.Z)
    )
end

local function _camGetClosestPointOnPartBasic(Part)
    if Part then
        local MouseRay = mouse.UnitRay
        MouseRay = MouseRay.Origin + (MouseRay.Direction * (Part.Position - MouseRay.Origin).Magnitude)
        local Point = (MouseRay.Y >= (Part.Position - Part.Size / 2).Y and MouseRay.Y <= (Part.Position + Part.Size / 2).Y) and (Part.Position + Vector3.new(0, -Part.Position.Y + MouseRay.Y, 0)) or Part.Position
        local Check = RaycastParams.new()
        Check.FilterType = Enum.RaycastFilterType.Whitelist
        Check.FilterDescendantsInstances = {Part}
        local Ray = workspace:Raycast(MouseRay, (Point - MouseRay), Check)
        if mouse.Target == Part then return mouse.Hit.Position end
        if Ray then return Ray.Position else return mouse.Hit.Position end
    end
end

local function _camGetHitPosition(Target)
    if not Target or not Target.Character then return nil end
    local Character = Target.Character
    local NearestPart = _camGetClosestPartToMouse(Character)
    if not NearestPart then return nil end
    local HitPosition
    if settings.Camlock.HitPart == "Closest Point" then
        if settings.Camlock.ClosestPointMode == "Default" then
            HitPosition = _camGetClosestPointOnPart(NearestPart, settings.Camlock.ClosestPointScale)
        else
            HitPosition = _camGetClosestPointOnPartBasic(NearestPart)
        end
    elseif settings.Camlock.HitPart == "Closest Part" then
        HitPosition = NearestPart.Position
    else
        local part = Character:FindFirstChild(settings.Camlock.HitPart)
        HitPosition = part and part.Position
    end
    if not HitPosition then return nil end
    if settings.Camlock.PredictionEnabled then
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        if RootPart then
            HitPosition = HitPosition + RootPart.Velocity * Vector3.new(settings.Camlock.PredictionX, settings.Camlock.PredictionY, settings.Camlock.PredictionZ)
        end
    end
    return HitPosition
end

local function _camGetBestTarget()
    local Closest = nil
    local Distance = settings.Camlock.FOVRadius > 0 and settings.Camlock.FOVRadius or math.huge
    local MousePosition = services.UIS:GetMouseLocation()
    for _, plr in ipairs(services.Players:GetPlayers()) do
        if plr ~= LocalPlayer and not state.Whitelist.Users[plr.UserId] and plr.Character then
            local Character = plr.Character
            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
            if HumanoidRootPart then
                local Position, OnScreen = camera:WorldToViewportPoint(HumanoidRootPart.Position)
                if OnScreen then
                    local skip = false
                    if settings.Camlock.Conditions.ForceField and Character:FindFirstChild("Forcefield") then skip = true end
                    if not skip and settings.Camlock.Conditions.Visible then
                        local localHead = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Head")
                        if localHead and not _camIsPartVisible(localHead.Position, HumanoidRootPart, {Character}) then skip = true end
                    end
                    if not skip and settings.Camlock.Conditions.Carried and _camIsGrabbed(plr) then skip = true end
                    if not skip and settings.Camlock.Conditions.Knocked and _camIsKnocked(Character) then skip = true end
                    if not skip and settings.Camlock.Conditions.SelfKnocked and _camIsKnocked(LocalPlayer.Character) then skip = true end
                    if not skip and settings.Camlock.MaxDistance > 0 then
                        local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if myRoot and (myRoot.Position - HumanoidRootPart.Position).Magnitude > settings.Camlock.MaxDistance then skip = true end
                    end
                    if not skip then
                        local Magnitude = (Vector2.new(Position.X, Position.Y) - MousePosition).Magnitude
                        if Magnitude < Distance then Closest = plr Distance = Magnitude end
                    end
                end
            end
        end
    end
    return Closest
end

local function _camIsHoldingGun()
    local char = LocalPlayer.Character
    if not char then return false end
    local tool = char:FindFirstChildOfClass("Tool")
    if not tool then return false end
    if tool:FindFirstChild("Ammo") then return true end
    if tool:FindFirstChild("Magazine") then return true end
    local gunModule = services.ReplicatedStorage:FindFirstChild("Modules")
    if gunModule then
        local gunHandler = gunModule:FindFirstChild("GunHandler")
        if gunHandler then
            local success, module = pcall(function() return require(gunHandler) end)
            if success and module and module.getGun then
                local success2, gun = pcall(function() return module.getGun(tool) end)
                if success2 and gun then return true end
            end
        end
    end
    return false
end

local _Camlock = { Target = nil, Active = false, Connection = nil }

local function _camUpdate()
    if not settings.Camlock.Enabled then
        _Camlock.Active = false
        _Camlock.Target = nil
        return
    end
    if settings.Camlock.AutoToggle then
        if not _camIsHoldingGun() then _Camlock.Active = false _Camlock.Target = nil return end
        if not _Camlock.Active or not _Camlock.Target or not _Camlock.Target.Character then
            local target = _camGetBestTarget()
            if target then _Camlock.Target = target _Camlock.Active = true else _Camlock.Active = false _Camlock.Target = nil end
            return
        end
    else
        if not _Camlock.Active then return end
    end
    if not _Camlock.Active then return end
    if not _Camlock.Target or not _Camlock.Target.Character then _Camlock.Active = false return end
    local Character = _Camlock.Target.Character
    if not Character:FindFirstChild("HumanoidRootPart") then _Camlock.Active = false return end
    if settings.Camlock.Conditions.ForceField and Character:FindFirstChild("Forcefield") then return end
    if settings.Camlock.Conditions.Knocked and _camIsKnocked(Character) then return end
    if settings.Camlock.Conditions.SelfKnocked and _camIsKnocked(LocalPlayer.Character) then return end
    if settings.Camlock.Conditions.Carried and _camIsGrabbed(_Camlock.Target) then return end
    local HitPosition = _camGetHitPosition(_Camlock.Target)
    if not HitPosition then return end
    local Smoothing = settings.Camlock.Smooth
    if settings.Camlock.PullStrengthEnabled then
        local RootPart = Character:FindFirstChild("HumanoidRootPart")
        if RootPart then
            if RootPart.Velocity.Magnitude > 15 then
                Smoothing = settings.Camlock.PullStrengthMove
            else
                Smoothing = settings.Camlock.PullStrengthBase
            end
        end
    end
    local EasedSmoothing = services.TweenService:GetValue(Smoothing, Enum.EasingStyle[settings.Camlock.EasingStyle], Enum.EasingDirection[settings.Camlock.EasingDirection])
    camera.CFrame = camera.CFrame:Lerp(CFrame.new(camera.CFrame.Position, HitPosition), EasedSmoothing)
end

local function _camEnable()
    if not settings.Camlock.Enabled then return end
    local target = _camGetBestTarget()
    if target then
        _Camlock.Target = target
        _Camlock.Active = true
        if not _Camlock.Connection then _Camlock.Connection = services.RunService.RenderStepped:Connect(_camUpdate) end
    end
end

local function _camDisable()
    _Camlock.Active = false
    _Camlock.Target = nil
end

if not _Camlock.Connection then
    _Camlock.Connection = services.RunService.RenderStepped:Connect(_camUpdate)
end

local function _checkKnock(char)
    if not settings.Silent.Knock then return false end
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
    for _, pName in ipairs(parts) do
        local p = char:FindFirstChild(pName)
        if p then
            local pos, on = camera:WorldToScreenPoint(p.Position)
            if on then
                local dist = (Vector2.new(pos.X, pos.Y) - mpos).Magnitude
                if dist < shortest then shortest = dist closest = p end
            end
        end
    end
    return closest or char:FindFirstChild("Head")
end

local function _getTarget()
    if not settings.Silent.Enabled then return nil end
    local mpos = Vector2.new(mouse.X, mouse.Y)
    local best = nil
    local bestDist = settings.Silent.FOV
    for _, v in pairs(services.Players:GetPlayers()) do
        if v ~= LocalPlayer and not state.Whitelist.Users[v.UserId] and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            if not _checkKnock(v.Character) then
                local part
                if settings.Silent.AimPart == "Closest Part" then
                    part = _getPart(v.Character)
                elseif settings.Silent.AimPart == "Body" then
                    part = v.Character:FindFirstChild("HumanoidRootPart")
                elseif settings.Silent.AimPart == "Left Leg" then
                    part = v.Character:FindFirstChild("LeftUpperLeg") or v.Character:FindFirstChild("LeftLeg")
                elseif settings.Silent.AimPart == "Right Leg" then
                    part = v.Character:FindFirstChild("RightUpperLeg") or v.Character:FindFirstChild("RightLeg")
                elseif settings.Silent.AimPart == "Left Arm" then
                    part = v.Character:FindFirstChild("LeftUpperArm") or v.Character:FindFirstChild("LeftArm")
                elseif settings.Silent.AimPart == "Right Arm" then
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
                            if settings.Silent.Wall then
                                local ray = Ray.new(camera.CFrame.Position, (part.Position - camera.CFrame.Position).Unit * 500)
                                local hit = workspace:FindPartOnRayWithIgnoreList(ray, {LocalPlayer.Character, camera})
                                if hit and hit:IsDescendantOf(v.Character) then bestDist = dist best = part end
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

local _gh, _old
local _ok, _res = pcall(function()
    return require(services.ReplicatedStorage.Modules.GunHandler)
end)
if _ok then
    _gh = _res
    _old = _gh.getAim
    _gh.getAim = function(origin, maxDist)
        if settings.Silent.Exclude then
            local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
            if tool and (tool.Name == "[Revolver]" or tool.Name == "Revolver") then return _old(origin, maxDist) end
        end
        if settings.Silent.Enabled then
            local target = _getTarget()
            if target then
                return (target.Position - origin).Unit, math.min((target.Position - origin).Magnitude, maxDist or 200)
            end
        end
        return _old(origin, maxDist)
    end
end

local _spreadLib
pcall(function()
    local gunHandlerScript = services.ReplicatedStorage:WaitForChild("Modules"):WaitForChild("GunHandler")
    _spreadLib = require(gunHandlerScript:WaitForChild("Spread"))
end)

if _spreadLib and type(_spreadLib.roll) == "function" then
    local _originalRoll = _spreadLib.roll
    local function _scaleVec(v)
        if typeof(v) ~= "Vector3" then return v end
        return v * (settings.Silent.Spread / 100)
    end
    _spreadLib.roll = function(...)
        if type(checkcaller) == "function" and checkcaller() then return _originalRoll(...) end
        local result = _originalRoll(...)
        if typeof(result) == "table" then
            local scaled = table.create(#result)
            for i = 1, #result do scaled[i] = _scaleVec(result[i]) end
            return scaled
        end
        return _scaleVec(result)
    end
end

local function _applyContrast(value)
    local atm = services.Lighting:FindFirstChildOfClass("Atmosphere")
    local baseDensity = DAHOOD_DEFAULT_FOG.Atmosphere.Density
    local baseBrightness = 2
    local baseAmbient = services.Lighting.Ambient
    local baseOutdoorAmbient = services.Lighting.OutdoorAmbient
    local baseColorShift = services.Lighting.ColorShift_Top

    if value == 0 then
        if atm then atm.Density = baseDensity end
        services.Lighting.Brightness = baseBrightness
        services.Lighting.Ambient = Color3.fromRGB(70, 70, 70)
        services.Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        services.Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0)
    elseif value > 0 then
        local t = value / 10
        if atm then atm.Density = math.clamp(baseDensity + (t * 0.5), 0, 1) end
        services.Lighting.Brightness = math.clamp(baseBrightness + (t * 1.5), 0, 10)
        services.Lighting.Ambient = Color3.fromRGB(
            math.clamp(70 + (t * 60), 0, 255),
            math.clamp(70 + (t * 60), 0, 255),
            math.clamp(70 + (t * 60), 0, 255)
        )
        services.Lighting.OutdoorAmbient = Color3.fromRGB(
            math.clamp(128 + (t * 80), 0, 255),
            math.clamp(128 + (t * 80), 0, 255),
            math.clamp(128 + (t * 80), 0, 255)
        )
        services.Lighting.ColorShift_Top = Color3.fromRGB(
            math.clamp(t * 40, 0, 255),
            math.clamp(t * 40, 0, 255),
            math.clamp(t * 40, 0, 255)
        )
    else
        local t = math.abs(value) / 20
        if atm then atm.Density = math.clamp(baseDensity - (t * 0.3), 0, 1) end
        services.Lighting.Brightness = math.clamp(baseBrightness - (t * 1.5), 0, 10)
        local targetGray = 128 - (t * 40)
        services.Lighting.Ambient = Color3.fromRGB(
            math.clamp(70 - (t * 40), 0, 255),
            math.clamp(70 - (t * 40), 0, 255),
            math.clamp(70 - (t * 40), 0, 255)
        )
        services.Lighting.OutdoorAmbient = Color3.fromRGB(
            math.clamp(128 - (t * 80), 0, 255),
            math.clamp(128 - (t * 80), 0, 255),
            math.clamp(128 - (t * 80), 0, 255)
        )
        services.Lighting.ColorShift_Top = Color3.fromRGB(
            math.clamp(-t * 30, -255, 0) + 255,
            math.clamp(-t * 30, -255, 0) + 255,
            math.clamp(-t * 30, -255, 0) + 255
        )
    end
end

local _main = Instance.new("Frame")
_main.Name = "_main"
_main.Size = UDim2.fromOffset(680, 480)
_main.Position = UDim2.fromScale(0.5, 0.5)
_main.AnchorPoint = Vector2.new(0.5, 0.5)
_main.BackgroundColor3 = themes["Baby Blue"].Main
_main.BorderSizePixel = 0
_main.Parent = ScreenGui
Instance.new("UICorner", _main).CornerRadius = UDim.new(0, 18)

local _dragBar = Instance.new("Frame")
_dragBar.Size = UDim2.new(1, 0, 0, 44)
_dragBar.BackgroundTransparency = 1
_dragBar.ZIndex = 100
_dragBar.Parent = _main

local _dragging, _dragStart, _startPos, _dragConn
_dragBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        _dragging = true
        _dragStart = input.Position
        _startPos = _main.Position
        if _dragConn then _dragConn:Disconnect() end
        _dragConn = services.UIS.InputChanged:Connect(function(move)
            if not _dragging then return end
            if move.UserInputType ~= Enum.UserInputType.MouseMovement and move.UserInputType ~= Enum.UserInputType.Touch then return end
            local delta = move.Position - _dragStart
            _main.Position = UDim2.new(_startPos.X.Scale, _startPos.X.Offset + delta.X, _startPos.Y.Scale, _startPos.Y.Offset + delta.Y)
        end)
    end
end)
services.UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        _dragging = false
        if _dragConn then _dragConn:Disconnect() _dragConn = nil end
    end
end)

local _sidebar = Instance.new("Frame")
_sidebar.Size = UDim2.new(0, 195, 1, 0)
_sidebar.BackgroundColor3 = themes["Baby Blue"].Sidebar
_sidebar.BorderSizePixel = 0
_sidebar.Parent = _main
Instance.new("UICorner", _sidebar).CornerRadius = UDim.new(0, 18)

local _sidebarFill = Instance.new("Frame")
_sidebarFill.Size = UDim2.new(0, 30, 1, 0)
_sidebarFill.Position = UDim2.new(1, -30, 0, 0)
_sidebarFill.BackgroundColor3 = themes["Baby Blue"].Sidebar
_sidebarFill.BorderSizePixel = 0
_sidebarFill.Parent = _sidebar

local _title = Instance.new("TextLabel")
_title.Size = UDim2.new(1, 0, 0, 45)
_title.Position = UDim2.new(0, 0, 0, 8)
_title.BackgroundTransparency = 1
_title.Text = "/melanie"
_title.TextColor3 = themes["Baby Blue"].Accent
_title.TextXAlignment = Enum.TextXAlignment.Center
_title.TextYAlignment = Enum.TextYAlignment.Center
_title.Font = Enum.Font.FredokaOne
_title.TextSize = 26
_title.Parent = _sidebar

local _tabHolder = Instance.new("ScrollingFrame")
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
_profile.Size = UDim2.new(1, -16, 0, 70)
_profile.Position = UDim2.new(0, 8, 1, -78)
_profile.BackgroundColor3 = themes["Baby Blue"].AccentLight
_profile.BorderSizePixel = 0
_profile.ZIndex = 10
_profile.Parent = _sidebar
Instance.new("UICorner", _profile).CornerRadius = UDim.new(0, 10)

local _avatar = Instance.new("ImageLabel")
_avatar.Size = UDim2.fromOffset(46, 46)
_avatar.Position = UDim2.new(0, 8, 0.5, -23)
_avatar.BackgroundTransparency = 1
_avatar.ZIndex = 11
_avatar.Parent = _profile
Instance.new("UICorner", _avatar).CornerRadius = UDim.new(1, 0)

local _displayName = Instance.new("TextLabel")
_displayName.Size = UDim2.new(1, -65, 0, 26)
_displayName.Position = UDim2.new(0, 60, 0.5, -18)
_displayName.BackgroundTransparency = 1
_displayName.Text = LocalPlayer.DisplayName
_displayName.TextColor3 = themes["Baby Blue"].Text
_displayName.Font = Enum.Font.FredokaOne
_displayName.TextSize = 14
_displayName.TextXAlignment = Enum.TextXAlignment.Left
_displayName.TextTruncate = Enum.TextTruncate.AtEnd
_displayName.ZIndex = 11
_displayName.Parent = _profile

local _username = Instance.new("TextLabel")
_username.Size = UDim2.new(1, -65, 0, 18)
_username.Position = UDim2.new(0, 60, 0.5, 8)
_username.BackgroundTransparency = 1
_username.Text = "@" .. LocalPlayer.Name
_username.TextColor3 = themes["Baby Blue"].Text
_username.Font = Enum.Font.Gotham
_username.TextSize = 10
_username.TextXAlignment = Enum.TextXAlignment.Left
_username.TextTruncate = Enum.TextTruncate.AtEnd
_username.ZIndex = 11
_username.Parent = _profile

task.spawn(function()
    local ok, img = pcall(function()
        return services.Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
    end)
    if ok then _avatar.Image = img end
end)

local _content = Instance.new("Frame")
_content.Size = UDim2.new(1, -215, 1, -30)
_content.Position = UDim2.new(0, 205, 0, 15)
_content.BackgroundColor3 = themes["Baby Blue"].Content
_content.BorderSizePixel = 0
_content.Parent = _main
Instance.new("UICorner", _content).CornerRadius = UDim.new(0, 14)

local _pageHolder = Instance.new("Frame")
_pageHolder.Size = UDim2.new(1, -30, 1, -65)
_pageHolder.Position = UDim2.new(0, 15, 0, 55)
_pageHolder.BackgroundTransparency = 1
_pageHolder.Parent = _content

local function _makeToggle(parent, y, text, key, val, cb)
    state.Values[key] = val
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -20, 0, 34)
    row.Position = UDim2.new(0, 10, 0, y)
    row.BackgroundTransparency = 1
    row.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.55, 0, 1, 0)
    label.Text = text
    label.TextColor3 = themes[state.Current].Text
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row

    local container = Instance.new("Frame")
    container.Size = UDim2.new(0, 44, 0, 24)
    container.Position = UDim2.new(1, -52, 0.5, -12)
    container.BackgroundColor3 = val and themes[state.Current].Accent or Color3.fromRGB(200, 200, 210)
    container.BackgroundTransparency = val and 0.3 or 0.4
    container.BorderSizePixel = 0
    container.Parent = row
    Instance.new("UICorner", container).CornerRadius = UDim.new(1, 0)

    local thumb = Instance.new("Frame")
    thumb.Size = UDim2.new(0, 18, 0, 18)
    thumb.Position = val and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
    thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    thumb.BorderSizePixel = 0
    thumb.Parent = container
    Instance.new("UICorner", thumb).CornerRadius = UDim.new(1, 0)

    local element = { type = "toggle", container = container, label = label, thumb = thumb, isOn = val, key = key }
    table.insert(state.Elements, element)

    local function anim(t)
        services.TweenService:Create(container, TweenInfo.new(0.2), {
            BackgroundColor3 = t and themes[state.Current].Accent or Color3.fromRGB(200, 200, 210),
            BackgroundTransparency = t and 0.3 or 0.4
        }):Play()
        services.TweenService:Create(thumb, TweenInfo.new(0.2), {
            Position = t and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
        }):Play()
    end

    local function toggle()
        val = not val
        element.isOn = val
        state.Values[key] = val
        _playClick()
        anim(val)
        if cb then cb(val) end
    end

    container.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then toggle() end
    end)
    thumb.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then toggle() end
    end)
    return row
end

local function _makeSlider(parent, y, text, key, val, min, max, step, cb)
    step = step or 0.001
    local function roundToStep(value)
        value = math.clamp(tonumber(value) or min, min, max)
        local steps = math.round((value - min) / step)
        local rounded = min + (steps * step)
        local stepText = string.format("%.10f", step):gsub("0+$", ""):gsub("%.$", "")
        local decimals = 0
        local decimalPart = stepText:match("%.(%d+)")
        if decimalPart then decimals = #decimalPart end
        if decimals > 0 then
            rounded = tonumber(string.format("%." .. decimals .. "f", rounded))
        else
            rounded = math.round(rounded)
        end
        return math.clamp(rounded, min, max)
    end
    local function formatValue(value)
        value = roundToStep(value)
        local stepText = string.format("%.10f", step):gsub("0+$", ""):gsub("%.$", "")
        local decimalPart = stepText:match("%.(%d+)")
        local decimals = decimalPart and #decimalPart or 0
        if decimals <= 0 then return tostring(math.round(value)) end
        local formatted = string.format("%." .. decimals .. "f", value)
        formatted = formatted:gsub("(%..-)0+$", "%1"):gsub("%.$", "")
        return formatted
    end

    val = roundToStep(val)
    state.Values[key] = val

    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -20, 0, 34)
    row.Position = UDim2.new(0, 10, 0, y)
    row.BackgroundTransparency = 1
    row.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.30, 0, 1, 0)
    label.Text = text
    label.TextColor3 = themes[state.Current].Text
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row

    local valBox = Instance.new("TextBox")
    valBox.Size = UDim2.new(0.14, 0, 0, 28)
    valBox.Position = UDim2.new(0.84, 0, 0.5, -14)
    valBox.Text = formatValue(val)
    valBox.TextColor3 = themes[state.Current].Accent
    valBox.TextSize = 13
    valBox.Font = Enum.Font.GothamBold
    valBox.BackgroundColor3 = _inputColor()
    valBox.BackgroundTransparency = 0.35
    valBox.BorderSizePixel = 0
    valBox.ClearTextOnFocus = false
    valBox.TextXAlignment = Enum.TextXAlignment.Center
    valBox.Parent = row
    Instance.new("UICorner", valBox).CornerRadius = UDim.new(0, 6)

    local trackC = Instance.new("Frame")
    trackC.Size = UDim2.new(0.48, 0, 1, 0)
    trackC.Position = UDim2.new(0.34, 0, 0, 0)
    trackC.BackgroundTransparency = 1
    trackC.Parent = row

    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, 0, 0.3, 0)
    track.Position = UDim2.new(0, 0, 0.5, -0.15)
    track.BackgroundColor3 = Color3.fromRGB(200, 200, 210)
    track.BackgroundTransparency = 0.5
    track.BorderSizePixel = 0
    track.Active = true
    track.Parent = trackC
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local p = math.clamp((val - min) / (max - min), 0, 1)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(p, 0, 1, 0)
    fill.BackgroundColor3 = themes[state.Current].Accent
    fill.BackgroundTransparency = 0.3
    fill.BorderSizePixel = 0
    fill.Parent = track
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local thumb = Instance.new("Frame")
    thumb.Size = UDim2.new(0, 16, 0, 16)
    thumb.Position = UDim2.new(p, -8, 0.5, -8)
    thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    thumb.BorderSizePixel = 0
    thumb.Parent = trackC
    Instance.new("UICorner", thumb).CornerRadius = UDim.new(1, 0)

    table.insert(state.Elements, {
        type = "slider", label = label, valLabel = valBox, valBox = valBox,
        fill = fill, thumb = thumb, track = track, key = key
    })

    local conn
    local dragging = false

    local function setValue(value)
        value = roundToStep(value)
        local np
        if max == min then np = 0 else np = math.clamp((value - min) / (max - min), 0, 1) end
        fill.Size = UDim2.new(np, 0, 1, 0)
        thumb.Position = UDim2.new(np, -8, 0.5, -8)
        valBox.Text = formatValue(value)
        state.Values[key] = value
        if cb then cb(value) end
    end

    local function update(input)
        local tPos = track.AbsolutePosition
        local tSize = track.AbsoluteSize
        if tSize.X <= 0 then return end
        local perc = math.clamp((input.Position.X - tPos.X) / tSize.X, 0, 1)
        local value = min + (perc * (max - min))
        setValue(value)
    end

    local function startDragging(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
        _playClick()
        dragging = true
        update(input)
        if conn then conn:Disconnect() end
        conn = services.UIS.InputChanged:Connect(function(move)
            if not dragging then return end
            if move.UserInputType == Enum.UserInputType.MouseMovement or move.UserInputType == Enum.UserInputType.Touch then
                update(move)
            end
        end)
    end

    track.InputBegan:Connect(startDragging)
    thumb.InputBegan:Connect(startDragging)
    services.UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            if conn then conn:Disconnect() conn = nil end
        end
    end)

    valBox.FocusLost:Connect(function()
        local typed = valBox.Text
        local negative = typed:sub(1, 1) == "-"
        local cleaned = typed:gsub("[^%d%.]", "")
        local firstDot = cleaned:find("%.")
        if firstDot then
            cleaned = cleaned:sub(1, firstDot) .. cleaned:sub(firstDot + 1):gsub("%.", "")
        end
        if negative then cleaned = "-" .. cleaned end
        local entered = tonumber(cleaned)
        if entered ~= nil then setValue(entered) else valBox.Text = formatValue(state.Values[key]) end
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
    label.Size = UDim2.new(0.3, 0, 1, 0)
    label.Text = text
    label.TextColor3 = themes[state.Current].Text
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row

    local main = Instance.new("TextButton")
    main.Size = UDim2.new(0, 160, 0, 30)
    main.Position = UDim2.new(1, -170, 0.5, -15)
    main.BackgroundColor3 = _inputColor()
    main.BackgroundTransparency = 0.4
    main.Text = items[def or 1]
    main.TextColor3 = themes[state.Current].Text
    main.Font = Enum.Font.Gotham
    main.TextSize = 12
    main.ZIndex = 5
    main.Parent = row
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 6)

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(0, 160, 0, math.min(#items * 28, 120))
    scroll.Position = UDim2.new(1, -170, 0, 34)
    scroll.BackgroundColor3 = themes[state.Current].Panel
    scroll.BackgroundTransparency = 0.1
    scroll.BorderSizePixel = 0
    scroll.Visible = false
    scroll.ZIndex = 6
    scroll.CanvasSize = UDim2.new(0, 0, 0, #items * 28)
    scroll.ScrollBarThickness = 2
    scroll.ScrollBarImageColor3 = themes[state.Current].Accent
    scroll.Parent = row
    Instance.new("UICorner", scroll).CornerRadius = UDim.new(0, 6)

    local scrollItems = {}
    for i, item in ipairs(items) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 26)
        btn.Position = UDim2.new(0, 0, 0, (i - 1) * 28)
        btn.BackgroundColor3 = themes[state.Current].Panel
        btn.BackgroundTransparency = 0.2
        btn.Text = "  " .. item
        btn.TextColor3 = themes[state.Current].Text
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 12
        btn.ZIndex = 7
        btn.Parent = scroll
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
        table.insert(scrollItems, btn)
        btn.MouseButton1Click:Connect(function()
            _playClick()
            main.Text = item
            scroll.Visible = false
            if cb then cb(i, item) end
        end)
    end

    table.insert(state.Elements, { type = "dropdown", label = label, main = main, scroll = scroll, items = scrollItems })
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
    label.TextColor3 = themes[state.Current].Text
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 90, 0, 30)
    btn.Position = UDim2.new(1, -100, 0.5, -15)
    btn.BackgroundColor3 = _inputColor()
    btn.BackgroundTransparency = 0.4
    btn.Text = def
    btn.TextColor3 = themes[state.Current].Text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.Parent = row
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    table.insert(state.Elements, { type = "keybind", label = label, btn = btn })

    local binding = false
    btn.MouseButton1Click:Connect(function()
        binding = true
        btn.BackgroundColor3 = themes[state.Current].Accent
        btn.BackgroundTransparency = 0.2
        btn.Text = "..."
    end)
    services.UIS.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if binding and input.UserInputType == Enum.UserInputType.Keyboard then
            btn.Text = input.KeyCode.Name
            btn.BackgroundColor3 = _inputColor()
            btn.BackgroundTransparency = 0.4
            binding = false
            if cb then cb(input.KeyCode.Name) end
        end
    end)
    return row
end

local function _makeText(parent, y, text, height)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -20, 0, height or 30)
    lbl.Position = UDim2.new(0, 10, 0, y)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = themes[state.Current].Text
    lbl.TextSize = 13
    lbl.Font = Enum.Font.Gotham
    lbl.TextWrapped = true
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = parent
    table.insert(state.Elements, { type = "text", label = lbl })
    return lbl
end

local function _makeHexInput(parent, y, placeholder, defaultValue, cb)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -20, 0, 34)
    row.Position = UDim2.new(0, 10, 0, y)
    row.BackgroundTransparency = 1
    row.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.30, 0, 1, 0)
    label.Text = placeholder
    label.TextColor3 = themes[state.Current].Text
    label.TextSize = 13
    label.Font = Enum.Font.GothamBold
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.5, 0, 0, 30)
    box.Position = UDim2.new(0.5, 0, 0.5, -15)
    box.BackgroundColor3 = _inputColor()
    box.BackgroundTransparency = 0.35
    box.BorderSizePixel = 0
    box.Text = defaultValue or "#C2C2C2"
    box.TextColor3 = themes[state.Current].Text
    box.Font = Enum.Font.Gotham
    box.TextSize = 12
    box.ClearTextOnFocus = false
    box.TextXAlignment = Enum.TextXAlignment.Center
    box.Parent = row
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)

    table.insert(state.Elements, { type = "textbox", label = label, box = box })

    box.FocusLost:Connect(function(enterPressed)
        if not enterPressed then return end
        local hex = box.Text:gsub("#", "")
        if #hex == 6 and hex:match("^[%x]+$") then
            local r = tonumber(hex:sub(1, 2), 16)
            local g = tonumber(hex:sub(3, 4), 16)
            local b = tonumber(hex:sub(5, 6), 16)
            local color = Color3.fromRGB(r, g, b)
            if cb then cb(color, "#" .. hex:upper()) end
        end
    end)

    return row, box
end

local function _makeButton(parent, y, text, cb)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 34)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.BackgroundColor3 = _inputColor()
    btn.BackgroundTransparency = 0.35
    btn.Text = text
    btn.TextColor3 = themes[state.Current].Text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    table.insert(state.Elements, { type = "button", btn = btn })
    btn.MouseButton1Click:Connect(function()
        _playClick()
        if cb then cb() end
    end)
    return btn
end

local function _updateUITheme()
    local t = themes[state.Current]
    local inputCol = _inputColor()
    for _, e in pairs(state.Elements) do
        if e.type == "toggle" then
            e.label.TextColor3 = t.Text
            e.container.BackgroundColor3 = e.isOn and t.Accent or Color3.fromRGB(200, 200, 210)
        elseif e.type == "slider" then
            e.label.TextColor3 = t.Text
            e.valLabel.TextColor3 = t.Accent
            e.valLabel.BackgroundColor3 = inputCol
            e.fill.BackgroundColor3 = t.Accent
        elseif e.type == "dropdown" then
            e.label.TextColor3 = t.Text
            e.main.BackgroundColor3 = inputCol
            e.main.TextColor3 = t.Text
            if e.scroll then
                e.scroll.BackgroundColor3 = t.Panel
                e.scroll.ScrollBarImageColor3 = t.Accent
            end
            if e.items then
                for _, item in pairs(e.items) do
                    item.BackgroundColor3 = t.Panel
                    item.TextColor3 = t.Text
                end
            end
        elseif e.type == "keybind" then
            e.label.TextColor3 = t.Text
            e.btn.BackgroundColor3 = inputCol
            e.btn.TextColor3 = t.Text
        elseif e.type == "text" then
            e.label.TextColor3 = t.Text
        elseif e.type == "stroke" then
        elseif e.type == "textbox" then
            e.label.TextColor3 = t.Text
            e.box.BackgroundColor3 = inputCol
            e.box.TextColor3 = t.Text
        elseif e.type == "button" then
            e.btn.BackgroundColor3 = inputCol
            e.btn.TextColor3 = t.Text
        end
    end
end

local function _replaceThemeColors(root, oldT, newT)
    local map = {
        [oldT.Main] = newT.Main, [oldT.Sidebar] = newT.Sidebar,
        [oldT.Content] = newT.Content, [oldT.Panel] = newT.Panel,
        [oldT.Accent] = newT.Accent, [oldT.AccentLight] = newT.AccentLight,
        [oldT.Text] = newT.Text, [oldT.Stroke] = newT.Stroke,
        [oldT.Outline] = newT.Outline,
    }
    local function rc(v)
        for o, n in pairs(map) do
            if v == o then return n end
        end
        return v
    end
    local function apply(obj)
        for _, tb in pairs(state.ThemeButtons) do
            if obj == tb or obj:IsDescendantOf(tb) then return end
        end
        if obj:IsA("GuiObject") then
            obj.BackgroundColor3 = rc(obj.BackgroundColor3)
            obj.BorderColor3 = rc(obj.BorderColor3)
            if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
                obj.TextColor3 = rc(obj.TextColor3)
            end
            if obj:IsA("ScrollingFrame") then obj.ScrollBarImageColor3 = rc(obj.ScrollBarImageColor3) end
        elseif obj:IsA("UIStroke") then
            obj.Color = rc(obj.Color)
        end
        for _, c in ipairs(obj:GetChildren()) do apply(c) end
    end
    apply(root)
end

local function _applyTheme(name)
    local t = themes[name]
    if not t then return end
    local oldT = themes[state.Current]
    state.Current = name
    if oldT then _replaceThemeColors(ScreenGui, oldT, t) end
    _main.BackgroundColor3 = t.Main
    _sidebar.BackgroundColor3 = t.Sidebar
    _sidebarFill.BackgroundColor3 = t.Sidebar
    _content.BackgroundColor3 = t.Content
    _title.TextColor3 = t.Accent
    _profile.BackgroundColor3 = t.AccentLight
    _displayName.TextColor3 = t.Text
    _username.TextColor3 = t.Text
    _tabHolder.ScrollBarImageColor3 = t.Accent
    for tabName, btn in pairs(state.Buttons) do
        local selected = state.Pages[tabName] and state.Pages[tabName].Visible
        btn.BackgroundColor3 = selected and t.Accent or t.AccentLight
        btn.TextColor3 = selected and Color3.fromRGB(255, 255, 255) or t.Text
    end
    for _, page in pairs(state.Pages) do
        local panel = page:FindFirstChild("_panel")
        if panel then
            panel.BackgroundColor3 = t.Panel
            if panel:IsA("ScrollingFrame") then panel.ScrollBarImageColor3 = t.Accent end
        end
        local title = page:FindFirstChild("_pageTitle")
        if title then title.TextColor3 = t.Accent end
    end
    for tn, btn in pairs(state.ThemeButtons) do
        local stroke = btn:FindFirstChild("_selected")
        if stroke then stroke.Enabled = (tn == state.Current) end
    end
    _updateUITheme()
end

local function _showPage(name)
    for n, page in pairs(state.Pages) do
        if n ~= name then page.Visible = false page.Position = UDim2.new(0, 0, 0, 0) end
    end
    local newPage = state.Pages[name]
    if newPage then
        newPage.Position = UDim2.new(0, 8, 0, 0)
        newPage.Visible = true
        services.TweenService:Create(newPage, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0, 0) }):Play()
    end
    for n, btn in pairs(state.Buttons) do
        local sel = (n == name)
        services.TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = sel and themes[state.Current].Accent or themes[state.Current].AccentLight
        }):Play()
        btn.TextColor3 = sel and Color3.fromRGB(255, 255, 255) or themes[state.Current].Text
    end
end

local function _wlApplyRowVisual(plr)
    local row = state.Whitelist.Rows[plr.UserId]
    if not row or not row.Parent then return end
    local hl = row:FindFirstChild("_highlight")
    local dot = row:FindFirstChild("_dot")
    local status = row:FindFirstChild("_status")
    local on = state.Whitelist.Users[plr.UserId] == true
    if hl then hl.Visible = on end
    if dot then dot.BackgroundColor3 = on and Color3.fromRGB(80, 220, 140) or Color3.fromRGB(180, 180, 190) end
    if status then
        status.Text = on and "WHITELISTED" or "Not whitelisted"
        status.TextColor3 = on and Color3.fromRGB(60, 200, 120) or themes[state.Current].Text
    end
end

local function _wlRefreshCount()
    if not state.Whitelist.CountLabel or not state.Whitelist.CountLabel.Parent then return end
    local n = 0
    for _ in pairs(state.Whitelist.Users) do n += 1 end
    state.Whitelist.CountLabel.Text = "Whitelisted: " .. tostring(n) .. " player" .. (n == 1 and "" or "s")
end

local function _wlToggle(plr)
    if plr == LocalPlayer then return end
    if state.Whitelist.Users[plr.UserId] then state.Whitelist.Users[plr.UserId] = nil else state.Whitelist.Users[plr.UserId] = true end
    _wlApplyRowVisual(plr)
    _wlRefreshCount()
end

local function _wlBuildRow(plr, order)
    if not state.Whitelist.ListFrame or not state.Whitelist.ListFrame.Parent then return end
    if state.Whitelist.Rows[plr.UserId] and state.Whitelist.Rows[plr.UserId].Parent then return end
    if plr == LocalPlayer then return end

    local row = Instance.new("TextButton")
    row.Name = "WL_" .. plr.UserId
    row.Size = UDim2.new(1, -16, 0, 46)
    row.BackgroundColor3 = themes[state.Current].AccentLight
    row.BackgroundTransparency = 0.45
    row.BorderSizePixel = 0
    row.Text = ""
    row.AutoButtonColor = false
    row.LayoutOrder = order or 0
    row.Parent = state.Whitelist.ListFrame
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10)

    local hl = Instance.new("Frame")
    hl.Name = "_highlight"
    hl.Size = UDim2.fromScale(1, 1)
    hl.BackgroundColor3 = themes[state.Current].Accent
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
            return services.Players:GetUserThumbnailAsync(plr.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
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
    nameLbl.TextColor3 = themes[state.Current].Text
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
    status.TextColor3 = themes[state.Current].Text
    status.Font = Enum.Font.Gotham
    status.TextSize = 11
    status.TextXAlignment = Enum.TextXAlignment.Left
    status.ZIndex = 2
    status.Parent = row

    row.MouseButton1Click:Connect(function() _playClick() _wlToggle(plr) end)
    row.MouseEnter:Connect(function() _playHover() services.TweenService:Create(row, TweenInfo.new(0.12), { BackgroundTransparency = 0.25 }):Play() end)
    row.MouseLeave:Connect(function() services.TweenService:Create(row, TweenInfo.new(0.12), { BackgroundTransparency = 0.45 }):Play() end)

    state.Whitelist.Rows[plr.UserId] = row
    _wlApplyRowVisual(plr)
end

local function _wlRemoveRow(plr)
    local row = state.Whitelist.Rows[plr.UserId]
    if row then row:Destroy() state.Whitelist.Rows[plr.UserId] = nil end
    _wlRefreshCount()
end

local function _wlRebuildAll()
    if not state.Whitelist.ListFrame or not state.Whitelist.ListFrame.Parent then return end
    for _, row in pairs(state.Whitelist.Rows) do
        if row and row.Parent then row:Destroy() end
    end
    state.Whitelist.Rows = {}
    local order = 0
    for _, plr in ipairs(services.Players:GetPlayers()) do
        if plr ~= LocalPlayer then order += 1 _wlBuildRow(plr, order) end
    end
    _wlRefreshCount()
end

services.Players.PlayerAdded:Connect(function(plr)
    if state.Whitelist.ListFrame and state.Whitelist.ListFrame.Parent then
        task.defer(function() _wlBuildRow(plr, 999) end)
    end
end)
services.Players.PlayerRemoving:Connect(function(plr)
    state.Whitelist.Users[plr.UserId] = nil
    _wlRemoveRow(plr)
    if _Camlock.Target == plr then _camDisable() end
end)

local _tabList = {
    "Combat", "Atmosphere", "Misc", "Teleport",
    "Avatar", "Skin Changer", "FPS",
    "Whitelist", "Theme", "Settings"
}

for _, tabName in ipairs(_tabList) do
    local btn = Instance.new("TextButton")
    btn.Name = tabName .. "_btn"
    btn.Size = UDim2.new(1, 0, 0, 42)
    btn.BackgroundColor3 = themes["Baby Blue"].AccentLight
    btn.BorderSizePixel = 0
    btn.Text = tabName
    btn.TextColor3 = themes["Baby Blue"].Text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.Parent = _tabHolder
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 9)
    state.Buttons[tabName] = btn

    local page = Instance.new("Frame")
    page.Name = tabName .. "_page"
    page.Size = UDim2.fromScale(1, 1)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = _pageHolder
    state.Pages[tabName] = page

    local pTitle = Instance.new("TextLabel")
    pTitle.Name = "_pageTitle"
    pTitle.Size = UDim2.new(1, 0, 0, 38)
    pTitle.BackgroundTransparency = 1
    pTitle.Text = tabName
    pTitle.TextColor3 = themes["Baby Blue"].Accent
    pTitle.Font = Enum.Font.FredokaOne
    pTitle.TextSize = 24
    pTitle.TextXAlignment = Enum.TextXAlignment.Left
    pTitle.Parent = page

    if tabName == "Whitelist" then
        local panel = Instance.new("Frame")
        panel.Name = "_panel"
        panel.Size = UDim2.new(1, 0, 1, -48)
        panel.Position = UDim2.new(0, 0, 0, 45)
        panel.BackgroundColor3 = themes["Baby Blue"].Panel
        panel.BorderSizePixel = 0
        panel.Parent = page
        Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 12)

        local header = Instance.new("TextLabel")
        header.Size = UDim2.new(1, -20, 0, 26)
        header.Position = UDim2.new(0, 10, 0, 8)
        header.BackgroundTransparency = 1
        header.Text = "Click a player to whitelist / unwhitelist them"
        header.TextColor3 = themes["Baby Blue"].Text
        header.Font = Enum.Font.GothamBold
        header.TextSize = 13
        header.TextXAlignment = Enum.TextXAlignment.Left
        header.Parent = panel
        table.insert(state.Elements, { type = "text", label = header })

        local count = Instance.new("TextLabel")
        count.Name = "_wlCount"
        count.Size = UDim2.new(1, -20, 0, 22)
        count.Position = UDim2.new(0, 10, 0, 32)
        count.BackgroundTransparency = 1
        count.Text = "Whitelisted: 0 players"
        count.TextColor3 = themes["Baby Blue"].Accent
        count.Font = Enum.Font.GothamBold
        count.TextSize = 12
        count.TextXAlignment = Enum.TextXAlignment.Left
        count.Parent = panel
        table.insert(state.Elements, { type = "text", label = count })
        state.Whitelist.CountLabel = count

        local list = Instance.new("ScrollingFrame")
        list.Name = "_wlList"
        list.Size = UDim2.new(1, -16, 1, -66)
        list.Position = UDim2.new(0, 8, 0, 58)
        list.BackgroundTransparency = 1
        list.BorderSizePixel = 0
        list.ScrollBarThickness = 3
        list.ScrollBarImageColor3 = themes["Baby Blue"].Accent
        list.AutomaticCanvasSize = Enum.AutomaticSize.Y
        list.CanvasSize = UDim2.new(0, 0, 0, 0)
        list.ScrollingDirection = Enum.ScrollingDirection.Y
        list.Parent = panel
        state.Whitelist.ListFrame = list

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
        panel.BackgroundColor3 = themes["Baby Blue"].Panel
        panel.BorderSizePixel = 0
        panel.ScrollBarThickness = 0
        panel.ScrollBarImageColor3 = themes["Baby Blue"].Accent
        panel.AutomaticCanvasSize = Enum.AutomaticSize.Y
        panel.CanvasSize = UDim2.new(0, 0, 0, 0)
        panel.ScrollingDirection = Enum.ScrollingDirection.Y
        panel.Parent = page
        Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 12)

        local padding = Instance.new("UIPadding")
        padding.PaddingTop = UDim.new(0, 10)
        padding.PaddingBottom = UDim.new(0, 10)
        padding.PaddingLeft = UDim.new(0, 5)
        padding.PaddingRight = UDim.new(0, 5)
        padding.Parent = panel

        local yOff = 0

        if tabName == "Combat" then
            _makeText(panel, yOff, "━━━ Silent Aim ━━━", 24) yOff = yOff + 30
            _makeToggle(panel, yOff, "Silent Aim", "silent_enabled", settings.Silent.Enabled, function(v) settings.Silent.Enabled = v end) yOff = yOff + 38
            _makeToggle(panel, yOff, "Exclude Revolver", "silent_exclude", settings.Silent.Exclude, function(v) settings.Silent.Exclude = v end) yOff = yOff + 38
            _makeToggle(panel, yOff, "Wall Check", "silent_wall", settings.Silent.Wall, function(v) settings.Silent.Wall = v end) yOff = yOff + 38
            _makeToggle(panel, yOff, "Knock Check", "silent_knock", settings.Silent.Knock, function(v) settings.Silent.Knock = v end) yOff = yOff + 40
            _makeSlider(panel, yOff, "Silent FOV Radius", "silent_fov", settings.Silent.FOV, 0, 1000, 1, function(v) settings.Silent.FOV = v end) yOff = yOff + 38
            _makeSlider(panel, yOff, "Bullet Spread", "silent_spread", settings.Silent.Spread, 0, 100, 1, function(v) settings.Silent.Spread = v end) yOff = yOff + 40
            _makeDropdown(panel, yOff, "Aim Part", { "Head", "Body", "Left Leg", "Right Leg", "Left Arm", "Right Arm", "Closest Part" }, 1, function(i, v) settings.Silent.AimPart = v end) yOff = yOff + 46

            _makeText(panel, yOff, "━━━ Camlock ━━━", 24) yOff = yOff + 30
            _makeToggle(panel, yOff, "Camlock Enabled", "cam_enabled", settings.Camlock.Enabled, function(v)
                settings.Camlock.Enabled = v
                if not v then _camDisable() end
            end) yOff = yOff + 38
            _makeToggle(panel, yOff, "Auto Toggle (Gun)", "cam_auto", settings.Camlock.AutoToggle, function(v)
                settings.Camlock.AutoToggle = v
                _camDisable()
            end) yOff = yOff + 38
            _makeKeybind(panel, yOff, "Toggle Key", settings.Camlock.ToggleKey, function(v) settings.Camlock.ToggleKey = v end) yOff = yOff + 40
            _makeDropdown(panel, yOff, "Mode", { "Toggle", "Hold" }, settings.Camlock.Mode == "Hold" and 2 or 1, function(i, v)
                settings.Camlock.Mode = v
                _camDisable()
            end) yOff = yOff + 40
            _makeDropdown(panel, yOff, "Hit Part", _camAllHitPartOptions, table.find(_camAllHitPartOptions, settings.Camlock.HitPart) or 4, function(i, v) settings.Camlock.HitPart = v end) yOff = yOff + 40
            _makeDropdown(panel, yOff, "Closest Point Mode", { "Default", "Basic" }, settings.Camlock.ClosestPointMode == "Basic" and 2 or 1, function(i, v) settings.Camlock.ClosestPointMode = v end) yOff = yOff + 40
            _makeSlider(panel, yOff, "Closest Point Scale", "cam_closest_scale", settings.Camlock.ClosestPointScale, 0, 1, 0.001, function(v) settings.Camlock.ClosestPointScale = v end) yOff = yOff + 38
            _makeSlider(panel, yOff, "FOV Radius", "cam_fov", settings.Camlock.FOVRadius, 0, 1000, 1, function(v) settings.Camlock.FOVRadius = v end) yOff = yOff + 38
            _makeSlider(panel, yOff, "Max Distance", "cam_max_dist", settings.Camlock.MaxDistance, 0, 100000, 1, function(v) settings.Camlock.MaxDistance = v end) yOff = yOff + 38
            _makeDropdown(panel, yOff, "Easing Style", { "Linear", "Quad", "Sine", "Back", "Elastic", "Bounce" }, table.find({ "Linear", "Quad", "Sine", "Back", "Elastic", "Bounce" }, settings.Camlock.EasingStyle) or 2, function(i, v) settings.Camlock.EasingStyle = v end) yOff = yOff + 40
            _makeDropdown(panel, yOff, "Easing Direction", { "In", "Out", "InOut" }, table.find({ "In", "Out", "InOut" }, settings.Camlock.EasingDirection) or 2, function(i, v) settings.Camlock.EasingDirection = v end) yOff = yOff + 40
            _makeSlider(panel, yOff, "Smoothness", "cam_smooth", settings.Camlock.Smooth, 0, 1, 0.001, function(v) settings.Camlock.Smooth = v end) yOff = yOff + 38
            _makeToggle(panel, yOff, "Pull Strength", "cam_pull_enabled", settings.Camlock.PullStrengthEnabled, function(v) settings.Camlock.PullStrengthEnabled = v end) yOff = yOff + 38
            _makeSlider(panel, yOff, "Pull Base Value", "cam_pull_base", settings.Camlock.PullStrengthBase, 0.001, 0.2, 0.001, function(v) settings.Camlock.PullStrengthBase = v end) yOff = yOff + 38
            _makeSlider(panel, yOff, "Pull Move Value", "cam_pull_move", settings.Camlock.PullStrengthMove, 0.001, 0.2, 0.001, function(v) settings.Camlock.PullStrengthMove = v end) yOff = yOff + 38
            _makeToggle(panel, yOff, "Prediction", "cam_pred_enabled", settings.Camlock.PredictionEnabled, function(v) settings.Camlock.PredictionEnabled = v end) yOff = yOff + 38
            _makeSlider(panel, yOff, "Prediction X", "cam_pred_x", settings.Camlock.PredictionX, 0.001, 0.1, 0.001, function(v) settings.Camlock.PredictionX = v end) yOff = yOff + 38
            _makeSlider(panel, yOff, "Prediction Y", "cam_pred_y", settings.Camlock.PredictionY, 0.001, 0.1, 0.001, function(v) settings.Camlock.PredictionY = v end) yOff = yOff + 38
            _makeSlider(panel, yOff, "Prediction Z", "cam_pred_z", settings.Camlock.PredictionZ, 0.001, 0.1, 0.001, function(v) settings.Camlock.PredictionZ = v end) yOff = yOff + 40
            _makeToggle(panel, yOff, "Force Field Check", "cam_cond_ff", settings.Camlock.Conditions.ForceField, function(v) settings.Camlock.Conditions.ForceField = v end) yOff = yOff + 38
            _makeToggle(panel, yOff, "Visible Check", "cam_cond_vis", settings.Camlock.Conditions.Visible, function(v) settings.Camlock.Conditions.Visible = v end) yOff = yOff + 38
            _makeToggle(panel, yOff, "Carried Check", "cam_cond_car", settings.Camlock.Conditions.Carried, function(v) settings.Camlock.Conditions.Carried = v end) yOff = yOff + 38
            _makeToggle(panel, yOff, "Knocked Check", "cam_cond_kno", settings.Camlock.Conditions.Knocked, function(v) settings.Camlock.Conditions.Knocked = v end) yOff = yOff + 38
            _makeToggle(panel, yOff, "Self Knocked Check", "cam_cond_self", settings.Camlock.Conditions.SelfKnocked, function(v) settings.Camlock.Conditions.SelfKnocked = v end) yOff = yOff + 46

            _makeText(panel, yOff, "━━━ Hitbox Expander ━━━", 24) yOff = yOff + 30
            _makeToggle(panel, yOff, "Hitbox Expander", "hitbox_enabled", settings.Hitbox.Enabled, function(v) settings.Hitbox.Enabled = v end) yOff = yOff + 38
            _makeSlider(panel, yOff, "Head Size", "hitbox_size", settings.Hitbox.HeadSize, 0.01, 30, 0.01, function(v) settings.Hitbox.HeadSize = v end) yOff = yOff + 38
            _makeSlider(panel, yOff, "Transparency", "hitbox_trans", settings.Hitbox.Transparency, 0, 1, 0.01, function(v) settings.Hitbox.Transparency = v end) yOff = yOff + 46

        elseif tabName == "Atmosphere" then
            _makeText(panel, yOff, "━━━ Fog ━━━", 24) yOff = yOff + 30
            _makeDropdown(panel, yOff, "Fog Color", { "Pink", "Purple", "Yellow", "Green", "Blue", "Orange" }, 1, function(i, n)
                local map = { Pink = Color3.fromRGB(255, 200, 220), Purple = Color3.fromRGB(200, 180, 240), Yellow = Color3.fromRGB(255, 240, 180), Green = Color3.fromRGB(180, 240, 200), Blue = Color3.fromRGB(180, 220, 255), Orange = Color3.fromRGB(255, 210, 180) }
                settings.Fog.Color = map[n] or DAHOOD_DEFAULT_FOG.FogColor
                services.Lighting.FogColor = settings.Fog.Color
                if services.Lighting:FindFirstChild("Atmosphere") then services.Lighting.Atmosphere.FogColor = settings.Fog.Color end
            end)
            yOff = yOff + 40

            local _, hexBox = _makeHexInput(panel, yOff, "Fog Hex", "#C2C2C2", function(color, hexString)
                settings.Fog.Color = color
                services.Lighting.FogColor = color
                if services.Lighting:FindFirstChild("Atmosphere") then services.Lighting.Atmosphere.FogColor = color end
            end)
            yOff = yOff + 40

            _makeSlider(panel, yOff, "Fog Intensity", "fog_intensity", settings.Fog.Intensity, 0, 2000, 1, function(v)
                settings.Fog.Intensity = v
                services.Lighting.FogEnd = v
                services.Lighting.FogStart = math.round(v * 0.1)
            end)
            yOff = yOff + 40

            _makeSlider(panel, yOff, "Contrast", "fog_contrast", settings.Fog.Contrast, -20, 10, 1, function(v)
                settings.Fog.Contrast = v
                _applyContrast(v)
            end)
            yOff = yOff + 40

            _makeButton(panel, yOff, "Reset Fog (Da Hood Default)", function()
                settings.Fog.Color = DAHOOD_DEFAULT_FOG.FogColor
                settings.Fog.Intensity = DAHOOD_DEFAULT_FOG.FogEnd
                settings.Fog.Contrast = 0
                services.Lighting.FogColor = DAHOOD_DEFAULT_FOG.FogColor
                services.Lighting.FogStart = DAHOOD_DEFAULT_FOG.FogStart
                services.Lighting.FogEnd = DAHOOD_DEFAULT_FOG.FogEnd
                local atm = services.Lighting:FindFirstChildOfClass("Atmosphere")
                if atm then
                    atm.Color = DAHOOD_DEFAULT_FOG.Atmosphere.Color
                    atm.Density = DAHOOD_DEFAULT_FOG.Atmosphere.Density
                    atm.Offset = DAHOOD_DEFAULT_FOG.Atmosphere.Offset
                    atm.Glare = DAHOOD_DEFAULT_FOG.Atmosphere.Glare
                    atm.Haze = DAHOOD_DEFAULT_FOG.Atmosphere.Haze
                    atm.Decay = DAHOOD_DEFAULT_FOG.Atmosphere.Decay
                end
                services.Lighting.Brightness = 2
                services.Lighting.Ambient = Color3.fromRGB(70, 70, 70)
                services.Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
                services.Lighting.ColorShift_Top = Color3.fromRGB(0, 0, 0)
                if hexBox then hexBox.Text = "#C2C2C2" end
            end)
            yOff = yOff + 46

            _makeText(panel, yOff, "━━━ Time Changer ━━━", 24) yOff = yOff + 30
            local timeDisplay = Instance.new("TextLabel")
            timeDisplay.Size = UDim2.new(1, 0, 0, 50)
            timeDisplay.Position = UDim2.new(0, 0, 0, yOff)
            timeDisplay.BackgroundTransparency = 1
            timeDisplay.Text = "12:00"
            timeDisplay.TextColor3 = themes["Baby Blue"].Accent
            timeDisplay.TextSize = 40
            timeDisplay.Font = Enum.Font.FredokaOne
            timeDisplay.Parent = panel
            table.insert(state.Elements, { type = "text", label = timeDisplay })
            yOff = yOff + 55

            _makeSlider(panel, yOff, "Time (Hour)", "time_hour", settings.Time.Target, 0, 24, 0.1, function(v)
                settings.Time.Target = v
                local h = math.floor(v)
                local m = math.floor((v - h) * 60)
                timeDisplay.Text = string.format("%02d:%02d", h, m)
                if settings.Time.Override then
                    services.Lighting:SetAttribute("DayTimeValue", v)
                end
            end)
            yOff = yOff + 42

            _makeToggle(panel, yOff, "Override Server Time", "time_override", settings.Time.Override, function(v)
                settings.Time.Override = v
                if v then services.Lighting:SetAttribute("DayTimeValue", settings.Time.Target) else services.Lighting:SetAttribute("DayTimeValue", nil) end
            end)
            yOff = yOff + 50

        elseif tabName == "Misc" then
            _makeToggle(panel, yOff, "Speed Hack", "speed_enabled", settings.Speed.Enabled, function(v)
                settings.Speed.Enabled = v
                if not v then settings.Speed.Active = false
                    if LocalPlayer.Character then local h = LocalPlayer.Character:FindFirstChild("Humanoid") if h then h.WalkSpeed = 16 end end
                end
            end) yOff = yOff + 38
            _makeSlider(panel, yOff, "Speed Value", "speed_value", settings.Speed.Value, 16, 500, 1, function(v) settings.Speed.Value = v end) yOff = yOff + 38
            _makeKeybind(panel, yOff, "Speed Keybind", settings.Speed.Bind, function(v) settings.Speed.Bind = v end) yOff = yOff + 40
            _makeToggle(panel, yOff, "Jump Boost", "jump_enabled", settings.Jump.Enabled, function(v)
                settings.Jump.Enabled = v
                if not v then settings.Jump.Active = false
                    if LocalPlayer.Character then local h = LocalPlayer.Character:FindFirstChild("Humanoid") if h then h.JumpPower = 50 end end
                end
            end) yOff = yOff + 38
            _makeSlider(panel, yOff, "Jump Value", "jump_value", settings.Jump.Value, 30, 500, 1, function(v) settings.Jump.Value = v end) yOff = yOff + 38
            _makeKeybind(panel, yOff, "Jump Keybind", settings.Jump.Bind, function(v) settings.Jump.Bind = v end) yOff = yOff + 40
            _makeToggle(panel, yOff, "Spider Jump", "spider_enabled", settings.Spider.Enabled, function(v) settings.Spider.Enabled = v end) yOff = yOff + 38
            _makeSlider(panel, yOff, "Spider Power", "spider_power", settings.Spider.Value, 30, 150, 1, function(v) settings.Spider.Value = v end) yOff = yOff + 38
            _makeKeybind(panel, yOff, "Spider Bind", settings.Spider.Bind, function(v) settings.Spider.Bind = v end) yOff = yOff + 40
            _makeToggle(panel, yOff, "ESP", "esp_enabled", settings.ESP.Enabled, function(v)
                settings.ESP.Enabled = v
                if not v then settings.ESP.Active = false settings.ESP.Box = false settings.ESP.Name = false else settings.ESP.Active = true end
            end) yOff = yOff + 38
            _makeToggle(panel, yOff, "ESP Boxes", "esp_box", settings.ESP.Box, function(v) settings.ESP.Box = v end) yOff = yOff + 38
            _makeToggle(panel, yOff, "ESP Names", "esp_name", settings.ESP.Name, function(v) settings.ESP.Name = v end) yOff = yOff + 38
            _makeKeybind(panel, yOff, "ESP Toggle", settings.ESP.Bind, function(v) settings.ESP.Bind = v end) yOff = yOff + 50

        elseif tabName == "Teleport" then
            _makeToggle(panel, yOff, "Mouse Teleport", "tp_enabled", settings.Teleport.Enabled, function(v)
                settings.Teleport.Enabled = v
                if not v then settings.Teleport.Active = false end
            end) yOff = yOff + 38
            _makeKeybind(panel, yOff, "Teleport Toggle", settings.Teleport.Bind, function(v) settings.Teleport.Bind = v end) yOff = yOff + 44
            _makeText(panel, yOff, "Click anywhere to teleport to that position (when enabled).", 50) yOff = yOff + 60

        elseif tabName == "Avatar" then
            _makeToggle(panel, yOff, "Headless", "avatar_headless", settings.Avatar.Headless, function(v)
                settings.Avatar.Headless = v
                if LocalPlayer.Character then
                    local head = LocalPlayer.Character:FindFirstChild("Head")
                    local face = LocalPlayer.Character:FindFirstChild("Face")
                    if head then head.Transparency = v and 1 or 0 end
                    if face then face.Transparency = v and 1 or 0 end
                end
            end) yOff = yOff + 40
            _makeToggle(panel, yOff, "Korblox (Left Leg)", "avatar_korblox", settings.Avatar.Korblox, function(v) settings.Avatar.Korblox = v end) yOff = yOff + 40

        elseif tabName == "Skin Changer" then
            _makeToggle(panel, yOff, "Enable Skin Changer", "skin_enabled", true, function(v)
                if shared.Saved and shared.Saved.GunModifiers and shared.Saved.GunModifiers.SkinChanger then
                    shared.Saved.GunModifiers.SkinChanger.Enabled = v
                end
            end)
            yOff = yOff + 42

            _makeText(panel, yOff, "Pick a skin for each weapon. Changes apply live.", 32) yOff = yOff + 38

            local weaponOrder = {
                "[Knife]", "[Revolver]", "[Double-Barrel SG]", "[TacticalShotgun]",
                "[Shotgun]", "[Drum-Shotgun]", "[Deagle]", "[Flintlock]",
                "[Glock]", "[Silencer]", "[AR]", "[SilencerAR]",
                "[AK47]", "[SMG]", "[P90]", "[LMG]",
                "[DrumGun]", "[AUG]", "[Rifle]",
            }

            for _, weaponKey in ipairs(weaponOrder) do
                local config = weaponConfigs[weaponKey]
                if config then
                    local row = Instance.new("Frame")
                    row.Size = UDim2.new(1, -20, 0, 34)
                    row.Position = UDim2.new(0, 10, 0, yOff)
                    row.BackgroundTransparency = 1
                    row.Parent = panel

                    local lbl = Instance.new("TextLabel")
                    lbl.Size = UDim2.new(0.35, 0, 1, 0)
                    lbl.BackgroundTransparency = 1
                    lbl.Text = config.name
                    lbl.TextColor3 = themes[state.Current].Text
                    lbl.TextSize = 13
                    lbl.Font = Enum.Font.GothamBold
                    lbl.TextXAlignment = Enum.TextXAlignment.Left
                    lbl.Parent = row

                    local currentSkin = (shared.Saved.GunModifiers.SkinChanger.Skins[weaponKey]) or "Default"
                    local mainBtn = Instance.new("TextButton")
                    mainBtn.Size = UDim2.new(0, 160, 0, 30)
                    mainBtn.Position = UDim2.new(1, -170, 0.5, -15)
                    mainBtn.BackgroundColor3 = _inputColor()
                    mainBtn.BackgroundTransparency = 0.4
                    mainBtn.Text = currentSkin
                    mainBtn.TextColor3 = themes[state.Current].Text
                    mainBtn.Font = Enum.Font.Gotham
                    mainBtn.TextSize = 12
                    mainBtn.ZIndex = 5
                    mainBtn.Parent = row
                    Instance.new("UICorner", mainBtn).CornerRadius = UDim.new(0, 6)

                    local scroll = Instance.new("ScrollingFrame")
                    scroll.Size = UDim2.new(0, 160, 0, math.min(#config.skins * 28, 220))
                    scroll.Position = UDim2.new(1, -170, 0, 34)
                    scroll.BackgroundColor3 = themes[state.Current].Panel
                    scroll.BackgroundTransparency = 0.1
                    scroll.BorderSizePixel = 0
                    scroll.Visible = false
                    scroll.ZIndex = 10
                    scroll.CanvasSize = UDim2.new(0, 0, 0, #config.skins * 28)
                    scroll.ScrollBarThickness = 2
                    scroll.ScrollBarImageColor3 = themes[state.Current].Accent
                    scroll.Parent = row
                    Instance.new("UICorner", scroll).CornerRadius = UDim.new(0, 6)

                    local optionButtons = {}
                    for i, opt in ipairs(config.skins) do
                        local optBtn = Instance.new("TextButton")
                        optBtn.Size = UDim2.new(1, 0, 0, 26)
                        optBtn.Position = UDim2.new(0, 0, 0, (i - 1) * 28)
                        optBtn.BackgroundColor3 = themes[state.Current].Panel
                        optBtn.BackgroundTransparency = 0.2
                        optBtn.Text = "  " .. opt
                        optBtn.TextColor3 = themes[state.Current].Text
                        optBtn.TextSize = 12
                        optBtn.Font = Enum.Font.Gotham
                        optBtn.TextXAlignment = Enum.TextXAlignment.Left
                        optBtn.ZIndex = 11
                        optBtn.Parent = scroll
                        Instance.new("UICorner", optBtn).CornerRadius = UDim.new(0, 4)
                        table.insert(optionButtons, optBtn)
                        optBtn.MouseButton1Click:Connect(function()
                            _playClick()
                            mainBtn.Text = opt
                            scroll.Visible = false
                            shared.Saved.GunModifiers.SkinChanger.Skins[weaponKey] = opt
                        end)
                    end

                    table.insert(state.Elements, {
                        type = "dropdown", label = lbl, main = mainBtn, scroll = scroll, items = optionButtons
                    })

                    mainBtn.MouseButton1Click:Connect(function()
                        _playClick()
                        scroll.Visible = not scroll.Visible
                        for _, other in pairs(state.SkinDropdowns) do
                            if other ~= scroll then other.Visible = false end
                        end
                    end)
                    state.SkinDropdowns[weaponKey] = scroll

                    yOff = yOff + 38
                end
            end

            yOff = yOff + 10
            local statusLbl = Instance.new("TextLabel")
            statusLbl.Size = UDim2.new(1, -20, 0, 30)
            statusLbl.Position = UDim2.new(0, 10, 0, yOff)
            statusLbl.BackgroundTransparency = 1
            statusLbl.Text = skinLoaderLoaded and "✅ Skin loader loaded" or "⚠️ Skin loader failed"
            statusLbl.TextColor3 = skinLoaderLoaded and Color3.fromRGB(80, 255, 180) or Color3.fromRGB(255, 200, 80)
            statusLbl.TextSize = 12
            statusLbl.Font = Enum.Font.Gotham
            statusLbl.TextXAlignment = Enum.TextXAlignment.Center
            statusLbl.Parent = panel
            table.insert(state.Elements, { type = "text", label = statusLbl })
            yOff = yOff + 40

        elseif tabName == "FPS" then
            local fpsDisplay = Instance.new("TextLabel")
            fpsDisplay.Size = UDim2.new(1, 0, 0, 50)
            fpsDisplay.Position = UDim2.new(0, 0, 0, yOff)
            fpsDisplay.BackgroundTransparency = 1
            fpsDisplay.Text = "FPS: 60"
            fpsDisplay.TextColor3 = themes["Baby Blue"].Accent
            fpsDisplay.TextSize = 36
            fpsDisplay.Font = Enum.Font.FredokaOne
            fpsDisplay.Parent = panel
            settings.FPS.Display = fpsDisplay
            table.insert(state.Elements, { type = "text", label = fpsDisplay })
            yOff = yOff + 55

            _makeToggle(panel, yOff, "Show FPS", "fps_show", settings.FPS.Show, function(v)
                settings.FPS.Show = v
                if fpsDisplay then fpsDisplay.Visible = v end
            end) yOff = yOff + 38
            _makeToggle(panel, yOff, "Unlock FPS", "fps_unlock", settings.FPS.Unlock, function(v)
                settings.FPS.Unlock = v
                pcall(function() if setfpscap then setfpscap(v and settings.FPS.Cap or 60) end end)
            end) yOff = yOff + 38
            _makeSlider(panel, yOff, "FPS Cap", "fps_cap", settings.FPS.Cap, 1, 1000, 1, function(v)
                settings.FPS.Cap = v
                if settings.FPS.Unlock then pcall(function() if setfpscap then setfpscap(v) end end) end
            end) yOff = yOff + 50

        elseif tabName == "Theme" then
            local title = Instance.new("TextLabel")
            title.Size = UDim2.new(1, 0, 0, 35)
            title.BackgroundTransparency = 1
            title.Text = "Choose a color theme"
            title.TextColor3 = themes["Baby Blue"].Text
            title.Font = Enum.Font.GothamBold
            title.TextSize = 15
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.Parent = panel
            table.insert(state.Elements, { type = "text", label = title })
            yOff = yOff + 40

            local grid = Instance.new("Frame")
            grid.Size = UDim2.new(1, -10, 0, 320)
            grid.Position = UDim2.new(0, 5, 0, yOff)
            grid.BackgroundTransparency = 1
            grid.Parent = panel

            local gridL = Instance.new("UIGridLayout")
            gridL.CellSize = UDim2.new(0.31, 0, 0, 42)
            gridL.CellPadding = UDim2.new(0.02, 0, 0, 8)
            gridL.HorizontalAlignment = Enum.HorizontalAlignment.Center
            gridL.VerticalAlignment = Enum.VerticalAlignment.Top
            gridL.Parent = grid

            local allThemes = {
                "Baby Blue", "Baby Pink",
                "Pink", "Purple", "Yellow", "Green", "Blue", "Orange",
                "Cotton Candy", "Sunset", "Mint Chip", "Lavender Haze",
                "Strawberry Lemonade", "Ocean Breeze", "Peach Fuzz"
            }
            for _, n in ipairs(allThemes) do
                local tBtn = Instance.new("TextButton")
                tBtn.BackgroundColor3 = themes[n].Accent
                tBtn.BorderSizePixel = 0
                tBtn.Text = n
                tBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                tBtn.Font = Enum.Font.Gotham
                tBtn.TextSize = 11
                tBtn.Parent = grid
                Instance.new("UICorner", tBtn).CornerRadius = UDim.new(0, 8)
                local sel = Instance.new("UIStroke")
                sel.Name = "_selected"
                sel.Color = Color3.fromRGB(255, 255, 255)
                sel.Thickness = 2
                sel.Enabled = false
                sel.Parent = tBtn
                state.ThemeButtons[n] = tBtn
                tBtn.MouseButton1Click:Connect(function()
                    _playClick()
                    _applyTheme(n)
                end)
            end
            yOff = yOff + 330

        elseif tabName == "Settings" then
            _makeKeybind(panel, yOff, "Menu Toggle", "F6", function(v) end) yOff = yOff + 54

            local kill = Instance.new("TextButton")
            kill.Name = "_kill"
            kill.Size = UDim2.new(0.6, 0, 0, 48)
            kill.Position = UDim2.new(0.2, 0, 0, yOff)
            kill.BackgroundColor3 = themes["Baby Blue"].Accent
            kill.BackgroundTransparency = 0.15
            kill.Text = "CLOSE UI"
            kill.TextColor3 = Color3.fromRGB(255, 255, 255)
            kill.Font = Enum.Font.GothamBold
            kill.TextSize = 18
            kill.Parent = panel
            Instance.new("UICorner", kill).CornerRadius = UDim.new(0, 12)
            state.KillBtn = kill

            kill.MouseButton1Click:Connect(function()
                _playClick()
                ScreenGui:Destroy()
            end)
            yOff = yOff + 70
        end

        panel.CanvasSize = UDim2.new(0, 0, 0, yOff + 20)
    end

    btn.MouseEnter:Connect(function() _playHover() end)
    btn.MouseButton1Click:Connect(function() _playClick() _showPage(tabName) end)
end

local _fpsFrames, _fpsTime = 0, 0
services.RunService.RenderStepped:Connect(function(dt)
    if not settings.FPS.Show or not settings.FPS.Display or not settings.FPS.Display.Parent then return end
    _fpsFrames = _fpsFrames + 1
    _fpsTime = _fpsTime + dt
    if _fpsTime >= 0.5 then
        settings.FPS.Display.Text = "FPS: " .. tostring(math.round(_fpsFrames / _fpsTime))
        _fpsFrames = 0
        _fpsTime = 0
    end
end)

services.RunService.Heartbeat:Connect(function()
    if settings.Speed.Enabled and settings.Speed.Active then
        if LocalPlayer.Character then
            local h = LocalPlayer.Character:FindFirstChild("Humanoid")
            if h and h.WalkSpeed ~= settings.Speed.Value then h.WalkSpeed = settings.Speed.Value end
        end
    end
    if settings.Jump.Enabled and settings.Jump.Active then
        if LocalPlayer.Character then
            local h = LocalPlayer.Character:FindFirstChild("Humanoid")
            if h and h.JumpPower ~= settings.Jump.Value then h.JumpPower = settings.Jump.Value end
        end
    end
    if settings.Spider.Enabled and settings.Spider.Active then
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hum and hrp then
                if hum:GetState() == Enum.HumanoidStateType.Freefall or hum:GetState() == Enum.HumanoidStateType.Jumping then
                    local rayOrigin = hrp.Position
                    local rayDir = Vector3.new(0, -3.5, 0)
                    local rayParams = RaycastParams.new()
                    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
                    rayParams.FilterDescendantsInstances = {char}
                    local hit = workspace:Raycast(rayOrigin, rayDir, rayParams)
                    if hit and hit.Normal.Y < 0.4 then
                        hum:ChangeState(Enum.HumanoidStateType.Landed)
                    end
                end
                if hum:GetState() == Enum.HumanoidStateType.Freefall and hum.MoveDirection.Magnitude > 0 then
                    local wallOrigin = hrp.Position + hum.MoveDirection.Unit * 2
                    local wallDir = hum.MoveDirection.Unit * 4
                    local rayParams2 = RaycastParams.new()
                    rayParams2.FilterType = Enum.RaycastFilterType.Blacklist
                    rayParams2.FilterDescendantsInstances = {char}
                    local wallHit = workspace:Raycast(wallOrigin, wallDir, rayParams2)
                    if wallHit then
                        hrp.Velocity = Vector3.new(hrp.Velocity.X, settings.Spider.Value, hrp.Velocity.Z)
                        hum:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end
        end
    end
end)

services.RunService.RenderStepped:Connect(function()
    if settings.Hitbox.Enabled then
        for _, v in pairs(services.Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character then
                local root = v.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    root.Size = Vector3.new(settings.Hitbox.HeadSize, settings.Hitbox.HeadSize, settings.Hitbox.HeadSize)
                    root.Transparency = settings.Hitbox.Transparency
                    root.BrickColor = BrickColor.new(settings.Hitbox.Color)
                    root.Material = "Neon"
                    root.CanCollide = false
                end
            end
        end
    end
end)

services.RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character then
        local char = LocalPlayer.Character
        local lul = char:FindFirstChild("LeftUpperLeg")
        local lll = char:FindFirstChild("LeftLowerLeg")
        local lf = char:FindFirstChild("LeftFoot")
        if settings.Avatar.Korblox then
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

services.RunService.RenderStepped:Connect(function()
    if settings.ESP.Enabled and settings.ESP.Active then
        for _, v in pairs(services.Players:GetPlayers()) do
            if v ~= LocalPlayer and not state.Whitelist.Users[v.UserId] and v.Character then
                local root = v.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    if settings.ESP.Box then
                        local box = Instance.new("BoxHandleAdornment")
                        box.Size = Vector3.new(4, 6, 2)
                        box.Color3 = settings.ESP.Color
                        box.Transparency = 0.3
                        box.AlwaysOnTop = true
                        box.ZIndex = 0
                        box.Parent = root
                        services.Debris:AddItem(box, 0.1)
                    end
                    if settings.ESP.Name then
                        local bill = Instance.new("BillboardGui")
                        bill.Size = UDim2.new(0, 120, 0, 24)
                        bill.Adornee = root
                        bill.AlwaysOnTop = true
                        bill.StudsOffset = Vector3.new(0, 3, 0)
                        local label = Instance.new("TextLabel")
                        label.Size = UDim2.new(1, 0, 1, 0)
                        label.Text = v.Name
                        label.TextColor3 = settings.ESP.Color
                        label.BackgroundTransparency = 1
                        label.TextSize = 12
                        label.Font = Enum.Font.Gotham
                        label.Parent = bill
                        bill.Parent = root
                        services.Debris:AddItem(bill, 0.1)
                    end
                end
            end
        end
    end
end)

mouse.Button1Down:Connect(function()
    if settings.Teleport.Enabled and settings.Teleport.Active and LocalPlayer.Character then
        local pos = mouse.Hit.Position
        local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = CFrame.new(pos) end
    end
end)

services.UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.UserInputType == Enum.UserInputType.Keyboard then
        local key = input.KeyCode.Name
        if key == "F6" then
            _main.Visible = not _main.Visible
            return
        end
        if key == settings.Speed.Bind and settings.Speed.Enabled then settings.Speed.Active = not settings.Speed.Active end
        if key == settings.Jump.Bind and settings.Jump.Enabled then settings.Jump.Active = not settings.Jump.Active end
        if key == settings.Spider.Bind and settings.Spider.Enabled then settings.Spider.Active = not settings.Spider.Active end
        if key == settings.ESP.Bind then
            if settings.ESP.Enabled then
                settings.ESP.Active = not settings.ESP.Active
                if not settings.ESP.Active then settings.ESP.Box = false settings.ESP.Name = false end
            end
        end
        if key == settings.Teleport.Bind and settings.Teleport.Enabled then settings.Teleport.Active = not settings.Teleport.Active end
        if settings.Camlock.Enabled and not settings.Camlock.AutoToggle then
            if input.KeyCode == _camGetKeyCode(settings.Camlock.ToggleKey) then
                if settings.Camlock.Mode == "Toggle" then
                    if _Camlock.Active then _camDisable() else _camEnable() end
                elseif settings.Camlock.Mode == "Hold" then
                    _camEnable()
                end
            end
        end
    end
end)

services.UIS.InputEnded:Connect(function(input)
    if settings.Camlock.Enabled and not settings.Camlock.AutoToggle then
        if input.KeyCode == _camGetKeyCode(settings.Camlock.ToggleKey) and settings.Camlock.Mode == "Hold" then
            _camDisable()
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    if settings.Avatar.Headless then
        local head = char:FindFirstChild("Head")
        local face = char:FindFirstChild("Face")
        if head then head.Transparency = 1 end
        if face then face.Transparency = 1 end
    end
    _camDisable()
end)

_applyTheme("Baby Blue")
_showPage("Combat")
