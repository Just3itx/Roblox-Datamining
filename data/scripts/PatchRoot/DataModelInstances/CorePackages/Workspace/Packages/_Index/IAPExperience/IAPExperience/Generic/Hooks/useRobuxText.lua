-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T01:10:41Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParent = script.Parent.Parent.Parent
local scriptParentParentParentParent = scriptParentParentParent.Parent
local React = require(scriptParentParentParentParent.React)
local formatNumber = require(scriptParentParentParent.Utility.formatNumber)
local LocalizationService = game:GetService("LocalizationService")
local Foundation = require(scriptParentParentParentParent.Foundation)
local Enums = Foundation.Enums
local getIconRichText = Foundation.Utility.getIconRichText

function useRobuxText(num1: number?)
    return (React.useMemo(function(): string
        local var1 = formatNumber(LocalizationService.RobloxLocaleId, num1 or 0)
        return `{getIconRichText(Enums.IconName.Robux)} {var1}`
    end, { num1, LocalizationService.RobloxLocaleId }))
end

return useRobuxText
