-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T10:11:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TabTypes = require(script.Parent.TabTypes)
local getOtherDisplayNameInWhisperChannel = require(script.Parent.getOtherDisplayNameInWhisperChannel)

return {
    LocalizationKeys = {
        yourServer = "CoreScripts.TextChat.ChannelTabs.Here",
        moreServers = "CoreScripts.TextChat.ChannelTabs.Global2",
        friends = "CoreScripts.TextChat.ChannelTabs.Friends",
        system = "CoreScripts.TextChat.ChannelTabs.System",
        team = "CoreScripts.TextChat.ChannelTabs.Team"
    },
    getDisplayLabel = function(arg1, str1: string, arg2, arg3, tbl1)
        if arg1 == "TextChat" then
            if string.find(str1, "RBXGeneral") then
                return tbl1.yourServer
            end

            if string.find(str1, "RBXSystem") then
                return tbl1.system
            end

            if string.find(str1, "^RBXTeam") then
                return tbl1.team
            end

            if string.find(str1, "^RBXWhisper") and arg2 and arg3 then
                return getOtherDisplayNameInWhisperChannel(arg2, arg3) or str1
            end
        elseif arg1 == "UniverseChat" then
            if string.find(str1, "RBXGlobal") then
                return tbl1.moreServers
            end
        else
            if arg1 == "FriendsChat" then
                return tbl1.friends
            end
            TabTypes.unreachable(arg1)
        end

        return str1
    end
}
