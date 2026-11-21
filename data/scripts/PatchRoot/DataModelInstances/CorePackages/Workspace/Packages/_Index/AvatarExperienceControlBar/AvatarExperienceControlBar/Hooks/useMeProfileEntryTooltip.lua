-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T03:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppStorageService = game:GetService("AppStorageService")

local AvatarExperienceControlBarParent = script:FindFirstAncestor("AvatarExperienceControlBar").Parent
local React = require(AvatarExperienceControlBarParent.React)

local bool1 = false

local function useMeProfileEntryTooltip(bool2: boolean, str1: string?)
    local var1, var2 = React.useState(nil)

    React.useEffect(function()
        if not bool2 or bool1 then
            var2(nil)
        else
            local success, result = pcall(function(): string
                return AppStorageService:GetItem("MeProfileEntryTooltipShown")
            end)
            var2(if success and result == "1" then nil else str1)
        end
    end, { bool2, str1 })

    local onShown = React.useCallback(function()
        if bool1 then
            return
        end

        bool1 = true
        pcall(function()
            AppStorageService:SetItem("MeProfileEntryTooltipShown", "1")
            AppStorageService:Flush()
        end)
    end, {})

    local showTooltip = bool2 and not (str1 == nil) and var1 == str1

    return {
        showTooltip = showTooltip,
        onShown = onShown,
        dismiss = React.useCallback(function()
            if showTooltip then
                onShown()
            end
            var2(nil)
        end, { showTooltip, onShown })
    }
end

return useMeProfileEntryTooltip
