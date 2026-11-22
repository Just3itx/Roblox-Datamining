-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T07:21:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreation = script:FindFirstAncestor("MomentsCreation")
local MomentsCreationParent = MomentsCreation.Parent

local React = require(MomentsCreationParent.React)
local Signals = require(MomentsCreationParent.Signals)

local GetMusicStore = require(MomentsCreation.Stores.GetMusicStore)
local _Music = require(MomentsCreation.Types.Music)

local function useMusicInfo(num1: number?): number?
    local musicStore = GetMusicStore()

    local var1, var2 = React.useState(musicStore.getInfoMap(false))
    React.useEffect(function()
        return Signals.createEffect(function(arg1)
            var2(musicStore.getInfoMap(arg1))
        end)
    end, { musicStore })

    local var3 = if num1 == nil then nil else var1[num1]

    React.useEffect(function()
        if num1 ~= nil and var3 == nil then
            musicStore.fetchInfo(num1)
        end
    end, { num1, var3, musicStore })

    return var3
end

return useMusicInfo
