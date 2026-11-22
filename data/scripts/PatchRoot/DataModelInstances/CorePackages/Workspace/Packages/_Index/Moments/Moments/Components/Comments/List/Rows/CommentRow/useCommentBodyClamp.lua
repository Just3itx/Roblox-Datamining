-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T03:51:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local RunService = game:GetService("RunService")

local Moments = script:FindFirstAncestor("Moments")
local MomentsParent = Moments.Parent

local Foundation = require(MomentsParent.Foundation)
local Localization = require(MomentsParent.Localization)
local React = require(MomentsParent.React)

local escapeRichText = require(Moments.Utils.escapeRichText)
local truncateCommentText = require(script.Parent.truncateCommentText)

local isPointInGuiObjectBounds = Foundation.Utility.isPointInGuiObjectBounds
local useTokens = Foundation.Hooks.useTokens
local useLocalization = Localization.Hooks.useLocalization

local tbl1 = {
    showMore = "Feature.Moments.Action.CommentShowMore",
    showLess = "Feature.Moments.Action.CommentShowLess"
}

local function useCommentBodyClamp(text: string, bool1: boolean)
    local var1 = useTokens()
    local var2 = useLocalization(tbl1)
    local showMore = var2.showMore
    local showLess = var2.showLess
    local var3 = React.useMemo(function()
        local muted = var1.Color.Content.Muted
        local function label(showLess2: string): string -- Luacid: Inlined by compiler; 1 call site recovered
            local var3 = escapeRichText(showLess2)
            return `<font color="#{muted.Color3:ToHex()}" transparency="{muted.Transparency}"><b>{var3}</b></font>`
        end
        local tbl2 = { showMoreSuffix = 0, showLess = 0 }
        local var3 = escapeRichText(showMore)
        tbl2.showMoreSuffix = `\226\128\166 {`<font color="#{muted.Color3:ToHex()}" transparency="{muted.Transparency}"><b>{var3}</b></font>`}`
        tbl2.showLess = label(showLess)
        return tbl2
    end, { var1, showMore, showLess })
    local showMoreSuffix = var3.showMoreSuffix

    local bodyRef = React.useRef(nil)
    local measureRef = React.useRef(nil)
    local var6 = React.useRef(nil)
    local var7 = React.useRef(nil)
    local var8, var9 = React.useState(nil)
    local collapsedText = if var8 == nil or var8.text ~= text or var8.suffix ~= showMoreSuffix then nil else var8.collapsedText
    local isTruncatable = collapsedText ~= nil

    if collapsedText == nil then
        collapsedText = escapeRichText(text)
    elseif bool1 then
        collapsedText = `{escapeRichText((string.gsub(text, "%s+$", "")))} {var3.showLess}`
    end

    local current = {
        text = text,
        suffix = showMoreSuffix,
        clampedBodyText = if bool1 then if isTruncatable then nil else collapsedText else collapsedText
    }
    local var10 = React.useRef(current)
    var10.current = current

    local var11 = React.useCallback(function()
        local current = measureRef.current

        if current == nil or not current:IsDescendantOf(game) or current.AbsoluteSize.X <= 0 then
            return
        end
        local function measure(currentText: string)
            current.Text = currentText
            return current.TextBounds.Y
        end

        current.Text = "M\nM\nM"
        local var4 = current.TextBounds.Y + 1

        local current2 = var10.current
        local str1 = `{current.AbsoluteSize.X}|{var4}|{current2.suffix}|{current2.text}`
        if str1 ~= var6.current then
            var6.current = str1
            var7.current = var4
            var9({
                text = current2.text,
                suffix = current2.suffix,
                collapsedText = truncateCommentText(current2.text, current2.suffix, var4, measure)
            })
        end

        current.Text = "M\nM\nM"
    end, {})

    local var12 = React.useRef(false)
    local var13 = React.useCallback(function()
        if var12.current then
            return
        end
        var12.current = true
        RunService.Heartbeat:Once(function()
            var12.current = false
            local current = bodyRef.current
            local current2 = var7.current

            if current ~= nil and current2 ~= nil and current.Text == var10.current.clampedBodyText and current2 < current.TextBounds.Y then
                var6.current = nil
            end
            var11()
        end)
    end, { var11 })

    local onBodyAbsoluteSizeChanged = React.useCallback(function(_)
        var13()
    end, { var13 })

    React.useEffect(function()
        local current = measureRef.current
        if current == nil then
            return nil
        end
        local connection = current.AncestryChanged:Connect(function()
            if current:IsDescendantOf(game) then
                var13()
            end
        end)
        return function()
            connection:Disconnect()
        end
    end, { var13 })

    React.useLayoutEffect(function()
        var11()
    end, { var11, text, showMoreSuffix })

    return {
        bodyText = collapsedText,
        bodyRef = bodyRef,
        measureRef = measureRef,
        onBodyAbsoluteSizeChanged = onBodyAbsoluteSizeChanged,
        isTruncatable = isTruncatable,
        containsPoint = React.useCallback(function(vector2: Vector2)
            return isPointInGuiObjectBounds(bodyRef.current, vector2)
        end, {})
    }
end

return useCommentBodyClamp
