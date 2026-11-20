-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T05:51:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")
local FoundationParent = Foundation.Parent

local React = require(FoundationParent.React)

local BaseTile = require(Foundation.Components.Tile.BaseTile)
local ControlState = require(Foundation.Enums.ControlState)
local Metadata = require(Foundation.Components.Metadata)
local MetadataSize = require(Foundation.Enums.MetadataSize)
local Text = require(Foundation.Components.Text)
local TileAspectRatio = require(Foundation.Enums.TileAspectRatio)
local TilePlayerAvatar = require(script.Parent.TilePlayerAvatar)
local _Types = require(Foundation.Components.Types)
local _UserPresence = require(Foundation.Enums.UserPresence)
local View = require(Foundation.Components.View)
local useTokens = require(Foundation.Providers.Style.useTokens)
local withDefaults = require(Foundation.Utility.withDefaults)

local tbl1 = {
    Size = UDim2.fromScale(1, 0),
    testId = "--foundation-tile-player"
}

return React.memo(React.forwardRef(function(arg1, ref) -- name: TilePlayer
    local var1 = withDefaults(arg1, tbl1)
    local var2 = useTokens()
    local var3, var4 = React.useBinding(ControlState.Default)

    local createElement = React.createElement
    local var5 = BaseTile
    local tbl2 = {
        mediaAspectRatio = TileAspectRatio.Ratio1x1,
        mediaBackgroundStyle = var2.Color.None,
        mediaContent = 0,
        title = 0,
        metadata = 0,
        onActivated = 0,
        onStateChanged = 0,
        Size = 0,
        maxSize = 0,
        AnchorPoint = 0,
        LayoutOrder = 0,
        Position = 0,
        Visible = 0,
        ZIndex = 0,
        onAbsoluteSizeChanged = 0,
        onAbsolutePositionChanged = 0,
        testId = 0,
        ref = 0
    }
    local createElement2 = React.createElement
    local var6 = TilePlayerAvatar
    local tbl3 = {
        userId = var1.userId,
        userPresence = var1.userPresence,
        includeProfileFrame = var1.includeProfileFrame,
        backgroundStyle = var1.backgroundStyle,
        controlState = 0,
        testId = 0
    }

    if not var1.onActivated then
        var3 = nil
    end

    tbl3.controlState = var3
    tbl3.testId = var1.testId
    tbl2.mediaContent = createElement2(var6, tbl3)

    tbl2.title = React.createElement(Text, {
        Text = var1.title,
        tag = "size-full-0 auto-y text-title-small text-align-x-center text-truncate-split content-emphasis",
        testId = `{var1.testId}--title`
    })
    tbl2.metadata = if var1.metadata then React.createElement(View, {
        tag = "col align-x-center size-full-0 auto-y"
    }, {
        Metadata = React.createElement(
            Metadata,
            {
                text = var1.metadata,
                size = MetadataSize.Small,
                testId = `{var1.testId}--metadata`
            }
        )
    }) else nil

    tbl2.onActivated = var1.onActivated
    if not var1.onActivated then
        var4 = nil
    end

    tbl2.onStateChanged = var4
    tbl2.Size = var1.Size
    tbl2.maxSize = Vector2.new(var2.Size.Size_2400, math.huge)
    tbl2.AnchorPoint = var1.AnchorPoint
    tbl2.LayoutOrder = var1.LayoutOrder
    tbl2.Position = var1.Position
    tbl2.Visible = var1.Visible
    tbl2.ZIndex = var1.ZIndex
    tbl2.onAbsoluteSizeChanged = var1.onAbsoluteSizeChanged
    tbl2.onAbsolutePositionChanged = var1.onAbsolutePositionChanged
    tbl2.testId = var1.testId
    tbl2.ref = ref
    return createElement(var5, tbl2)
end))
