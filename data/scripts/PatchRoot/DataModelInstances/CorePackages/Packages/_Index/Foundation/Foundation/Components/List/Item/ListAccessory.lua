-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T08:20:48Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local uiblox = require(FoundationParent.BuilderIcons).Migration.uiblox

local Icon = require(Foundation.Components.Icon)
local Image = require(Foundation.Components.Image)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)
local iconMigrationUtils = require(Foundation.Utility.iconMigrationUtils)
local useTokens = require(Foundation.Providers.Style.useTokens)
local isMigrated = iconMigrationUtils.isMigrated
local isBuilderOrMigratedIcon = iconMigrationUtils.isBuilderOrMigratedIcon
local StateLayerAffordance = require(FoundationParent.Foundation.Enums.StateLayerAffordance)

local AccessoryType = require(Foundation.Enums.AccessoryType)

local Avatar = require(Foundation.Components.Avatar)

local useListAccessoryVariants = require(script.Parent.useListAccessoryVariants)

local _InputSize = require(Foundation.Enums.InputSize)

return React.memo(function(tbl1) -- name: ListAccessory
    local var1 = useTokens()
    local var2 = React.useMemo(function()
        return if type(tbl1.config) == "string" then {
            iconName = tbl1.config
        } else tbl1.config
    end, { tbl1.config })

    local var3 = if var2.type == AccessoryType.Avatar then AccessoryType.Avatar elseif type(tbl1.config) == "string" or isBuilderOrMigratedIcon(var2.iconName) then AccessoryType.Icon else AccessoryType.Media
    local var4 = useListAccessoryVariants(var1, tbl1.size, var3)
    local element

    if var2.type == AccessoryType.Avatar then
        element = React.createElement(Avatar, { userId = var2.userId, backplateStyle = var1.Color.Shift.Shift_200, size = tbl1.size })
    elseif isBuilderOrMigratedIcon(var2.iconName) then
        element = React.createElement(Icon, {
            name = if isMigrated(var2.iconName) then uiblox[var2.iconName].name else var2.iconName,
            variant = if isMigrated(var2.iconName) then uiblox[var2.iconName].variant else var2.iconVariant,
            size = var4.accessory.Size.Y.Offset
        })
    else
        element = React.createElement(
            Image,
            {
                Image = var2.iconName,
                Size = var4.accessory.Size,
                cornerRadius = var4.accessory.cornerRadius
            }
        )
    end
    return React.createElement(View, {
        Size = var4.container.Size,
        tag = "align-x-center align-y-center",
        stateLayer = {
            affordance = StateLayerAffordance.None
        },
        isDisabled = tbl1.isDisabled,
        LayoutOrder = tbl1.LayoutOrder,
        testId = tbl1.testId
    }, element)
end)
