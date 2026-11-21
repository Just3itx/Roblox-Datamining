-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T20:51:09Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GamePlayButtonParent = script:FindFirstAncestor("GamePlayButton").Parent

local React = require(GamePlayButtonParent.React)
local Foundation = require(GamePlayButtonParent.Foundation)
local useTokens = Foundation.Hooks.useTokens
local normalizeFontFace = Foundation.Utility.normalizeFontFace

local useDispatch = require(GamePlayButtonParent.RoactUtils).Hooks.RoactRodux.useDispatch

local useRoactService = require(GamePlayButtonParent.RobloxAppHooks).useRoactService
local AppLinking = require(GamePlayButtonParent.RoactServiceTags).AppLinking

local CentralOverlay = require(GamePlayButtonParent.CentralOverlay)
local SetCentralOverlay = CentralOverlay.Actions.SetCentralOverlay
local CloseCentralOverlay = CentralOverlay.Thunks.CloseCentralOverlay
local CentralOverlayType = require(GamePlayButtonParent.RobloxAppEnums).CentralOverlayType

local extractAndStyleRichTextLinks = require(GamePlayButtonParent.DiscoveryUtils).extractAndStyleRichTextLinks

local function PlayButtonUpsellBody(tbl1)
    local var1 = useTokens()
    local var2 = useDispatch()
    local var3 = useRoactService(AppLinking)

    local var4 = React.useMemo(function()
        local var4, styledText = extractAndStyleRichTextLinks(tbl1.bodyText)

        return {
            link = if #var4 > 0 then var4[1] else nil,
            styledText = styledText
        }
    end, { tbl1.bodyText })

    local var5 = React.useCallback(function()
        if not var4.link then
            return
        end

        tbl1.onCloseModal()

        var2(SetCentralOverlay(CentralOverlayType.LeaveRobloxAlert, {
            continueFunc = function()
                var3:openURL(var4.link)
                var2(CloseCentralOverlay())
            end
        }))
    end, {
        tbl1.onCloseModal,
        var4.link,
        var2,
        var3
    })
    local createElement = React.createElement
    local str1 = "TextButton"
    local tbl2 = {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        RichText = true,
        Size = UDim2.new(1, 0, 0, 0),
        Text = var4.styledText,
        TextSize = var1.Typography.BodyLarge.FontSize,
        FontFace = normalizeFontFace(var1.Typography.BodyLarge.Font),
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        TextColor3 = var1.Color.Content.Emphasis.Color3,
        Active = var4.link ~= nil,
        Selectable = var4.link ~= nil
    }
    local activated = React.Event.Activated

    if not var4.link then
        var5 = nil
    end

    tbl2[activated] = var5
    return createElement(str1, tbl2)
end

return PlayButtonUpsellBody
