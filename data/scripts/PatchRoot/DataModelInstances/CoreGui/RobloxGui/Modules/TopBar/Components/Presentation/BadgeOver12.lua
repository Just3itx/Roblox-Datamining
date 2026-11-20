-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:00:53Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local SignalsReact = require(CorePackages.Packages.SignalsReact)

local AppFonts = require(CorePackages.Workspace.Packages.Style).AppFonts
local useStyle = require(CorePackages.Packages.UIBlox).Core.Style.useStyle
local DataHydration = require(CorePackages.Workspace.Packages.DataHydration)

local getAgeRecommendationStore = DataHydration.Game.getAgeRecommendationStore
local DataStatus = DataHydration.DataHydrationTypes.DataStatus

local FFlagShowGameAgeRating = require(CorePackages.Workspace.Packages.SharedFlags).FFlagShowGameAgeRating
local isSideSheetEnabled = require(CorePackages.Workspace.Packages.InExperienceSideSheetUtils.isSideSheetEnabled)

return function(tbl1)
    local var1 = useStyle()
    local var2 = if FFlagShowGameAgeRating then if isSideSheetEnabled then UDim2.fromOffset(-6, -2) else UDim2.fromOffset(0, 2) else tbl1.position
    local var3

    if FFlagShowGameAgeRating then
        local str1 = tostring(game.GameId)
        local var4 = React.useCallback(function(arg1)
            local var4 = getAgeRecommendationStore(arg1).getAndFetchAgeRecommendation(str1)
            local var5 = var4.status(arg1)

            if var5 == DataStatus.Failed then
                return "12+"
            end

            if var5 == DataStatus.NotReady then
                return nil
            end

            local var6 = var4.data(arg1)
            return var6 and var6.minimumAgeDisplay or "12+"
        end, { str1 })

        var3 = SignalsReact.useSignalState(var4)
        if var3 == nil then
            return nil
        end
    else
        var3 = nil
    end

    local createElement = React.createElement
    local str1 = "TextLabel"
    local tbl2 = {
        AnchorPoint = if FFlagShowGameAgeRating then Vector2.new(0.5, 0) else Vector2.new(0, 1),
        Position = var2,
        Text = var3 or "12+",
        Font = if FFlagShowGameAgeRating then AppFonts.default:getBold() else AppFonts.default:getMedium(),
        TextSize = if FFlagShowGameAgeRating then 12 else 9,
        TextColor3 = var1.Theme.TextEmphasis.Color,
        BackgroundColor3 = var1.Theme.BackgroundUIContrast.Color,
        BackgroundTransparency = 0,
        AutomaticSize = Enum.AutomaticSize.XY,
        LineHeight = 1.25,
        ZIndex = 2
    }

    local tbl3 = {
        Padding = React.createElement("UIPadding", {
            PaddingTop = if FFlagShowGameAgeRating then UDim.new(0, 2) else nil,
            PaddingBottom = if FFlagShowGameAgeRating then UDim.new(0, 2) else nil,
            PaddingLeft = if FFlagShowGameAgeRating then UDim.new(0, 6) else UDim.new(0, 2),
            PaddingRight = if FFlagShowGameAgeRating then UDim.new(0, 6) else UDim.new(0, 2)
        }),
        Shape = React.createElement("UICorner", { CornerRadius = UDim.new(0, 8) })
    }
    return createElement(str1, tbl2, tbl3)
end
