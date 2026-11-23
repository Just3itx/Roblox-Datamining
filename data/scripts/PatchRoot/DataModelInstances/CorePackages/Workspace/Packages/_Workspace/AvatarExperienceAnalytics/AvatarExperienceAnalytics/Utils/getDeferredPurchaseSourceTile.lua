-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:51:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AvatarExperienceAnalytics = script:FindFirstAncestor("AvatarExperienceAnalytics")

local UnifiedEventLogConstants = require(AvatarExperienceAnalytics.UnifiedEventLogConstants)

local function getDeferredPurchaseSourceTile(tbl1, arg1, str1: string?, num1: number?)
    if str1 == nil then
        return nil
    end

    local var1 = UnifiedEventLogConstants.ATTRIBUTE_PREFIX .. "itemId"
    local var2 = UnifiedEventLogConstants.ATTRIBUTE_PREFIX .. "itemType"

    local var3 = nil
    for _, value in tbl1 do
        if value == arg1
            or tostring(value:GetAttribute(var1)) ~= tostring(str1)
            or tostring(value:GetAttribute(var2)) ~= tostring(num1)
        then
            continue
        end
        local bool1 = value:GetAttribute(UnifiedEventLogConstants.SKIP_IMPRESSION_DETECTION) == true
        local isGuiObject = value:IsA("GuiObject")

        if isGuiObject then
            if value.AbsoluteSize.X > 0 then
                isGuiObject = value.AbsoluteSize.Y > 0
            else
                isGuiObject = false
            end
        end

        if bool1 and isGuiObject then
            return value
        end

        if var3 == nil then
            var3 = value
        end
    end

    return var3
end

return getDeferredPurchaseSourceTile
