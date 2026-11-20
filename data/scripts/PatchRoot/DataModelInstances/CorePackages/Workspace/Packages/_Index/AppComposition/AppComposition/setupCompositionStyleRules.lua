-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T22:40:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppComposition = script:FindFirstAncestor("AppComposition")
local AppCompositionParent = AppComposition.Parent

local _Foundation = require(AppCompositionParent.Foundation)
local Signals = require(AppCompositionParent.Signals)

local CompositionConfig = require(AppComposition.CompositionConfig)
local AppCompositionEnums = require(AppComposition.AppCompositionEnums)
local CompositionTags = require(AppComposition.CompositionTags)
local getGlobalViewportBreakpoint = require(AppComposition.getGlobalViewportBreakpoint)
local FFlagEnableSplitPane = require(AppCompositionParent.SharedFlags).FFlagEnableSplitPane
local Display = require(AppCompositionParent.Display)

local bool1 = game:DefineFastFlag("LuaAppScaleDetailWidth", false)

local bool2 = game:DefineFastFlag("LuaAppScaleDiscoveryWidth", false)

local Header = CompositionTags.ContentRegion.Header
local Body = CompositionTags.ContentRegion.Body
local Detail = CompositionTags.Layout.Detail
local ClipAtMaxWidth = CompositionTags.Utility.ClipAtMaxWidth
local Root = if FFlagEnableSplitPane then CompositionTags.SupportRegion.Root else nil
local Collapsed = if FFlagEnableSplitPane then CompositionTags.SupportRegion.Collapsed else nil
local var1 = if FFlagEnableSplitPane then "CompositionSupportMinSize" else nil
local var2 = if FFlagEnableSplitPane then "CompositionSupportMaxSize" else nil
local regionOverrides = if FFlagEnableSplitPane then CompositionConfig.getRegionOverrides(AppCompositionEnums.RegionName.SupportRegion) else nil
local tbl1 = {
    [`.{Header}`] = {
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0)
    },
    [`.{Header}::UIPadding`] = {
        PaddingLeft = "$CompositionMargin",
        PaddingRight = "$CompositionMargin"
    },
    [`.{Header}::UISizeConstraint`] = { MaxSize = "$CompositionMaxWidthDiscovery" },
    [`.{Body}`] = {
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.fromScale(0.5, 0)
    },
    [`.{Body}::UIPadding`] = {
        PaddingLeft = "$CompositionMargin",
        PaddingRight = "$CompositionMargin"
    },
    [`.{Body}::UISizeConstraint`] = { MaxSize = "$CompositionMaxWidthDiscovery" },
    [`.{Detail} >> .{Header}::UISizeConstraint`] = { MaxSize = "$CompositionMaxWidthDetail" },
    [`.{Detail} >> .{Body}::UISizeConstraint`] = { MaxSize = "$CompositionMaxWidthDetail" },
    [`.{Body}::StyleQuery #CompositionAtMaxWidthDiscovery`] = {
        MinSize = "$CompositionClipThresholdDiscovery"
    },
    [`.{Body}::StyleQuery #CompositionNotAtMaxWidthDiscovery`] = {
        MaxSize = "$CompositionMaxWidthDiscovery"
    },
    [`@CompositionAtMaxWidthDiscovery >> .{ClipAtMaxWidth}`] = { ClipsDescendants = true },
    [`.{Detail} >> .{Body}::StyleQuery #CompositionAtMaxWidthDetail`] = {
        MinSize = "$CompositionClipThresholdDetail"
    },
    [`.{Detail} >> .{Body}::StyleQuery #CompositionNotAtMaxWidthDetail`] = {
        MaxSize = "$CompositionMaxWidthDetail"
    },
    [`@CompositionAtMaxWidthDetail >> .{ClipAtMaxWidth}`] = { ClipsDescendants = true },
    [`.{Root}`] = FFlagEnableSplitPane
        and regionOverrides
        and regionOverrides.widthScale
        and {
            Size = UDim2.new(regionOverrides.widthScale, 0, 1, 0)
        }
        or nil,
    [`.{Root}::UISizeConstraint`] = FFlagEnableSplitPane and {
        MinSize = "$" .. var1,
        MaxSize = "$" .. var2
    } or nil,
    [`.{Collapsed}`] = FFlagEnableSplitPane and {
        Size = UDim2.new(0, 0, 1, 0)
    } or nil
}

local function applyRules(parent, tbl2)
    for value, value2 in tbl1 do
        local styleRule = Instance.new("StyleRule")
        styleRule.Selector = value
        styleRule.Name = value
        styleRule:SetProperties(value2)
        styleRule.Parent = parent
        table.insert(tbl2, styleRule)
    end
end

local function setupReactiveAttributes(arg1, arg2)
    local computed = Signals.createComputed(function(arg3)
        local globalViewportBreakpoint = getGlobalViewportBreakpoint(arg3)
        return CompositionConfig.getBaseConfig(globalViewportBreakpoint, arg2).margin
    end)

    local computed2 = if FFlagEnableSplitPane then Signals.createComputed(function(arg3)
        local globalViewportBreakpoint = getGlobalViewportBreakpoint(arg3)
        return CompositionConfig.getRegionLayout(AppCompositionEnums.RegionName.SupportRegion, globalViewportBreakpoint, arg2)
    end) else nil

    return Signals.createEffect(function(arg3)
        local offset = computed(arg3)
        local var3 = offset * 2

        arg1:SetAttribute("CompositionMargin", UDim.new(0, offset))
        local var4

        if bool2 or bool1 then
            local displayStore = Display.GetDisplayStore(arg3)
            local var5 = if displayStore.getPlatformScale then displayStore.getPlatformScale(arg3) else 1
            var4 = var5 and var5 > 0 and var5 or 1
        else
            var4 = nil
        end

        arg1:SetAttribute("CompositionMaxWidthDiscovery", Vector2.new((if bool2 then var4 * 1920 else 1920) + var3, math.huge))

        arg1:SetAttribute("CompositionClipThresholdDiscovery", Vector2.new((if bool2 then var4 * 1920 else 1920) + var3, 0))

        arg1:SetAttribute("CompositionMaxWidthDetail", Vector2.new((if bool1 then var4 * 848 else 848) + var3, math.huge))

        arg1:SetAttribute("CompositionClipThresholdDetail", Vector2.new((if bool1 then var4 * 848 else 848) + var3, 0))

        if not FFlagEnableSplitPane then
            return
        end

        local var5 = computed2(arg3)
        local displayStore = Display.GetDisplayStore(arg3)
        local var6 = if displayStore.getPlatformScale then displayStore.getPlatformScale(arg3) else 1
        local var7 = var6 and var6 ~= 0 and var6 or 1

        arg1:SetAttribute(var1, Vector2.new((var5.minWidth or 0) * var7, 0))
        arg1:SetAttribute(var2, Vector2.new((var5.maxWidth or math.huge) * var7, math.huge))
    end)
end

local function setupCompositionStyleRules(arg1, arg2)
    local tbl2 = {}

    applyRules(arg1, tbl2)

    local var3 = setupReactiveAttributes(arg1, arg2)

    return function()
        var3()
        for _, value in tbl2 do
            value:Destroy()
        end
    end
end

return setupCompositionStyleRules
