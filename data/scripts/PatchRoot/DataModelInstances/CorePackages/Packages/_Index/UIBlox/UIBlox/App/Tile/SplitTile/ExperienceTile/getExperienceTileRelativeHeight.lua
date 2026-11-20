-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T19:10:56Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParent = script.Parent
local scriptParentParentParentParent = scriptParent.Parent.Parent.Parent
local scriptParentParentParentParentParent = scriptParentParentParentParent.Parent
local scriptParentParentParentParentParentParent = scriptParentParentParentParentParent.Parent
local Cryo = require(scriptParentParentParentParentParentParent.Cryo)

local _StyleTypes = require(scriptParentParentParentParent.Style.StyleTypes)
local setDefault = require(scriptParentParentParentParentParent.Utility.setDefault)
local Constants = require(scriptParent.Constants)
local AspectRatioMode = require(scriptParent.Enum.AspectRatioMode)
local getAspectRatio = require(scriptParent.getAspectRatio)

return function(arg1, arg2, num1: number?, num2: number?, arg3): UDim
    local var1 = Cryo.Dictionary.join(Constants.getDefaultStyleProps(arg1), arg3 or {})
    local var2 = setDefault(num2, Constants.DEFAULT_FOOTER_HEIGHT)
    local var3 = setDefault(num1, Constants.DEFAULT_TEXT_LINE_COUNT)
    local var4 = setDefault(arg2, AspectRatioMode.Square)
    local topContentPadding = var1.topContentPadding
    local bottomContentPadding = var1.bottomContentPadding
    local contentTitleFont = var1.contentTitleFont
    local contentTitlePadding = var1.contentTitlePadding
    local selectionCursorPadding = var1.selectionCursorPadding
    local var5 = selectionCursorPadding.Left + selectionCursorPadding.Right + topContentPadding.Left + topContentPadding.Right

    local var6 = math.floor(var3 * contentTitleFont.RelativeSize * arg1.Font.BaseSize + contentTitlePadding) + var2
    local var7 = topContentPadding.Top + topContentPadding.Bottom
    local var8 = bottomContentPadding.Top + bottomContentPadding.Bottom
    local var9 = selectionCursorPadding.Top + selectionCursorPadding.Bottom
    local var10 = var7 + var8 + var9
    local aspectRatio = getAspectRatio(var4)
    local offset = -1 * var5 * aspectRatio + var6 + var10
    return UDim.new(aspectRatio, offset)
end
