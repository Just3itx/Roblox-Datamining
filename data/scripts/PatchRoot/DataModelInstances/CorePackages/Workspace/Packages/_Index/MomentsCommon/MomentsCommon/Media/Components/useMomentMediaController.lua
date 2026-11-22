-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T06:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCommon = script:FindFirstAncestor("MomentsCommon")
local MomentsCommonParent = MomentsCommon.Parent

local React = require(MomentsCommonParent.React)
local Signals = require(MomentsCommonParent.Signals)
local SignalsReact = require(MomentsCommonParent.SignalsReact)

local _MediaTypes = require(MomentsCommon.Media.MediaTypes)
local MediaPreloadProvider = require(MomentsCommon.Media.Components.MediaPreloadProvider)

local useSignalState = SignalsReact.useSignalState

local function useMomentMediaController(str1: string)
    local var1 = MediaPreloadProvider.useMediaControllerProvider()

    local var2 = React.useMemo(function()
        return Signals.createComputed(function(arg1)
            if var1 == nil then
                return nil
            end

            return var1.getControllerMap(arg1)[str1]
        end)
    end, { var1, str1 })

    return useSignalState(var2)
end

return useMomentMediaController
