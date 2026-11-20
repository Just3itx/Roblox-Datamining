-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:50:33Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Badge = require(Foundation.Components.Badge)
local BuilderIcons = require(FoundationParent.BuilderIcons)
local Icon = require(Foundation.Components.Icon)
local _IconSize = require(Foundation.Enums.IconSize)
local Image = require(Foundation.Components.Image)
local StatusIndicator = require(Foundation.Components.StatusIndicator)
local _StatusIndicatorShape = require(Foundation.Enums.StatusIndicatorShape)
local _StatusIndicatorVariant = require(Foundation.Enums.StatusIndicatorVariant)
local _Types = require(Foundation.Components.Types)
local getIconScale = require(Foundation.Utility.getIconScale)
local iconMigrationUtils = require(Foundation.Utility.iconMigrationUtils)
local isMigrated = iconMigrationUtils.isMigrated
local isBuilderOrMigratedIcon = iconMigrationUtils.isBuilderOrMigratedIcon

local uiblox = BuilderIcons.Migration.uiblox

return {
    resolve = function(iconName, iconName2, iconName3, tbl1)
        local var1 = if iconName3 ~= nil then typeof(iconName3) == "string" and {
            iconName = iconName3
        }
            or {
                iconName = iconName3.name,
                iconVariant = iconName3.variant
            } else typeof(iconName) == "string" and { iconName = iconName } or iconName

        if tbl1 ~= nil then
            return var1, {
                type = "StatusIndicator",
                variant = tbl1.variant,
                shape = tbl1.shape,
                value = tbl1.value,
                max = tbl1.max
            }
        elseif typeof(iconName2) == "string" then
            return var1, { iconName = iconName2 }
        end

        return var1, iconName2
    end,
    TabItemAccessory = function(tbl1)
        local accessory = tbl1.accessory

        if accessory.type == "Badge" then
            return React.createElement(Badge, {
                text = accessory.text,
                icon = accessory.icon,
                variant = accessory.variant,
                LayoutOrder = tbl1.LayoutOrder,
                testId = tbl1.testId
            })
        elseif accessory.type == "StatusIndicator" then
            return React.createElement(
                StatusIndicator,
                accessory.value
                    and {
                        value = accessory.value,
                        variant = accessory.variant,
                        max = accessory.max,
                        LayoutOrder = tbl1.LayoutOrder,
                        testId = tbl1.testId
                    }
                    or {
                        variant = accessory.variant,
                        shape = accessory.shape,
                        LayoutOrder = tbl1.LayoutOrder,
                        testId = tbl1.testId
                    }
            )
        elseif isBuilderOrMigratedIcon(accessory.iconName) then
            return React.createElement(Icon, {
                name = if isMigrated(accessory.iconName) then uiblox[accessory.iconName].name else accessory.iconName,
                variant = if isMigrated(accessory.iconName) then uiblox[accessory.iconName].variant else accessory.iconVariant,
                size = tbl1.iconSize,
                style = tbl1.contentStyle,
                LayoutOrder = tbl1.LayoutOrder,
                testId = tbl1.testId
            })
        else
            local var1, scale = getIconScale(accessory.iconName, tbl1.iconSize)
            if var1 then
                return React.createElement(Image, {
                    Image = accessory.iconName,
                    Size = UDim2.fromOffset(var1.X, var1.Y),
                    imageStyle = tbl1.contentStyle,
                    scale = scale,
                    LayoutOrder = tbl1.LayoutOrder,
                    testId = tbl1.testId
                })
            end

            return nil
        end
    end
}
