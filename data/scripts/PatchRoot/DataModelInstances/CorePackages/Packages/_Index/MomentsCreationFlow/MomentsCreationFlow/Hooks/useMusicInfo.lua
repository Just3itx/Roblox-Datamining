-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T10:30:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MomentsCreationFlow = script:FindFirstAncestor("MomentsCreationFlow")
local MomentsCreationFlowParent = MomentsCreationFlow.Parent

local AssetService = game:GetService("AssetService")

local MomentsCommon = require(MomentsCreationFlowParent.MomentsCommon)
local React = require(MomentsCreationFlowParent.React)

local CreationFlowMusicInfoRetrieved = require(MomentsCreationFlow.Actions.CreationFlowMusicInfoRetrieved)

local useDispatch = MomentsCommon.Hooks.useDispatch
local useSelector = MomentsCommon.Hooks.useSelector

local Constants = require(MomentsCreationFlow.Constants)

return function(num1: number?): number?
    local var1 = useDispatch()

    local var2 = useSelector(function(arg1)
        return arg1[Constants.RoduxKey].Music[num1]
    end)

    React.useEffect(function()
        if var2 or not num1 then
            return
        end

        task.spawn(function()
            local var3 = AssetService:GetAudioMetadataAsync({ num1 })[1]

            var1(CreationFlowMusicInfoRetrieved({ [num1] = var3 }))
        end)
    end, { num1, var2, var1 })

    return var2
end
