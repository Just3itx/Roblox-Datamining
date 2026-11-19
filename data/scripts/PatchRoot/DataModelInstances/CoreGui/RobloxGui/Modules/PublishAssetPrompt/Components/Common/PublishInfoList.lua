-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T23:11:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local React = require(CorePackages.Packages.React)
local ItemInfoList = require(CorePackages.Workspace.Packages.ItemDetails).ItemInfoList
local useLocalization = require(CorePackages.Workspace.Packages.Localization).Hooks.useLocalization

local HttpRbxApiService = game:GetService("HttpRbxApiService")
local RobloxGui = game:GetService("CoreGui"):WaitForChild("RobloxGui")
local var1 = require(RobloxGui.Modules.Common.httpRequest)(HttpRbxApiService)

local GetGameNameAndDescription = require(CorePackages.Workspace.Packages.GameDetailRodux).GetGameNameAndDescription

local LocalPlayer = game:GetService("Players").LocalPlayer

local function PublishInfoList(tbl1)
    local var2 = React.useRef(false)

    assert(LocalPlayer, "LocalPlayer must not be nil")
    local localPlayerName = LocalPlayer.Name
    local infoData, var4 = React.useState(nil)
    local typeName = tbl1.typeName
    local layoutOrder = tbl1.LayoutOrder

    local var5 = useLocalization({
        creatorText = "Feature.Catalog.Label.Filter.Creator",
        attributionText = "Feature.Catalog.Label.Attribution",
        typeText = "Feature.Catalog.Label.CategoryType"
    })

    React.useEffect(function()
        var2.current = true
        GetGameNameAndDescription(var1, game.GameId):andThen(function(arg1)
            if var2.current and arg1.Name then
                var4(arg1.Name)
            end
        end)
        return function()
            var2.current = false
        end
    end, {})

    return React.createElement(ItemInfoList, {
        rowData = {
            {
                infoName = var5.creatorText,
                infoData = localPlayerName,
                hasVerifiedBadge = LocalPlayer.HasVerifiedBadge,
                isLoading = localPlayerName == nil,
                Selectable = false
            },
            {
                infoName = var5.attributionText,
                infoData = infoData,
                isLoading = infoData == nil,
                Selectable = false
            },
            {
                infoName = var5.typeText,
                infoData = typeName,
                isLoading = typeName == nil,
                Selectable = false
            }
        },
        LayoutOrder = layoutOrder
    })
end

return PublishInfoList
