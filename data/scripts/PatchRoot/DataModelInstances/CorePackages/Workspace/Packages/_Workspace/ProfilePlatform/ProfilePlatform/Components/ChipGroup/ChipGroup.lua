-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T04:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfilePlatform = script:FindFirstAncestor("ProfilePlatform")
local ProfilePlatformParent = ProfilePlatform.Parent

local React = require(ProfilePlatformParent.React)
local Foundation = require(ProfilePlatformParent.Foundation)
local _Types = require(ProfilePlatform.Common.Types)

local Chip = Foundation.Chip
local View = Foundation.View

local uDim2 = UDim2.new(1, 0, 0, 32)

function ChipGroup(tbl1)
    local ref = React.useRef(nil)
    local var1 = React.useRef(nil)
    local var3, var4 = React.useState(0)
    local var5, var6 = React.useState(0)
    local scrollingEnabled, var8 = React.useState(false)

    React.useEffect(function()
        if tbl1.scrollingEnabledOverride ~= nil then
            var8(tbl1.scrollingEnabledOverride)
            return
        end
        var8(var5 < var3)
    end, { var3, var5, tbl1.scrollingEnabledOverride })

    if #tbl1.chips == 0 then
        return nil
    end

    local var9 = React.useMemo(function()
        local result = ({})

        for i, chip in ipairs(tbl1.chips) do
            local text = chip.text
            if chip.count then
                text = `{chip.count} {chip.text}`
            end

            local tbl2 = {
                text = text,
                onActivated = chip.onActivated,
                isDisabled = chip.isDisabled or false,
                isChecked = false,
                LayoutOrder = chip.layoutOrder or i,
                size = chip.size or "Medium",
                leading = chip.leading,
                trailing = chip.trailing
            }
            result[i] = React.createElement(Chip, tbl2)
        end

        return result
    end, { tbl1.chips })

    local var10 = React.useCallback(function(arg1)
        var6(arg1.AbsoluteSize.X)
    end, {})

    local onAbsoluteSizeChanged = React.useCallback(function(arg1)
        var4(arg1.AbsoluteSize.X)
    end, {})

    local createElement = React.createElement
    local tbl2 = {
        BackgroundTransparency = 1,
        LayoutOrder = tbl1.layoutOrder,
        Size = tbl1.size or uDim2
    }
    local tbl3 = {
        DynamicScrollingFrame = React.createElement("ScrollingFrame", {
            ref = ref,
            AutomaticCanvasSize = Enum.AutomaticSize.X,
            BackgroundTransparency = 1,
            CanvasSize = tbl1.size or uDim2,
            ClipsDescendants = false,
            ElasticBehavior = Enum.ElasticBehavior.Always,
            ScrollBarThickness = 0,
            ScrollingDirection = Enum.ScrollingDirection.X,
            ScrollingEnabled = scrollingEnabled,
            Selectable = false,
            Size = tbl1.size or uDim2,
            ZIndex = 1,
            [React.Change.AbsoluteSize] = var10
        }, {
            ChipRow = React.createElement(View, {
                ref = var1,
                tag = "row gap-small auto-y size-full-0",
                AutomaticSize = Enum.AutomaticSize.X,
                onAbsoluteSizeChanged = onAbsoluteSizeChanged
            }, table.unpack(var9))
        })
    }
    return createElement("Frame", tbl2, tbl3)
end

return ChipGroup
