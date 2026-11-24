-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")
local InExperienceSideSheetParent = InExperienceSideSheet.Parent

local Foundation = require(InExperienceSideSheetParent.Foundation)
local React = require(InExperienceSideSheetParent.React)
local SignalsReact = require(InExperienceSideSheetParent.SignalsReact)

local GetSideSheetConfigStore = require(InExperienceSideSheet.Stores.GetSideSheetConfigStore)

local useTokens = Foundation.Hooks.useTokens

local function getBackgroundTransparency(arg1)
    return GetSideSheetConfigStore(arg1).getBackgroundTransparency(arg1)
end

local function useBackgroundStyle()
    local var1 = useTokens()
    local var2 = SignalsReact.useSignalBinding(getBackgroundTransparency)

    return (React.useMemo(function()
        return var2:map(function(transparency)
            return {
                Color3 = var1.Color.OverMedia.OverMedia_0.Color3,
                Transparency = transparency
            }
        end)
    end, { var1.Color.OverMedia.OverMedia_0.Color3 }))
end

return useBackgroundStyle
