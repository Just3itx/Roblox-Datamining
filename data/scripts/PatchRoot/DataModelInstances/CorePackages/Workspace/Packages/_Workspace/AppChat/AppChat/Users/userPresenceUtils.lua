-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T10:31:16Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local DataHydration = require(AppChatParent.DataHydration)
local PresenceType = require(AppChat.Http.RoduxPresence).Enums.PresenceType
local component_assetsCircle_25 = require(AppChatParent.UIBlox).App.ImageSet.Images["component_assets/circle_25"]

local FFlagAppChatPresenceStoreMigration = require(AppChat.Flags.FFlagAppChatPresenceStoreMigration)

local PresenceType2 = DataHydration.Presence.PresenceEnums.PresenceType

local userPresenceText = {
    [PresenceType.Offline] = "Common.Presence.Label.Offline",
    [PresenceType.Online] = "Common.Presence.Label.Online",
    [PresenceType.InGame] = "",
    [PresenceType.InStudio] = ""
}

local userPresenceImage = {
    [PresenceType.Offline] = "",
    [PresenceType.Online] = component_assetsCircle_25,
    [PresenceType.InGame] = component_assetsCircle_25,
    [PresenceType.InStudio] = component_assetsCircle_25
}

local tbl3 = {
    Offline = "Common.Presence.Label.Offline",
    Online = "Common.Presence.Label.Online",
    InGame = "",
    InStudio = ""
}

local tbl4 = {
    Offline = "",
    Online = component_assetsCircle_25,
    InGame = component_assetsCircle_25,
    InStudio = component_assetsCircle_25
}

local function func1(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local userPresenceType = arg1.userPresenceType
    local lastLocation = arg1.lastLocation

    if userPresenceType == PresenceType.Offline then
        return userPresenceText[PresenceType.Offline]
    elseif userPresenceType == PresenceType.Online then
        return userPresenceText[PresenceType.Online]
    elseif userPresenceType == PresenceType.InGame or userPresenceType == PresenceType.InStudio then
        if lastLocation then
            return tostring(lastLocation)
        end
        return userPresenceText[PresenceType.Online]
    else
        return ""
    end
end

local function getUserPresenceTextFromStore(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    local userPresenceType = arg1.userPresenceType
    local lastLocation = arg1.lastLocation

    if userPresenceType == PresenceType2.Offline then
        return tbl3[PresenceType2.Offline]
    elseif userPresenceType == PresenceType2.Online then
        return tbl3[PresenceType2.Online]
    elseif userPresenceType == PresenceType2.InGame or userPresenceType == PresenceType2.InStudio then
        if lastLocation and lastLocation ~= "" then
            return tostring(lastLocation)
        end
        return tbl3[PresenceType2.Online]
    else
        return ""
    end
end

return {
    getUserDisplayPresence = FFlagAppChatPresenceStoreMigration and function(arg1, bool1: boolean?) -- name: getUserDisplayPresenceFromStoreData
        if not arg1 then
            return { text = "" }
        end

        if bool1 then
            return {
                text = tbl3[PresenceType2.Online],
                image = tbl4[PresenceType2.Online]
            }
        end
        return {
            text = getUserPresenceTextFromStore(arg1),
            image = tbl4[arg1.userPresenceType]
        }
    end or function(arg1, bool1: boolean?)
        if not arg1 then
            return { text = "" }
        end

        return bool1 and {
            text = userPresenceText[PresenceType.Online],
            image = userPresenceImage[PresenceType.Online]
        }
            or {
                text = func1(arg1),
                image = userPresenceImage[arg1.userPresenceType]
            }
    end,
    getUserPresenceText = if FFlagAppChatPresenceStoreMigration then getUserPresenceTextFromStore else func1,
    userPresenceImage = userPresenceImage,
    userPresenceText = userPresenceText,
    storePresenceImage = if FFlagAppChatPresenceStoreMigration then tbl4 else nil,
    storePresenceText = if FFlagAppChatPresenceStoreMigration then tbl3 else nil
}
