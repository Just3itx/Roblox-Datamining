-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T12:21:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local React = require(scriptParentParentParent.React)
local UIBlox = require(scriptParentParentParent.UIBlox)

local Cryo = require(scriptParentParentParent.Cryo)
local Responsive = require(scriptParentParentParent.Responsive)

local AppHeaderBarComponent = require(script.Parent.AppHeaderBarComponent)

local useStyle = UIBlox.Core.Style.useStyle
local useBreakpointXOrLarger = Responsive.useBreakpointXOrLarger
local usePreferredInput = Responsive.usePreferredInput

local _Types = require(scriptParentParent.Types)

local function AppHeaderBarResponsive(arg1)
    local var1 = useBreakpointXOrLarger(Responsive.Keys.Medium)
    local var2 = useBreakpointXOrLarger(Responsive.Keys.Large)
    local bool1 = usePreferredInput() == Responsive.Input.Directional
    local tokens = useStyle().Tokens
    local titleFontStyle = arg1.titleFontStyle
    local shouldRenderTitle = arg1.shouldRenderTitle
    local shouldRenderCenter = arg1.shouldRenderCenter
    local isTitleCentered = arg1.isTitleCentered
    local utilitiesGap = arg1.utilitiesGap
    local paddingTop = arg1.paddingTop
    local paddingBottom = arg1.paddingBottom
    local onMedia = arg1.onMedia

    local var3 = React.useMemo(function()
        local tbl1 = {
            title = if var2 and bool1 then Cryo.None else nil,
            renderCenter = if var2 and not bool1 or shouldRenderCenter then nil else Cryo.None,
            renderUserInfo = if var2 then nil else Cryo.None,
            avatarActionIcon = if var2 then Cryo.None else nil,
            searchActionIcon = if var2 and not bool1 then Cryo.None else nil,
            paddingTop = if var2 and not paddingTop then UDim.new(0, tokens.Size.Size_400) else nil,
            paddingBottom = if var2 and not paddingBottom then UDim.new(0, tokens.Size.Size_400) else nil,
            onMedia = if var2 and bool1 and onMedia == nil then true else nil
        }

        if shouldRenderTitle then
            tbl1.title = nil
        end

        local var3 = if var1 and not isTitleCentered then tokens.Typography.HeadingLarge else tokens.Typography.HeadingSmall

        if titleFontStyle then
            var3 = nil
        end

        tbl1.titleFontStyle = var3
        local uDim = if var1 then UDim.new(0, tokens.Size.Size_600) else UDim.new(0, tokens.Size.Size_400)

        if utilitiesGap then
            uDim = nil
        end

        tbl1.utilitiesGap = uDim

        return tbl1
    end, {
        var1,
        var2,
        bool1,
        tokens,
        titleFontStyle,
        shouldRenderCenter,
        isTitleCentered,
        utilitiesGap,
        paddingTop,
        paddingBottom,
        onMedia
    })

    local var4 = Cryo.Dictionary.join(arg1, var3)
    return React.createElement(AppHeaderBarComponent, var4)
end

return AppHeaderBarResponsive
