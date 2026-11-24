-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T20:11:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceShopParent = script:FindFirstAncestor("InExperienceShop").Parent

local React = require(InExperienceShopParent.React)
local Foundation = require(InExperienceShopParent.Foundation)

local Image = Foundation.Image
local FoundationText = Foundation.Text
local View = Foundation.View
local useTokens = Foundation.Hooks.useTokens

local function TopBarChip(tbl1)
    local var1 = useTokens()
    local borderWidth = math.floor(var1.Stroke.Thicker)
    local bool1 = tbl1.isEmphasis == true

    local createElement = React.createElement
    local var2 = View
    local tbl2 = {
        tag = {
            ["row align-x-center align-y-center shrink size-0-1000 auto-x radius-circle clip bg-system-emphasis"] = bool1,
            ["row align-x-center align-y-center shrink size-0-1000 auto-x radius-circle clip bg-over-media-300"] = not bool1
        },
        onActivated = tbl1.onActivated,
        onStateChanged = tbl1.onStateChanged,
        isDisabled = tbl1.isDisabled,
        GroupTransparency = if tbl1.isDisabled then 0.5 else 0,
        selection = {
            Selectable = tbl1.isDisabled ~= true
        },
        LayoutOrder = tbl1.LayoutOrder,
        ref = tbl1.chipRef,
        testId = tbl1.testId,
        sizeConstraint = tbl1.maxWidth ~= nil and {
            MaxSize = Vector2.new(tbl1.maxWidth, math.huge)
        } or nil,
        cursor = {
            radius = UDim.new(0, var1.Radius.Circle),
            offset = borderWidth * 2,
            borderWidth = borderWidth
        }
    }
    local tbl3 = { Leading = 0, Label = 0 }
    local createElement2 = React.createElement
    local var3 = View
    local tbl4 = {
        tag = "auto-xy",
        LayoutOrder = 1,
        padding = {
            left = UDim.new(0, var1.Size.Size_250)
        }
    }
    local tbl5 = { ImagePlate = 0 }
    local createElement3 = React.createElement
    local var4 = View
    local tbl6 = { tag = "size-600 radius-circle clip bg-shift-200" }

    local tbl7 = {
        Image = React.createElement(Image, {
            Image = tbl1.image,
            tag = "size-full",
            testId = if tbl1.testId == nil then nil else `{tbl1.testId}--image`
        })
    }
    tbl5.ImagePlate = createElement3(var4, tbl6, tbl7)
    tbl3.Leading = createElement2(var3, tbl4, tbl5)

    tbl3.Label = React.createElement(FoundationText, {
        Text = tbl1.text,
        LayoutOrder = 2,
        tag = {
            ["shrink size-0-full auto-x text-label-large text-no-wrap text-align-x-center text-align-y-center text-truncate-end content-action-emphasis"] = bool1,
            ["shrink size-0-full auto-x text-label-large text-no-wrap text-align-x-center text-align-y-center text-truncate-end content-action-standard"] = not bool1
        },
        padding = {
            left = UDim.new(0, var1.Padding.Small),
            right = UDim.new(0, var1.Padding.Large)
        }
    })
    return createElement(var2, tbl2, tbl3)
end

return TopBarChip
