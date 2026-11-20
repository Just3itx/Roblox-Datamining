-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:11:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParentParentParent = script.Parent.Parent.Parent.Parent
local scriptParentParentParentParentParentParent = scriptParentParentParentParent.Parent.Parent

local React = require(scriptParentParentParentParentParentParent.React)

local LoadableImage = require(scriptParentParentParentParent.Loading.LoadableImage)
local _StyleTypes = require(scriptParentParentParentParent.Style.StyleTypes)

local uDim = UDim.new(0, 8)

local function VerticalTileThumbnail(tbl1)
    local aspectRatio = tbl1.aspectRatio
    local isTopRounded = tbl1.isTopRounded
    local isBottomRounded = tbl1.isBottomRounded
    local thumbnail = tbl1.thumbnail
    local border = tbl1.border

    local var1 = isTopRounded and isBottomRounded
    local var2 = not var1 and (isTopRounded or isBottomRounded)
    local var3 = if border ~= nil then border.CornerRadius else uDim
    local createElement = React.createElement
    local str1 = "Frame"
    local tbl2 = {
        Size = if aspectRatio then UDim2.new(1, 0, aspectRatio, 0) else UDim2.new(1, 0, 1, 0),
        SizeConstraint = if aspectRatio then Enum.SizeConstraint.RelativeXX else nil,
        BackgroundTransparency = 1
    }
    local tbl3 = { TopFrame = 0, BottomFrame = 0 }
    local createElement2 = React.createElement
    local str2 = "Frame"
    local tbl4 = {
        Position = UDim2.fromScale(0, 0),
        Size = UDim2.fromScale(1, if var2 then 0.5 else 1),
        ClipsDescendants = true,
        BackgroundTransparency = 1
    }

    local tbl5 = {
        TopImage = React.createElement(LoadableImage, {
            BackgroundTransparency = 1,
            Image = thumbnail,
            Position = UDim2.fromScale(0, 0),
            Size = UDim2.fromScale(1, if var2 then 2 else 1),
            cornerRadius = if var1 or isTopRounded then var3 else nil,
            showFailedStateWhenLoadingFailed = true,
            useShimmerAnimationWhileLoading = true
        })
    }
    tbl3.TopFrame = createElement2(str2, tbl4, tbl5)
    local var4

    if var2 then
        local createElement3 = React.createElement
        local str3 = "Frame"
        local tbl6 = {
            Position = UDim2.fromScale(0, 0.5),
            Size = UDim2.fromScale(1, 0.5),
            ClipsDescendants = true,
            BackgroundTransparency = 1
        }

        local tbl7 = { BottomImage = 0 }
        local createElement4 = React.createElement
        local var5 = LoadableImage
        local tbl8 = {
            BackgroundTransparency = 1,
            Image = thumbnail,
            Position = UDim2.fromScale(0, -1),
            Size = UDim2.fromScale(1, 2),
            cornerRadius = 0,
            showFailedStateWhenLoadingFailed = true,
            useShimmerAnimationWhileLoading = true
        }

        if not (var1 or isBottomRounded) then
            var3 = nil
        end

        tbl8.cornerRadius = var3
        tbl7.BottomImage = createElement4(var5, tbl8)
        var4 = createElement3(str3, tbl6, tbl7)
    else
        var4 = nil
    end

    tbl3.BottomFrame = var4
    return createElement(str1, tbl2, tbl3)
end

return VerticalTileThumbnail
