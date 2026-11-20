-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:41:17Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

local CoreGui = game:GetService("CoreGui")
local Shell = CoreGui:FindFirstChild("RobloxGui"):FindFirstChild("Modules"):FindFirstChild("Shell")

local Utility = require(Shell:FindFirstChild("Utility"))

local tbl1 = {
    BackgroundLoop = "RobloxMusic.ogg",
    Error = "Error.mp3",
    ButtonPress = "ButtonPress.mp3",
    MoveSelection = "MoveSelection.mp3",
    OverlayOpen = "OverlayOpen.mp3",
    PopUp = "PopUp.mp3",
    PurchaseSuccess = "PurchaseSuccess.mp3",
    ScreenChange = "ScreenChange.mp3",
    SideMenuSlideIn = "SideMenuSlideIn.mp3"
}

local tbl2 = ({})

local function EaseOutCirc(arg1, arg2, arg3, arg4) -- Luacid: unused: defined but never referenced
    arg1 = arg1 / arg4 - 1
    return arg3 * math.sqrt(1 - arg1 * arg1) + arg2
end

local function IsGameRunning()
    if not UserSettings().GameSettings:InStudioMode()
        or game:GetService("UserInputService"):GetPlatform() == Enum.Platform.Windows
    then
        return true
    end
    return RunService:IsRunning()
end

function GetSoundManager()
    local module = { SoundHolder = nil }

    local tbl3 = ({})

    local function FindSoundObjectForName(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
        if not tbl2[arg1] then
            return
        end

        local var1 = table.remove(tbl2[arg1], 1)
        if var1 then
            table.insert(tbl2[arg1], var1)
            return var1
        end
    end

    function module.CreateSound(_, soundName): Sound
        local soundId = "rbxasset://sounds/ui/Shell/" .. tbl1[soundName]

        local sound = Instance.new("Sound")
        sound.Name = soundName
        sound.SoundId = soundId

        return sound
    end

    function module.Play(_, arg1, volume, looped, pitch, ...)
        local var1 = nil

        if tbl1[arg1] then
            local soundObjectForName = FindSoundObjectForName(arg1)

            if soundObjectForName then
                soundObjectForName.Volume = volume or 1

                soundObjectForName.Looped = looped or false
                soundObjectForName.Pitch = pitch or 1

                soundObjectForName:Play(...)

                tbl3[soundObjectForName] = soundObjectForName.Volume
                if not IsGameRunning() then
                    soundObjectForName.Volume = 0
                end

                return soundObjectForName
            end
        else
            spawn(function()
                error("Unable to find sound: " .. tostring(arg1))
            end)
        end

        return var1
    end

    function module.IsPlaying(_, arg1)
        local var1 = module.SoundHolder:FindFirstChild(arg1)
        return if var1 then var1.IsPlaying else false
    end

    function module.Stop(_, arg1, ...)
        if not module.SoundHolder or not tbl1[arg1] then
            return
        end

        local var1 = module.SoundHolder:FindFirstChild(arg1)
        if var1 then
            var1:Stop()
        end
    end

    function module.TweenSound(_, arg1, arg2, arg3)
        tbl3[arg1] = nil
        Utility.PropertyTweener(arg1, "Volume", arg1.Volume, arg2, arg3, function(...)
            return IsGameRunning() and Utility.EaseInOutQuad(...) or 0
        end, true, function()
            tbl3[arg1] = arg2
        end)
    end

    local function Initialize()
        local appShellSounds = Instance.new("Folder")
        appShellSounds.Name = "AppShellSounds"
        appShellSounds.Parent = CoreGui

        module.SoundHolder = appShellSounds

        for folderName, _ in pairs(tbl1) do
            local folder = Instance.new("Folder")
            folder.Name = folderName
            folder.Parent = module.SoundHolder

            tbl2[folderName] = {}

            local var1 = module:CreateSound(folderName)
            var1.Parent = folder
            table.insert(tbl2[folderName], var1)
            local var2 = module:CreateSound(folderName)
            var2.Parent = folder
            table.insert(tbl2[folderName], var2)
            local var3 = module:CreateSound(folderName)
            var3.Parent = folder
            table.insert(tbl2[folderName], var3)
        end

        local var1 = nil
        GuiService:GetPropertyChangedSignal("SelectedCoreObject"):connect(function()
            local selectedCoreObject = GuiService.SelectedCoreObject
            if selectedCoreObject and var1 then
                local moveSelection = selectedCoreObject:FindFirstChild("MoveSelection")
                if moveSelection and moveSelection:IsA("Sound") then
                    moveSelection.Volume = 0.35
                    moveSelection:Play()
                end
            end
            var1 = selectedCoreObject
        end)

        if IsGameRunning() then
            return
        end

        spawn(function()
            while not IsGameRunning() do
                wait(0.1)
            end
            for k, volume in pairs(tbl3) do
                k.Volume = volume
            end
        end)
    end

    Initialize()

    return module
end

return GetSoundManager()
