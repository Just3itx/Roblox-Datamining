-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:10:46Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Foundation = require(CorePackages.Packages.Foundation)
local React = require(CorePackages.Packages.React)
local VrSpatialUi = require(CorePackages.Workspace.Packages.VrSpatialUi)
local PanelType = VrSpatialUi.Constants.PanelType
local Panel3DInSpatialUI = VrSpatialUi.Panel3DInSpatialUI
local scriptParentParentParent = script.Parent.Parent.Parent
local Unibar = require(scriptParentParentParent.Chrome.ChromeShared.Unibar)
local MenuIcon = require(scriptParentParentParent.TopBar.Components.Presentation.MenuIcon)
local MenuIcon2 = require(scriptParentParentParent.TopBar.ComponentsV2.MenuIcon)
local useSelector = require(CorePackages.Workspace.Packages.RoactUtils).Hooks.RoactRodux.useSelector

local CoreGuiCommon = require(CorePackages.Workspace.Packages.CoreGuiCommon)
local FFlagTopBarSignalizeKeepOutAreas = CoreGuiCommon.Flags.FFlagTopBarSignalizeKeepOutAreas

local InExperienceTopBar = require(CorePackages.Workspace.Packages.InExperienceTopBar)
local ExperienceAgeRatingBadge = require(CorePackages.Workspace.Packages.InExperienceTopBar.ExperienceAgeRatingBadge)
local FFlagExperienceAgeRatingBadge = InExperienceTopBar.Flags.FFlagExperienceAgeRatingBadge
local FFlagShowGameAgeRating = require(CorePackages.Workspace.Packages.SharedFlags).FFlagShowGameAgeRating
local var1 = FFlagExperienceAgeRatingBadge and FFlagShowGameAgeRating
local FFlagTopBarRefactor = InExperienceTopBar.Flags.FFlagTopBarRefactor

local function MenuIconWrapper(arg1)
    local keepOutAreasStore = if FFlagTopBarSignalizeKeepOutAreas then CoreGuiCommon.Stores.GetKeepOutAreasStore(false) else nil

    local iconScale = if useSelector(function(arg2)
        return if arg2 and arg2.displayOptions then arg2.displayOptions.menuOpen else false
    end) then 1.5 else 1
    if FFlagTopBarRefactor then
        return (React.createElement(MenuIcon2, { showBadgeOver12 = arg1.showBadgeOver12 }))
    end
    return (React.createElement(MenuIcon, {
        layout = arg1.layout,
        iconScale = iconScale,
        showBadgeOver12 = arg1.showBadgeOver12,
        onAreaChanged = if FFlagTopBarSignalizeKeepOutAreas then keepOutAreasStore.setKeepOutArea else nil
    }))
end

return React.memo(function(tbl1) -- name: VRBottomUnibar
    local var2 = var1 and tbl1.showBadgeOver12 == true
    local var3 = nil
    local var4 = nil
    local var5 = nil
    if FFlagExperienceAgeRatingBadge and FFlagShowGameAgeRating then
        var3, var4 = React.useBinding(true)
        var5 = React.useCallback(function(arg1)
            var4(arg1.GroupTransparency < 1)
        end, { var4 })
    end
    if not Panel3DInSpatialUI then
        return nil
    end
    local createElement = React.createElement
    local var6 = Panel3DInSpatialUI
    local tbl2 = {
        panelType = PanelType.BottomBar,
        keepVisibleWhenTopBarHidden = if var1 then var2 else nil,
        controlsVisible = if var1 then var3 else nil,
        renderFunction = 0,
        requireCanvasGroup = 0
    }

    function tbl2.renderFunction(vector2: Vector2)
        local createElement2 = React.createElement
        local str1 = if var1 then "CanvasGroup" else "Frame"
        local tbl3 = {
            Name = if var1 then "AnimatablePanelManagedContent" else nil,
            Visible = if var1 then var3 else nil,
            [React.Change.GroupTransparency] = var5,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = if var1 then UDim2.fromOffset(0, vector2.Y) elseif FFlagTopBarRefactor then UDim2.new(1, 0, 0, 0) else UDim2.new(1, 0, 1, 0),
            AutomaticSize = if var1 then Enum.AutomaticSize.X elseif FFlagTopBarRefactor then Enum.AutomaticSize.Y else nil
        }

        local tbl4 = {
            ListLayout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Padding = UDim.new(0, 8)
            }),
            MenuIconFrame = 0,
            UnibarFrame = 0
        }
        local element

        if FFlagTopBarRefactor then
            element = React.createElement(
                Foundation.View,
                {
                    Size = UDim2.new(0, 0, 1, 0),
                    AutomaticSize = Enum.AutomaticSize.X,
                    aspectRatio = {
                        AspectRatio = 1,
                        AspectType = Enum.AspectType.ScaleWithParentSize,
                        DominantAxis = Enum.DominantAxis.Height
                    }
                },
                {
                    MenuIcon = React.createElement(MenuIconWrapper, { layout = 1, showBadgeOver12 = tbl1.showBadgeOver12 and not var2 })
                }
            )
        else
            element = React.createElement(
                "Frame",
                {
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = UDim2.new(0, 0, 1, 0),
                    AutomaticSize = Enum.AutomaticSize.X
                },
                {
                    MenuIcon = React.createElement(MenuIconWrapper, { layout = 1, showBadgeOver12 = tbl1.showBadgeOver12 and not var2 })
                }
            )
        end

        tbl4.MenuIconFrame = element

        tbl4.UnibarFrame = React.createElement(
            "Frame",
            {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.new(0, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.XY
            },
            {
                Unibar = React.createElement(Unibar, {
                    layoutOrder = 1,
                    onAreaChanged = function() end,
                    onMinWidthChanged = function() end
                })
            }
        )
        local controls = createElement2(str1, tbl3, tbl4)

        if not var1 then
            return controls
        end

        local createElement3 = React.createElement
        local str2 = "Frame"
        local tbl5 = {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1)
        }
        local tbl6 = {
            Layout = React.createElement("UIListLayout", {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(0, 8)
            }),
            Controls = controls,
            AgeRating = if var2 then React.createElement(ExperienceAgeRatingBadge, { universeId = tostring(game.GameId), layoutOrder = 1 }) else nil
        }
        return createElement3(str2, tbl5, tbl6)
    end

    tbl2.requireCanvasGroup = not var1
    return createElement(var6, tbl2)
end)
