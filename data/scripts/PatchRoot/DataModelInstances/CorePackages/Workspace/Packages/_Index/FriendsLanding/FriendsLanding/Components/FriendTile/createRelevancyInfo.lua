-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T15:50:45Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FriendsLanding = script:FindFirstAncestor("FriendsLanding")
local dependencies = require(FriendsLanding.dependencies)
local UIBlox = dependencies.UIBlox
local isUserInGame = require(FriendsLanding.Friends.isUserInGame)
local getCorrectUserPresence = require(FriendsLanding.Friends.getCorrectUserPresence)
local NotLocalizedStrings = require(FriendsLanding.Enums.NotLocalizedStrings)
local Images = UIBlox.App.ImageSet.Images

local PresenceType = dependencies.RoduxPresence.Enums.PresenceType

local uDim2 = UDim2.fromOffset(12, 12)

return function(arg1, text: string, str1: string?, _, arg2, _: number, bool1: boolean?, arg3, text2: string?, bool2: boolean?)
    local result = {}
    local correctUserPresence = getCorrectUserPresence(arg1)

    result.icon = str1 and Images[str1] or nil

    if correctUserPresence == PresenceType.Online then
        if not bool2 then
            result.iconSize = uDim2
        end
        result.iconColor = arg2.OnlineStatus.Color
        result.iconTransparency = arg2.OnlineStatus.Transparency
    end

    if arg1.isDeleted then
        result.text = text2
    elseif isUserInGame(arg1) then
        result.text = arg1.lastLocation
    elseif arg1.userPresenceType ~= PresenceType.InStudio then
        result.text = text
    elseif arg1.lastLocation and arg1.lastLocation ~= "" then
        result.text = arg1.lastLocation
    else
        result.text = bool1 and NotLocalizedStrings.StudioPresenceTextLuobu.rawValue()
            or NotLocalizedStrings.StudioPresenceTextGlobal.rawValue()
    end

    if not bool2 and arg3 then
        result.fontStyle = isUserInGame(arg1) and arg3.CaptionHeader or arg3.CaptionBody
    end

    return result
end
