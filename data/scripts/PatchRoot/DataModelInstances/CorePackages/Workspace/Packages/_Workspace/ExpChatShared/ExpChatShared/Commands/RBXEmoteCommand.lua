-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:20:39Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local StarterPlayer = game:GetService("StarterPlayer")

local _types = require(script.Parent.types)

local ExpChatShared = script:FindFirstAncestor("ExpChatShared")
local var1 = require(ExpChatShared.Logger):new("ExpChat/Command/Emote")

local tbl1 = {
    wave = true,
    point = true,
    dance = true,
    dance1 = true,
    dance2 = true,
    dance3 = true,
    laugh = true,
    cheer = true
}

local function getDanceBasedOnRigType(localCharacter) -- Luacid: Inlined by compiler; 1 call site recovered
    local var2 = nil
    local humanoid = localCharacter:FindFirstChildOfClass("Humanoid")
    if humanoid then
        if humanoid.RigType == Enum.HumanoidRigType.R15 then
            return "dance"
        end

        if humanoid.RigType == Enum.HumanoidRigType.R6 then
            var2 = "dance" .. math.random(1, 3)
        end
    end

    return var2
end

local function handleLegacyEmote(str1: string, localCharacter)
    local success, result = pcall(function()
        local animate = localCharacter:FindFirstChild("Animate")
        if animate then
            local playEmote = animate:FindFirstChild("PlayEmote")
            if playEmote and playEmote:IsA("BindableFunction") then
                if str1 == "dance" then
                    str1 = getDanceBasedOnRigType(localCharacter)
                end
                playEmote:Invoke(str1)
                return true
            end
            var1:debug("PlayEmote BindableFunction does not exist.")
        end

        return false
    end)

    if not (success and result) then
        return {
            key = "InGame.EmotesMenu.ErrorMessageNotSupported",
            metadata = "Roblox.Emote.Error.NotSupported"
        }
    end

    var1:debug("Playing legacy emote successfully")
end

local function getValidEmoteOrResponse(humanoidDescription: HumanoidDescription, str1: string)
    local var2 = tonumber(str1, 10)
    if not var2 then
        local emotes = humanoidDescription:GetEmotes()
        for k, _ in pairs(emotes) do
            if string.lower(k) == str1 then
                return k, nil
            end
        end

        return nil, {
            key = "CoreScripts.TextChat.Emote.Error.NotOwnedGeneric",
            metadata = "Roblox.Emote.Error.NotOwnedGeneric"
        }
    end

    local equippedEmotes = humanoidDescription:GetEquippedEmotes()
    if equippedEmotes[var2] then
        return equippedEmotes[var2].Name, nil
    elseif not (var2 >= 1 and var2 <= 8) then
        return nil, {
            key = "CoreScripts.TextChat.Emote.Error.DoesNotExist",
            metadata = "Roblox.Emote.Error.DoesNotExist"
        }
    end

    return nil, {
        key = "CoreScripts.TextChat.Emote.Error.NotEquipped",
        metadata = "Roblox.Emote.Error.EmoteNotEquipped"
    }
end

return {
    name = script.Name,
    alias = { "/emote", "/e" },
    clientRun = function(arg1, _, arg2)
        local var2 = nil
        if string.sub(arg2, 1, 3):lower() == "/e " then
            var2 = string.sub(arg2, 4)
        elseif string.sub(arg2, 1, 7):lower() == "/emote " then
            var2 = string.sub(arg2, 8)
        end

        if not var2 then
            var1:debug("No emote string given")
            return {
                key = "CoreScripts.TextChat.Emote.Error.DoesNotExist",
                metadata = "Roblox.Emote.Error.DoesNotExist"
            }
        end

        local str1 = string.lower(var2)

        local localCharacter = arg1:getState().LocalCharacter
        if tbl1[str1] then
            var1:trace("Legacy emote found")
            return handleLegacyEmote(str1, localCharacter)
        elseif not StarterPlayer.UserEmotesEnabled then
            var1:debug("Experience does not have emotes enabled")
            return {
                key = "CoreScripts.TextChat.Emote.Error.NotEnabled",
                metadata = "Roblox.Emote.Error.UserEmotesNotEnabled"
            }
        elseif not localCharacter then
            var1:debug("No character loaded")
            return {
                key = "InGame.EmotesMenu.ErrorMessageTemporarilyUnavailable",
                metadata = "Roblox.Emote.Error.TemporarilyUnavailable"
            }
        elseif not localCharacter:FindFirstChild("Animate") then
            var1:debug("Animate script missing")
            return {
                key = "InGame.EmotesMenu.ErrorMessageNotSupported",
                metadata = "Roblox.Emote.Error.NotSupported"
            }
        else
            local humanoid = localCharacter:FindFirstChildOfClass("Humanoid")
            if not humanoid then
                var1:debug("Humanoid missing")
                return {
                    key = "InGame.EmotesMenu.ErrorMessageTemporarilyUnavailable",
                    metadata = "Roblox.Emote.Error.TemporarilyUnavailable"
                }
            elseif humanoid.RigType ~= Enum.HumanoidRigType.R15 then
                var1:debug("Humanoid.RigType is not R15")
                return {
                    key = "InGame.EmotesMenu.ErrorMessageSwitchToR15",
                    metadata = "Roblox.Emote.Error.SwitchToR15"
                }
            else
                local humanoidDescription = humanoid:FindFirstChildOfClass("HumanoidDescription")
                if not humanoidDescription then
                    var1:debug("HumanoidDescription missing")
                    return {
                        key = "InGame.EmotesMenu.ErrorMessageNotSupported",
                        metadata = "Roblox.Emote.Error.NotSupported"
                    }
                end

                local emoteName, var3 = getValidEmoteOrResponse(humanoidDescription, str1)

                if not emoteName then
                    var1:debug("Could not find a valid emote within HumanoidDescription")
                    return var3
                end

                local success, result = pcall(function(): boolean
                    return humanoid:PlayEmoteAsync(emoteName)
                end)
                if not (success and result) then
                    var1:debug("Humanoid:PlayEmote encountered an error: {}", result)
                    return {
                        key = "InGame.EmotesMenu.ErrorMessageAnimationPlaying",
                        metadata = "Roblox.Emote.Error.AnimationPlaying"
                    }
                end

                var1:debug("Playing emote: {}", tostring(emoteName))

                return nil
            end
        end
    end
}
