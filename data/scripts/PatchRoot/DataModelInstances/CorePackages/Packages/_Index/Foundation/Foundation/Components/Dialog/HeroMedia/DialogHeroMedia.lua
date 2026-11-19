-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T07:50:48Z
-- Luau bytecode version: 9 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local Constants = require(Foundation.Constants)
local Image = require(Foundation.Components.Image)
local _Types = require(Foundation.Components.Types)
local View = require(Foundation.Components.View)

local _DialogSize = require(Foundation.Enums.DialogSize)

local useDialog = require(script.Parent.Parent.useDialog)
local withDefaults = require(Foundation.Utility.withDefaults)
local useDialogVariants = require(script.Parent.Parent.useDialogVariants).useDialogVariants

local tbl1 = {
    height = UDim.new(1, 0)
}

local function DialogHeroMedia(tbl2)
    local var1 = withDefaults(tbl2, tbl1)
    local var2 = useDialog()
    local var3 = useDialogVariants()

    React.useEffect(function()
        var2.setHasHeroMedia(true)

        return function()
            var2.setHasHeroMedia(false)
        end
    end, {})

    local offsetX = var3.heroMedia.offsetX

    return React.createElement(View, {
        tag = var3.heroMediaWrapper.tag,
        LayoutOrder = Constants.MIN_LAYOUT_ORDER,
        testId = `{var2.testId}--hero-media`
    }, {
        Image = React.createElement(Image, {
            Image = var1.media,
            imageStyle = var1.mediaStyle,
            backgroundStyle = var1.backgroundStyle,
            tag = var3.heroMedia.tag,
            aspectRatio = var1.aspectRatio,
            ScaleType = var1.scaleType,
            testId = `{var2.testId}--hero-media-image`,
            Position = UDim2.fromOffset(-offsetX, 0),
            Size = UDim2.new(1, offsetX * 2, var1.height.Scale, var1.height.Offset)
        })
    })
end

return DialogHeroMedia
