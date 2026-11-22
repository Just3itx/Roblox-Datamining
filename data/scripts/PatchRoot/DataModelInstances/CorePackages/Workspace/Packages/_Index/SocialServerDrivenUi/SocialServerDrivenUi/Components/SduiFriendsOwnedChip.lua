-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T19:51:13Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialServerDrivenUiParent = script:FindFirstAncestor("SocialServerDrivenUi").Parent

local React = require(SocialServerDrivenUiParent.React)
local SduiCoreSystem = require(SocialServerDrivenUiParent.SduiCoreSystem)
local FriendsOwnedChip = require(SocialServerDrivenUiParent.SocialProof).Chips.FriendsOwnedChip
local SduiErrorType = SduiCoreSystem.SduiErrors.SduiErrorType

local tbl1 = { Asset = "Asset", Bundle = "Bundle" }

local function readItemId(itemId) -- Luacid: Inlined by compiler; 1 call site recovered
    if typeof(itemId) == "number" then
        return tostring(itemId)
    end
    return if typeof(itemId) == "string" and itemId ~= "" then itemId else nil
end

return React.memo(function(tbl2) -- name: SduiFriendsOwnedChip
    local itemId = readItemId(tbl2.itemId)
    local itemType = tbl2.itemType
    local var1 = if itemType then tbl1[itemType] else nil
    local bool1 = not (itemId == nil) and var1 ~= nil
    local sduiContext = tbl2.sduiContext
    React.useEffect(function()
        if bool1 then
            return
        end
        sduiContext.dependencies.logger.reportError(
            SduiErrorType.InvalidProps,
            {
                name = "FriendsOwnedChip",
                message = `Unsupported item: {itemType} {itemId}`
            },
            sduiContext.appPage
        )
    end, {
        bool1,
        sduiContext,
        itemType,
        itemId
    })
    if itemId == nil or var1 == nil then
        return nil
    end

    return React.createElement(
        FriendsOwnedChip,
        {
            itemId = itemId,
            itemType = var1,
            fromProfile = false,
            layoutOrder = tbl2.layoutOrder
        }
    )
end)
